Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSCSR5D>; Tue, 19 Mar 2002 12:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSCSR4x>; Tue, 19 Mar 2002 12:56:53 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51442
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S284933AbSCSR4p>; Tue, 19 Mar 2002 12:56:45 -0500
Date: Tue, 19 Mar 2002 09:57:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: H?kon Alstadheim <hakon@cyberglobe.net>
Cc: Andrew Morton <akpm@zip.com.au>, Colin Leroy <colin@colino.net>,
        linux-kernel@vger.kernel.org
Subject: Re: question about 2.4.18 and ext3
Message-ID: <20020319175757.GO2254@matchmail.com>
Mail-Followup-To: H?kon Alstadheim <hakon@cyberglobe.net>,
	Andrew Morton <akpm@zip.com.au>, Colin Leroy <colin@colino.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020318180158.2886dd4a.colin@colino.net> <3C96510A.24CDE6BC@zip.com.au> <m0r8mhq9a8.fsf@alstadhome.online.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 08:57:51AM +0100, H?kon Alstadheim wrote:
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > Colin Leroy wrote:
> > > 
> > > Hello all,
> > > 
> > > I really hope I'm not asking a FAQ, i looked in the archives since 15 Feb
> > > and didn't see anything about this.
> > > 
> > > I upgraded from 2.2.20 to 2.4.18 on my powerbook two weeks ago, and
> > > compiled ext3 in the kernel in order to quietly crash :)
> > > 
> > > However, I had about a dozen strange crashes, sometimes when the computer
> > > woke up from sleep, sometimes when launching a program : every visible
> > > soft died, then X, then blackscreen, and the computer didn't even answer
> > > pings. So I reset the computer and here, each time, yaboot (ppc equivalent
> > > of lilo) told me that "cannot load image". Booting and fscking from a
> > > rescue CD showed that superblock was corrupt.
> > 
> > It may be a yaboot/ext3 incompatibility.  Your version of yaboot
> > may not know how to mount a needs-recovery ext3 filesystem.
> > There are some words on this at
> > http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html
> > 
> > I am told that yaboot 1.3.5 and later will do the right thing.
> > What version are you using?
> 
> One way to work around this is to keep your kernels in /boot and have
> /boot be a separate ext2 filesystem that you normally mount ro. That
> way it will not need to be recovered after a crash. During install of
> a new kernel you will of course need to do "/bin/mount -o remount,rw
> /boot" and then afterwards "/bin/mount -o remount,ro /boot" .
> 
> Your /etc/fstab will then look something like:
> 
> [...]
> /dev/hde3 /      ext3 # your usual parameters here
> /dev/hda6 /boot  ext2 ro,exec   1   2
> [...]
> 
> Remember to make sure you know which devices are / and /boot/
> respectively, and also which device holds the bootsector. Make sure
> you know which one to give to your bootloader where.
> 
> I run grub-install like this:
> /usr/local/sbin/grub-install /dev/hda --root-directory=/boot

Grub won't work on ppc IIRC, but it does work similarly by reading the
filesystem.
