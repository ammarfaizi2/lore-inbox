Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271746AbTG2OyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271749AbTG2OyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:54:20 -0400
Received: from www.13thfloor.at ([212.16.59.250]:48547 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271746AbTG2OyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:54:17 -0400
Date: Tue, 29 Jul 2003 16:54:25 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.22-pre4: devfs on initrd stays busy after pivot_root
Message-ID: <20030729145421.GA24395@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Andreas Haumer <andreas@xss.co.at>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva> <3F267FD7.4040400@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F267FD7.4040400@xss.co.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 04:08:23PM +0200, Andreas Haumer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> 
> Marcelo Tosatti wrote:
> > Hi,
> >
> > Here goes -pre4. It contains a lot of updates and fixes.
> >
> > We decided to include this new code quota code which allows usage of
> > quotas with 32bit UID/GIDs.
> >
> > Most Toshibas should work now due to an important ACPI fix.
> >
> > Please help and test.
> >
> Beginning with 2.4.22-pre4 I can't unmount devfs on my
> initial ramdisk anymore because of EBUSY
> 
> I use initrd and let the kernel mount devfs on /dev on boot.
> I then set up all the drivers needed to mount the real root
> device, do a "pivot_root" and continue with /sbin/init,
> just like it is described in Documentation/initrd.txt
> 
> When the boot process is finished, filesystems are mounted as
> follows:
> 
> root@install:~ {520} $ mount
> rootfs on / type rootfs (rw)
> /dev/root on /initrd type romfs (ro)
> none on /initrd/dev type devfs (rw)
> /dev/ide/host0/bus0/target0/lun0/part3 on / type ext2 (rw)
> devfs on /dev type devfs (rw)
> proc on /proc type proc (rw)
> 
> I then want to get rid of everything mounted under /initrd
> 
> root@install:~ {521} $ umount /initrd/dev
> umount: /initrd/dev: device is busy
> 
> This used to work just fine with 2.4.21 and 2.4.22-pre[123]
> 
> It does not work with 2.4.22-pre4 and 2.4.22-pre8
> Also, with linux-2.4.21-ac4 unmounting /initrd/dev
> does not work.
> 
> I made a diff between pre3 and pre4 and some changes in
> fs/exec.c, fs/binfmt_elf.c and kernel/fork.c (around new
> function "unshare_files()") look suspicious to me. I find
> these changes in both 2.4.21-ac4 and 2.4.22-pre4 patchset
> (but I'm not a kernel hacker, so I might be wrong)
> 
> Any idea anyone?

there is an update of devfs available since 2.4.20 or
so, but it hasn't made it in the marcelo tree yet

I don't remember the original path, but it was in
one of Richard Goochs directories on kernel.org,
anyway, you can grab it from the following url:

http://www.13thfloor.at/VServer/patches-2.4.22-p7c17/04_devfs-patch-v199.17.diff.bz2

I don't know if this solves your problems or not, but
I use this patch since it is available, and had no 
issues with devfs, so I would suggest you give it a try ...

best,
Herbert

> - - andreas
> 
> - --
> Andreas Haumer                     | mailto:andreas@xss.co.at
> *x Software + Systeme              | http://www.xss.co.at/
> Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
> 
> iD8DBQE/Jn/MxJmyeGcXPhERApunAKCIUOiZh8kSaeJEXHwj06yBlvMnhQCfe9M3
> hfmnS3VtpDx5sCMq5nlJLmU=
> =1Tnh
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
