Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWBGQI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWBGQI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWBGQI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:08:27 -0500
Received: from soohrt.org ([85.131.246.150]:13978 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S965147AbWBGQI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:08:26 -0500
Date: Tue, 7 Feb 2006 17:08:19 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel@vger.kernel.org
Cc: Hans Reiser <reiser@namesys.com>, Vitaly Fertman <vitaly@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [BUG] reiserfs/super.c commit breaks boot process in stable and HEAD
Message-ID: <20060207160819.GR22994@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>,
	Vitaly Fertman <vitaly@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm observing an instant reboot while booting current stable or HEAD
kernels since a recent ReiserFS commit. Details and temporary fix below.

Kind regards,
 Horst Schirmeier


[1.] One line summary of the problem:
reiserfs change leads to instant reboot while in boot process

[2.] Full description of the problem/report:
The mainline commit d35c602870ece3166cff3d25fbc687a7f707acf3
("[PATCH] Someone broke reiserfs v3 mount options and this fixes it")
breaks the boot process for me and leads to an instant reboot.
Unfortunately this commit was backported to Greg KH's stable tree
(d1753372c3c16c9cfb88bed7f0278091187053f3), so 2.6.15.2 and .3 show the
same behaviour.

Reverting this commit (though it looks sane at first glance) makes both
the stable and HEAD kernels boot again.

The "Warning: unable to open an initial console." message is emitted
after sys_open((const char __user *) "/dev/console", O_RDWR, 0)) in
init/main.c fails; adding some debugging code revealed that sys_open
actually returns -13 as an error code, which I can't make very much of.


[3.] Keywords (i.e., modules, networking, kernel):
instant reboot, reiserfs, fs/reiserfs/super.c

[4.] Kernel version (from /proc/version):
Linux version 2.6.16-rc2-gc03296a8-dirty (root@nexus) (gcc version 3.4.4
(Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #3 PREEMPT Tue Feb 7
15:15:56 CET 2006
(-dirty is only due to the reverted commit)

[5.] Most recent kernel version which did not have the bug:
2.6.15.1, 2.6.16-rc2

[6.] Output of Oops (copied by hand from analog screenshot)
[...]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 248k freed
Warning: unable to open an initial console.
md: stopping all md devices.
md: md0 switched to read-only mode.
<at this point, the machine reboots after about one second>

Screenshot at
http://wwwcip.informatik.uni-erlangen.de/~sihoschi/reiserfs-instant-reboot-screenshot.png

[9.] Config file
At
http://wwwcip.informatik.uni-erlangen.de/~sihoschi/reiserfs-instant-reboot-config.txt

OOPS Reporting Tool v.ltg1
www.wsi.edu.pl/~piotrowskim/files/ort/ltg/

-- 
PGP-Key 0xD40E0E7A
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
