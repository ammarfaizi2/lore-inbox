Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265383AbUFBXx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUFBXx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265382AbUFBXx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:53:29 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:47889 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S265383AbUFBXxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:53:23 -0400
To: akpm@osdl.org
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: [PATCH] Use decimal instead of hex for EDD values
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
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gd64h7cf9.fsf@patl=users.sf.net>
Date: 02 Jun 2004 19:53:23 -0400
In-Reply-To: <20040602150051.GA3165@lists.us.dell.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Matt Domsch <Matt_Domsch@dell.com> writes:

> Whatever, scanf works with either representation.  Patrick, if
> you're changing the above, feel free to submit a second patch to
> switch these all to %u instead.

OK, the attached patch causes the EDD module to export numeric values
as decimal instead of hex, with two exceptions.  I left "version"
alone since 0x21 (for example) actually means version 2.1.  And I left
"mbr_signature" alone since hex seems the more natural representation
for something which is literally just a sequence of four bytes.

So this patch changes default_cylinders, default_heads,
default_sectors_per_track, legacy_max_cylinder, legacy_max_head,
legacy_sectors_per_track, and sectors to decimal.  It depends upon the
other patch I just sent (renaming the three legacy_* fields).

 - Pat


--=-=-=
Content-Disposition: attachment; filename=edd_decimal.txt
Content-Description: edd_decimal.txt

--- linux-2.6.6-renamed/drivers/firmware/edd.c	2004-06-02 19:17:26.000000000 -0400
+++ linux-2.6.6/drivers/firmware/edd.c	2004-06-02 19:42:25.000000000 -0400
@@ -344,7 +344,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_max_cylinder);
+	p += snprintf(p, left, "%u\n", info->legacy_max_cylinder);
 	return (p - buf);
 }
 
@@ -359,7 +359,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_max_head);
+	p += snprintf(p, left, "%u\n", info->legacy_max_head);
 	return (p - buf);
 }
 
@@ -374,7 +374,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += snprintf(p, left, "0x%x\n", info->legacy_sectors_per_track);
+	p += snprintf(p, left, "%u\n", info->legacy_sectors_per_track);
 	return (p - buf);
 }
 
@@ -389,7 +389,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += scnprintf(p, left, "0x%x\n", info->params.num_default_cylinders);
+	p += scnprintf(p, left, "%u\n", info->params.num_default_cylinders);
 	return (p - buf);
 }
 
@@ -404,7 +404,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += scnprintf(p, left, "0x%x\n", info->params.num_default_heads);
+	p += scnprintf(p, left, "%u\n", info->params.num_default_heads);
 	return (p - buf);
 }
 
@@ -419,7 +419,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += scnprintf(p, left, "0x%x\n", info->params.sectors_per_track);
+	p += scnprintf(p, left, "%u\n", info->params.sectors_per_track);
 	return (p - buf);
 }
 
@@ -434,7 +434,7 @@
 	if (!info || !buf)
 		return -EINVAL;
 
-	p += scnprintf(p, left, "0x%llx\n", info->params.number_of_sectors);
+	p += scnprintf(p, left, "%llu\n", info->params.number_of_sectors);
 	return (p - buf);
 }
 

--=-=-=--
