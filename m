Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315518AbSECERr>; Fri, 3 May 2002 00:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315541AbSECERq>; Fri, 3 May 2002 00:17:46 -0400
Received: from air-2.osdl.org ([65.201.151.6]:5 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S315518AbSECERq>;
	Fri, 3 May 2002 00:17:46 -0400
Date: Thu, 2 May 2002 21:17:43 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <20507.1020263013@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33L2.0205022102570.11832-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith-

On Thu, 2 May 2002, Keith Owens wrote:

[snipped]

| Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
| It is faster, better documented, easier to write build rules in, has
| better install facilities, allows separate source and object trees, can
| do concurrent builds from the same source tree and is significantly
| more accurate than the existing kernel build system.

I kinda like to do 'make bzImage' without making modules also.
Would that be difficult to do in kbuild 2.5?
Oh, but then I would also (still) need 'make modules'...

| Before I send you the kbuild 2.5 patch, how do you want to handle it?
|
| * Coexist with the existing kernel build for one or two releases or
|   delete the old build system when kbuild 2.5 goes in?
|
|   Coexistence for a few days gives a backout, just in case.  It also
|   gives a kernel release where the old and new code can be compared,
|   useful for architectures that have not been converted yet.

So is there a downside to the coexisting method?
If not, let's do it.  (One reason: see below.)

| I would like kbuild 2.5 to go in in the near future.  Keeping up to
| date with kernel changes is a significant effort, Makefiles change all
| the time, especially when major subsystems like sound and usb are
| reorganised.  There are also some changes to architecture code to do it
| right under kbuild 2.5 and tracking those against kernel changes can be
| painful.

For sure.

Any ideas about this error?  user error??

$ make oldconfig menuconfig

... and then

[rddunlap@midway linux-2513-pv]$ make -f Makefile-2.5
spec value %p not found
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc
-E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
Error: The CML input files have changed since .config was created.
       Always make one of xconfig menuconfig oldconfig defconfig
config randconfig allyes allno allmod after changing CML files
make: *** [/usr/linsrc/linux-2513-pv/.config] Error 1
[rddunlap@midway linux-2513-pv]$

I removed all .tmp* files & dir., reran 'make oldconfig menuconfig',
and got the same results.

-- 
~Randy

