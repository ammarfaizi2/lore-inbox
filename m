Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310646AbSCSLQf>; Tue, 19 Mar 2002 06:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310647AbSCSLQZ>; Tue, 19 Mar 2002 06:16:25 -0500
Received: from mail49-s.fg.online.no ([148.122.161.49]:12421 "EHLO
	mail49.fg.online.no") by vger.kernel.org with ESMTP
	id <S310646AbSCSLQO>; Tue, 19 Mar 2002 06:16:14 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Colin Leroy <colin@colino.net>, linux-kernel@vger.kernel.org
Subject: Re: question about 2.4.18 and ext3
In-Reply-To: <20020318180158.2886dd4a.colin@colino.net>
	<3C96510A.24CDE6BC@zip.com.au>
From: hakon@cyberglobe.net (=?iso-8859-1?q?H=E5kon?= Alstadheim)
Date: 19 Mar 2002 08:57:51 +0100
Message-ID: <m0r8mhq9a8.fsf@alstadhome.online.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Colin Leroy wrote:
> > 
> > Hello all,
> > 
> > I really hope I'm not asking a FAQ, i looked in the archives since 15 Feb
> > and didn't see anything about this.
> > 
> > I upgraded from 2.2.20 to 2.4.18 on my powerbook two weeks ago, and
> > compiled ext3 in the kernel in order to quietly crash :)
> > 
> > However, I had about a dozen strange crashes, sometimes when the computer
> > woke up from sleep, sometimes when launching a program : every visible
> > soft died, then X, then blackscreen, and the computer didn't even answer
> > pings. So I reset the computer and here, each time, yaboot (ppc equivalent
> > of lilo) told me that "cannot load image". Booting and fscking from a
> > rescue CD showed that superblock was corrupt.
> 
> It may be a yaboot/ext3 incompatibility.  Your version of yaboot
> may not know how to mount a needs-recovery ext3 filesystem.
> There are some words on this at
> http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html
> 
> I am told that yaboot 1.3.5 and later will do the right thing.
> What version are you using?

One way to work around this is to keep your kernels in /boot and have
/boot be a separate ext2 filesystem that you normally mount ro. That
way it will not need to be recovered after a crash. During install of
a new kernel you will of course need to do "/bin/mount -o remount,rw
/boot" and then afterwards "/bin/mount -o remount,ro /boot" .

Your /etc/fstab will then look something like:

[...]
/dev/hde3 /      ext3 # your usual parameters here
/dev/hda6 /boot  ext2 ro,exec   1   2
[...]

Remember to make sure you know which devices are / and /boot/
respectively, and also which device holds the bootsector. Make sure
you know which one to give to your bootloader where.

I run grub-install like this:
/usr/local/sbin/grub-install /dev/hda --root-directory=/boot

Which tells grub to install its loader into the MBR of my first hd,
and then look for the kernel and the second stage boot-loader on
/dev/hda6 (which is mounted as /boot/). I seem to remember that grub
copied the files it needed into /boot/boot/grub/ itself. It looks
funny, but I left it at that.

-- 
Håkon Alstadheim, hjemmepappa.
