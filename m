Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132838AbQLJCjU>; Sat, 9 Dec 2000 21:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbQLJCjK>; Sat, 9 Dec 2000 21:39:10 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:18732 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S132838AbQLJCiz>; Sat, 9 Dec 2000 21:38:55 -0500
Message-Id: <200012100208.eBA28GZ17065@emu.os2.ami.com.au>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.0-test11 does not build: 
In-Reply-To: Your message of "Sat, 09 Dec 2000 18:33:33 EST."
             <Pine.LNX.4.30.0012091832330.620-100000@asdf.capslock.lan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Dec 2000 10:08:22 +0800
From: John Summerfield <summer@OS2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mharris@opensourceadvocate.org said:
>  Try doing a "make distclean" or "make mrproper" first.  Are you using
> kgcc? 

Neither works. I'm using gcc 2.95-3 on RHL 6.2

In desperation, I removed the source tree and started afresh from test1.

These are the commands I used:


[summer@possum src]$ cat reinstall
#!/bin/bash
set -ex
cd /usr/src
rm -rf linux
tar Ixf /u03/kernels/patches/linux-2.4.0-test1.tar.bz2
dir -1rt `find /u03/kernels/patches/ -name patch-2.4.0-t\*.gz -newer 
/u03/kernels/patches/patch-2.4.0-test1.gz` | xargs --max-lines=1 gzip -dc | 
patch -p0
find linux -name \*.rej
cd linux
make mrproper
cp /u03/kernels/configs/possum-2.4.0-test11.config .config
make dep bzImage modules


and it still did not build.

In a hunch, i tried this:

set -ex
cd /usr/src
rm -rf linux
tar Ixf /u03/kernels/patches/linux-2.4.0-test1.tar.bz2
dir -1rt `find /u03/kernels/patches/ -name patch-2.4.0-t\*.gz -newer 
/u03/kernels/patches/patch-2.4.0-test1.gz` | xargs --max-lines=1 gzip -dc | 
patch -p0
find linux -name \*.rej
cd linux
make mrproper
cp /u03/kernels/configs/possum-2.4.0-test11.config .config
make oldconfig dep bzImage modules

and the oldconfig resulting in me bing asked three questions (and not those 
new in test11).

The result builds.

It seems to me that some of the various "make *config" options have the 
ability to create defective configurations in some circumstances.

I'm off to enjoy my new kernel now;-)




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
