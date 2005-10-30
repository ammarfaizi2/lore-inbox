Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVJ3WTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVJ3WTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVJ3WTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:19:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932364AbVJ3WTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:19:49 -0500
Date: Sun, 30 Oct 2005 14:19:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: larry.finger@att.net (Larry.Finger@lwfinger.net)
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Broken "make install" in 2.6.14-git1
Message-Id: <20051030141914.51033f02.akpm@osdl.org>
In-Reply-To: <103020052203.28455.436543310008FB9900006F2721603759649D0A09020700D2979D9D0E04@att.net>
References: <103020052203.28455.436543310008FB9900006F2721603759649D0A09020700D2979D9D0E04@att.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

larry.finger@att.net (Larry.Finger@lwfinger.net) wrote:
>
>  -------------- Original message ----------------------
> From: Andrew Morton <akpm@osdl.org>
> > larry.finger@att.net (Larry.Finger@lwfinger.net) wrote:
> > >
> > > The changes introduced the commit 596c96ba05e5d56e72451e02f93f4e15e17458df 
> > break the initrd building step of the "make install" process. The console output 
> > is as follows:
> > 
> > I'm unable to locate that commit, perhaps due to a local lack of gittiness.
> > 
> > Can you describe the patch less cryptically?
> > 
> 
> I'm not very good with git. All that bisect visualize shows for the patch is the following:
> 
> Author: Linus Torvalds <torvalds@g5.osdl.org>  2005-10-29 16:02:16
> Committer: Linus Torvalds <torvalds@g5.osdl.org>  2005-10-29 16:02:16
> Parent: e9d52234e35b27ea4ea5f2ab64ca47b1a0c740ab (Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus)
> 
> Obviously, it consists of a number of patches, but I don't know how to elaborate. Is there some git command to get the full description?

Yes, that's a sort of empty marker which indicates the point at which Linus
merged the MIPS git tree.  It's rather bad of git-bisect if it told you
that this was offending patch.

> > > >sudo make install
> > >   CHK     include/linux/version.h
> > >   CHK     include/linux/compile.h
> > >   SKIPPED include/linux/compile.h
> > >   CHK     usr/initramfs_list
> > > Kernel: arch/i386/boot/bzImage is ready  (#97)
> > > sh /home/finger/kernel/linux/arch/i386/boot/install.sh 2.6.14-g596c96ba 
> > arch/i386/boot/bzImage System.map "/boot"
> > > Root device:    /dev/hda6 (mounted on / as reiserfs)
> > > Module list:    via82cxxx processor thermal fan reiserfs
> > > 
> > > Kernel image:   /boot/vmlinuz-2.6.14-g596c96ba
> > > Initrd image:   /boot/initrd-2.6.14-g596c96ba
> > > Shared libs:    lib/ld-2.3.5.so lib/libblkid.so.1.0 lib/libc-2.3.5.so 
> > lib/libselinux.so.1 lib/libuuid.so.1.2
> > > Driver modules: via82cxxx processor thermal fan reiserfs
> > > Filesystem modules:
> > > Including:      klibc initramfs udev fsck.reiserfs
> > > Bootsplash:     SuSE (1024x768)
> > > 8358 blocks
> > > no record for '/block/hdc/uevent' in database
> > > Use of uninitialized value in scalar chomp at 
> > > /usr/lib/perl5/vendor_perl/5.8.7/Bootloader/Tools.pm line 139.
> > > Use of uninitialized value in concatenation (.) or string at 
> > /usr/lib/perl5/vendor_perl/5.8.7/Bootloader/Tools.pm line 140.
> > > ......
> > > 
> > > I used git bisect to localize the bad commit. I also observed that if the 
> > kernel created /sys/block/hdc/uevent, it failed. If this "file" does not exist, 
> > the install worked.
> > 
> > What does "it failed" mean?   Is this the same bug, or a different one?
> 
> Same bug. _make install_ fails if the uevent files are present. Sorry for the imprecision.
> 

I don't know what'a happening here.  What program is saying "no record for
'/block/hdc/uevent' in database"?
