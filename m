Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUFBVXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUFBVXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUFBVXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:23:00 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:28943 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S264175AbUFBVWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:22:52 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5ghdttlkvg.fsf@patl=users.sf.net>
To: akpm@osdl.org
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Better names for EDD legacy_* fields
References: <20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
	<s5gaczonzej.fsf@patl=users.sf.net>
	<20040531170347.425c2584.seanlkml@sympatico.ca>
	<s5gfz9f2vok.fsf@patl=users.sf.net>
	<20040601235505.GA23408@apps.cwi.nl>
	<s5gpt8ijf1g.fsf@patl=users.sf.net>
	<20040602150051.GA3165@lists.us.dell.com>
Date: 02 Jun 2004 17:22:50 -0400
In-Reply-To: <20040602150051.GA3165@lists.us.dell.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Matt Domsch <Matt_Domsch@dell.com> writes:

> On Wed, Jun 02, 2004 at 09:02:23AM -0400, Patrick J. LoPresti wrote:
> > Andries Brouwer <Andries.Brouwer@cwi.nl> writes:
> > > Please, now that this is still unused, fix your names and/or
> > > your code. Names could be legacy_max_head (etc.) if you want
> > > to keep the values, or otherwise add 1 to the values.
> > 
> > Well, the EDD module belongs to Matt Domsch.  I only contributed the
> > "legacy_*" code and names.
> > 
> > If it is OK with Matt, I agree we should rename legacy_heads to
> > legacy_max_head and legacy_sectors to legacy_sectors_per_track.  I
> > doubt anybody other than myself is using these yet anyway.
> 
> Yes, please submit a patch now to Andrew, cc: me and linux-kernel at
> least.   I've confirmed that our internal tools are not using these
> fields yet.

Trivial (search & replace) patch against 2.6.6 is attached.  This
renames legacy_heads to legacy_max_head legacy_sectors to
legacy_sectors_per_track.

 - Pat


--=-=-=
Content-Disposition: attachment; filename=rename_edd_legacy.txt
Content-Description: rename_edd_legacy.txt

diff -u -r linux-2.6.6-orig/drivers/firmware/edd.c linux-2.6.6/drivers/firmware/edd.c
--- linux-2.6.6-orig/drivers/firmware/edd.c	2004-05-09 22:32:27.000000000 -0400
+++ linux-2.6.6/drivers/firmware/edd.c	2004-06-02 16:15:11.000000000 -0400
@@ -349,7 +349,7 @@
 }
 
 static ssize_t
-edd_show_legacy_heads(struct edd_device *edev, char *buf)
+edd_show_legacy_max_head(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info;
 	char *p = buf;
@@ -359,12 +359,12 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_heads);
+	p += snprintf(p, left, "0x%x\n", info->legacy_max_head);
 	return (p - buf);
 }
 
 static ssize_t
-edd_show_legacy_sectors(struct edd_device *edev, char *buf)
+edd_show_legacy_sectors_per_track(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info;
 	char *p = buf;
@@ -374,7 +374,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_sectors);
+	p += snprintf(p, left, "0x%x\n", info->legacy_sectors_per_track);
 	return (p - buf);
 }
 
@@ -462,7 +462,7 @@
 }
 
 static int
-edd_has_legacy_heads(struct edd_device *edev)
+edd_has_legacy_max_head(struct edd_device *edev)
 {
 	struct edd_info *info;
 	if (!edev)
@@ -470,11 +470,11 @@
 	info = edd_dev_get_info(edev);
 	if (!info)
 		return -EINVAL;
-	return info->legacy_heads > 0;
+	return info->legacy_max_head > 0;
 }
 
 static int
-edd_has_legacy_sectors(struct edd_device *edev)
+edd_has_legacy_sectors_per_track(struct edd_device *edev)
 {
 	struct edd_info *info;
 	if (!edev)
@@ -482,7 +482,7 @@
 	info = edd_dev_get_info(edev);
 	if (!info)
 		return -EINVAL;
-	return info->legacy_sectors > 0;
+	return info->legacy_sectors_per_track > 0;
 }
 
 static int
@@ -571,10 +571,11 @@
 static EDD_DEVICE_ATTR(sectors, 0444, edd_show_sectors, NULL);
 static EDD_DEVICE_ATTR(legacy_cylinders, 0444, edd_show_legacy_cylinders,
 		       edd_has_legacy_cylinders);
-static EDD_DEVICE_ATTR(legacy_heads, 0444, edd_show_legacy_heads,
-		       edd_has_legacy_heads);
-static EDD_DEVICE_ATTR(legacy_sectors, 0444, edd_show_legacy_sectors,
-		       edd_has_legacy_sectors);
+static EDD_DEVICE_ATTR(legacy_max_head, 0444, edd_show_legacy_max_head,
+		       edd_has_legacy_max_head);
+static EDD_DEVICE_ATTR(legacy_sectors_per_track, 0444,
+                       edd_show_legacy_sectors_per_track,
+		       edd_has_legacy_sectors_per_track);
 static EDD_DEVICE_ATTR(default_cylinders, 0444, edd_show_default_cylinders,
 		       edd_has_default_cylinders);
 static EDD_DEVICE_ATTR(default_heads, 0444, edd_show_default_heads,
@@ -602,8 +603,8 @@
 /* These attributes are conditional and only added for some devices. */
 static struct edd_attribute * edd_attrs[] = {
 	&edd_attr_legacy_cylinders,
-	&edd_attr_legacy_heads,
-	&edd_attr_legacy_sectors,
+	&edd_attr_legacy_max_head,
+	&edd_attr_legacy_sectors_per_track,
 	&edd_attr_default_cylinders,
 	&edd_attr_default_heads,
 	&edd_attr_default_sectors_per_track,
diff -u -r linux-2.6.6-orig/include/linux/edd.h linux-2.6.6/include/linux/edd.h
--- linux-2.6.6-orig/include/linux/edd.h	2004-06-02 16:12:17.000000000 -0400
+++ linux-2.6.6/include/linux/edd.h	2004-06-02 16:12:49.000000000 -0400
@@ -167,8 +167,8 @@
 	u8 version;
 	u16 interface_support;
 	u16 legacy_cylinders;
-	u8 legacy_heads;
-	u8 legacy_sectors;
+	u8 legacy_max_head;
+	u8 legacy_sectors_per_track;
 	struct edd_device_params params;
 } __attribute__ ((packed));

--=-=-=--
