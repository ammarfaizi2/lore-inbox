Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274254AbRISXGt>; Wed, 19 Sep 2001 19:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274256AbRISXGl>; Wed, 19 Sep 2001 19:06:41 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:54779 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274254AbRISXG3>; Wed, 19 Sep 2001 19:06:29 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 19 Sep 2001 17:06:06 -0600
To: Mark Swanson <swansma@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Request: removal of fs/fs.h/super_block.u to enable partition locking
Message-ID: <20010919170606.S14526@turbolinux.com>
Mail-Followup-To: Mark Swanson <swansma@yahoo.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E15jn1X-0003cU-00@the-village.bc.nu> <3BA8F6EC.E3D73C87@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA8F6EC.E3D73C87@yahoo.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2001  15:50 -0400, Mark Swanson wrote:
> > However you don't need to remove anything for that
> 
> But I can't distribute the file fs with my application, because I can't
> expect my user base to patch and recompile their kernel just so they can
> run my application.
> 
> Perhaps what is needed is an 'inuse' filesystem or a way to make 
> filesystem modules without patching the kernel. 

You don't need to patch the kernel to add a new filesystem type.  It
is possible to just use "&inode->u.generic_ip" as your filesystem
private inode storage (if you actually need any, which is unlikely with
such a simple filesystem).  All of the other VFS interfaces are exported
to modules, so it is possible to just insert a module to add your fs
type.

When I was doing this (compiling a filesystem that is not part of the
kernel), we used the pcmcia-cs configure scripts to get all of the
relevant kernel config options.  This can be done on a running kernel
without having the actual kernel sources, and if you do this as part
of the startup for your application, you can cache the kernel version
string (from /proc/version) to ensure that the module is always OK
for the current kernel.

Of course, if your code is good enough it may just make it into the
kernel.

> My concern is that ordinary tools like mount check the proc filesystem
> to see if a partition is already mounted and it seems likely that tools
> like mke2fs do this too. Sysadmins might feel that existing tools
> protect them from damaging something in use. I'm looking for a way to
> follow this general behavior with raw partitions.

You are correct.  mke2fs refuses to run on a device where a filesystem
appears to be mounted (either in /proc/mounts or /etc/mtab), unless
you force it to do so.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

