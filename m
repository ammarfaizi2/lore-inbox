Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVJ3WDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVJ3WDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVJ3WDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:03:31 -0500
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:21892 "EHLO
	mtiwmhc11.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1751201AbVJ3WDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:03:31 -0500
From: larry.finger@att.net (Larry.Finger@lwfinger.net)
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broken "make install" in 2.6.14-git1
Date: Sun, 30 Oct 2005 22:03:29 +0000
Message-Id: <103020052203.28455.436543310008FB9900006F2721603759649D0A09020700D2979D9D0E04@att.net>
X-Mailer: AT&T Message Center Version 1 (Feb 14 2005)
X-Authenticated-Sender: bGFycnkuZmluZ2VyQGF0dC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 -------------- Original message ----------------------
From: Andrew Morton <akpm@osdl.org>
> larry.finger@att.net (Larry.Finger@lwfinger.net) wrote:
> >
> > The changes introduced the commit 596c96ba05e5d56e72451e02f93f4e15e17458df 
> break the initrd building step of the "make install" process. The console output 
> is as follows:
> 
> I'm unable to locate that commit, perhaps due to a local lack of gittiness.
> 
> Can you describe the patch less cryptically?
> 

I'm not very good with git. All that bisect visualize shows for the patch is the following:

Author: Linus Torvalds <torvalds@g5.osdl.org>  2005-10-29 16:02:16
Committer: Linus Torvalds <torvalds@g5.osdl.org>  2005-10-29 16:02:16
Parent: e9d52234e35b27ea4ea5f2ab64ca47b1a0c740ab (Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus)

Obviously, it consists of a number of patches, but I don't know how to elaborate. Is there some git command to get the full description?

> > >sudo make install
> >   CHK     include/linux/version.h
> >   CHK     include/linux/compile.h
> >   SKIPPED include/linux/compile.h
> >   CHK     usr/initramfs_list
> > Kernel: arch/i386/boot/bzImage is ready  (#97)
> > sh /home/finger/kernel/linux/arch/i386/boot/install.sh 2.6.14-g596c96ba 
> arch/i386/boot/bzImage System.map "/boot"
> > Root device:    /dev/hda6 (mounted on / as reiserfs)
> > Module list:    via82cxxx processor thermal fan reiserfs
> > 
> > Kernel image:   /boot/vmlinuz-2.6.14-g596c96ba
> > Initrd image:   /boot/initrd-2.6.14-g596c96ba
> > Shared libs:    lib/ld-2.3.5.so lib/libblkid.so.1.0 lib/libc-2.3.5.so 
> lib/libselinux.so.1 lib/libuuid.so.1.2
> > Driver modules: via82cxxx processor thermal fan reiserfs
> > Filesystem modules:
> > Including:      klibc initramfs udev fsck.reiserfs
> > Bootsplash:     SuSE (1024x768)
> > 8358 blocks
> > no record for '/block/hdc/uevent' in database
> > Use of uninitialized value in scalar chomp at 
> > /usr/lib/perl5/vendor_perl/5.8.7/Bootloader/Tools.pm line 139.
> > Use of uninitialized value in concatenation (.) or string at 
> /usr/lib/perl5/vendor_perl/5.8.7/Bootloader/Tools.pm line 140.
> > ......
> > 
> > I used git bisect to localize the bad commit. I also observed that if the 
> kernel created /sys/block/hdc/uevent, it failed. If this "file" does not exist, 
> the install worked.
> 
> What does "it failed" mean?   Is this the same bug, or a different one?

Same bug. _make install_ fails if the uevent files are present. Sorry for the imprecision.

Larry

