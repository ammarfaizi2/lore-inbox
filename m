Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269438AbUJLDHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269438AbUJLDHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUJLDHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:07:02 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:41870 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S269418AbUJLDDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:03:55 -0400
From: David Brownell <david-b@pacbell.net>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: Totally broken PCI PM calls
Date: Mon, 11 Oct 2004 19:59:53 -0700
User-Agent: KMail/1.6.2
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       ncunningham@linuxmail.org
References: <1097455528.25489.9.camel@gaston> <200410111437.17898.david-b@pacbell.net> <416B0557.40407@suse.de>
In-Reply-To: <416B0557.40407@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pi0aBfU9EowZJno"
Message-Id: <200410111959.53048.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_pi0aBfU9EowZJno
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 11 October 2004 3:12 pm, Stefan Seyfried wrote:
> David Brownell wrote:
> 
> > The machines I've tested with relatively generic 2.6.9-rc kernels
> > don't use BIOS support for S4 when I call swsusp.
> 
> first do either
> echo platform > /sys/power/disk     # for S4
> echo shutdown > /sys/power/disk     # for poweroff
> 
> then do
> echo disk > /sys/power/state

Oddly enough, neither of them work lately for me.
They each resume immediately after writing the
image to disk.

- Dave

p.s. I find the /sys/power/disk file mildly cryptic, maybe
    other folk will find the attached patch slightly more
    informative about what this interface can do.




--Boundary-00=_pi0aBfU9EowZJno
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="disk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="disk.patch"

--- 1.19/kernel/power/disk.c	Thu Sep  9 08:45:13 2004
+++ edited/kernel/power/disk.c	Fri Oct  1 11:01:41 2004
@@ -282,7 +282,14 @@
 
 static ssize_t disk_show(struct subsystem * subsys, char * buf)
 {
-	return sprintf(buf,"%s\n",pm_disk_modes[pm_disk_mode]);
+	return sprintf(buf,"%s%s %s%s %s%s\n",
+		(pm_disk_mode == pm_ops->pm_disk_mode) ? "*" : "",
+			pm_disk_modes[pm_ops->pm_disk_mode],
+		(pm_disk_mode == PM_DISK_SHUTDOWN) ? "*" : "",
+			pm_disk_modes[PM_DISK_SHUTDOWN],
+		(pm_disk_mode == PM_DISK_REBOOT) ? "*" : "",
+			pm_disk_modes[PM_DISK_REBOOT]
+		);
 }
 
 

--Boundary-00=_pi0aBfU9EowZJno--
