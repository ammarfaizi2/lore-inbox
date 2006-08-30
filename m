Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWH3J7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWH3J7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWH3J7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:59:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:14273 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750794AbWH3J7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:59:32 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] PM: Add pm_trace switch
Date: Wed, 30 Aug 2006 12:02:59 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>
References: <200608291309.57404.rjw@sisk.pl> <20060829134648.451971a1.akpm@osdl.org>
In-Reply-To: <20060829134648.451971a1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301202.59300.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 22:46, Andrew Morton wrote:
> On Tue, 29 Aug 2006 13:09:57 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +int pm_trace_enabled;
> > +
> > +static ssize_t pm_trace_show(struct subsystem * subsys, char * buf)
> > +{
> > +	return sprintf(buf, "%d\n", pm_trace_enabled);
> > +}
> > +
> > +static ssize_t
> > +pm_trace_store(struct subsystem * subsys, const char * buf, size_t n)
> > +{
> > +	int val;
> > +
> > +	if (sscanf(buf, "%d", &val) == 1) {
> > +		pm_trace_enabled = !!val;
> > +		return n;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> > +power_attr(pm_trace);
> 
> <grumbles about documentation>

Well, this is the most difficult part. ;-)

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/interface.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: linux-2.6.18-rc4-mm3/Documentation/power/interface.txt
===================================================================
--- linux-2.6.18-rc4-mm3.orig/Documentation/power/interface.txt	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc4-mm3/Documentation/power/interface.txt	2006-08-30 11:59:31.000000000 +0200
@@ -52,3 +52,18 @@ suspend image will be as small as possib
 
 Reading from this file will display the current image size limit, which
 is set to 500 MB by default.
+
+/sys/power/pm_trace controls the code which saves the last PM event point in
+the RTC across reboots, so that you can debug a machine that just hangs
+during suspend (or more commonly, during resume).  Namely, the RTC is only
+used to save the last PM event point if this file contains '1'.  Initially it
+contains '0' which may be changed to '1' by writing a string representing a
+nonzero integer into it.
+
+To use this debugging feature you should attempt to suspend the machine, then
+reboot it and run
+
+	dmesg -s 1000000 | grep 'hash matches'
+
+CAUTION: Using it will cause your machine's real-time (CMOS) clock to be
+set to a random invalid time after a resume.
