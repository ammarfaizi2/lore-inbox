Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUIPVS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUIPVS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266357AbUIPVS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:18:56 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:33034 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263448AbUIPVSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:18:52 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
       "'debian-user@lists.debian.org'" <debian-user@lists.debian.org>,
       linuxppc-embedded@lists.linuxppc.org,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: problem with initialization while accessing NFS mounted root file  system during the Linux 2.6 boot
Date: Fri, 17 Sep 2004 00:18:29 +0300
User-Agent: KMail/1.5.4
References: <313680C9A886D511A06000204840E1CF0A647182@whq-msgusr-02.pit.comms.marconi.com>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A647182@whq-msgusr-02.pit.comms.marconi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409170018.29445.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 21:23, Povolotsky, Alexander wrote:
> > Hi,
> >
> > I've managed to program U-boot bootloader and now am trying to boot my
> > PQ2FADS-VR board " vanilla" with Linux 2.6.8-rc4 ...but I have problem
> > with the  initialization while accessing NFS mounted root file system ...
> > .
> >
> > I have NFS server running on my Windows XP Laptop (that is all I am
> > allowed to have, no Linux hosts machine available to me ...). I copied
> > entire "fadsroot" directory from Arabella's CD-ROM into my "fadsroot"
> > directory on my D-drive and made this directory nfs-shared-mountable (I
> > have propagated permissions from "fadsroot" down to all subfolders within
> > "fadsroot" ...).

Windows NFS server... ugh...

> > I noticed several errors during the copy process - complaining that I am
> > over-writing the files being already copied - is it an issue with "letter
> > case" ? - are there files on the Arabella's CD-ROM "fadsroot", which have
> > same names but differ just in the letter case used ?
>
> What file system support I need to configure while bulding the kernel for
> such case ?
>
> > Anyway I am getting the following error during the end of the boot:
> > ......
> > device=eth0, addr=192.168.1.103, mask=255.255.255.0, gw=255.255.255.255,
> > host=192.168.1.103, domain=, nis-domain=(none),
> > bootserver=255.255.255.255, rootserver=192.168.1.100, rootpath=
> > Looking up port of RPC 100003/2 on 192.168.1.100
> > Looking up port of RPC 100005/1 on 192.168.1.100
> > VFS: Mounted root (nfs filesystem).
> > Freeing unused kernel memory: 272k init
> > Warning: unable to open an initial console.

/dev/console doesn't exist. No wonder. Windows NFS server
can't provide device nodes, I suspect. Use devfs, or
better still, use initrd (see below).

> > Kernel panic: No init found.  Try passing init= option to kernel.
> >  <0>Rebooting in 180 seconds..
> >
> > My U-boot environment is:
> > => printenv
> > bootdelay=5
> > bootcmd=bootm 200000
> > ipaddr=192.168.1.103
> > serverip=192.168.1.100
> > ethaddr=08:00:17:00:00:03
> > bootargs=root /dev/nfs rw nfsroot=192.168.1.100:/home/apovolot/fadsroot
> > baudrate=19200
> > stdin=serial
> > stdout=serial
> > stderr=serial
> >
> > Any ideas ?

I am using initrd for early userspace & NFS root mount.
Initrd allows me to do various non-trivial setup tricks
before I exec init.

Also I can troubleshoot stuff by booting with
init=/bin/sh (launches busybox shell in initrd)
instead of init=/linuxrc

My initrd image is at work. Do you want me to send
it to you tomorrow?
--
vda

