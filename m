Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSHDQGf>; Sun, 4 Aug 2002 12:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSHDQGf>; Sun, 4 Aug 2002 12:06:35 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:42222 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317986AbSHDQGe>; Sun, 4 Aug 2002 12:06:34 -0400
Date: Sun, 4 Aug 2002 18:10:01 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 make allmodconfig - undefined symbols
In-Reply-To: <29906.1028456000@ocs3.intra.ocs.com.au>
Message-ID: <Pine.NEB.4.44.0208041802010.1422-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Keith Owens wrote:

> 2.4.19 make allmodconfig.  Besides the perennial drivers/net/wan/comx.o
> wanting proc_get_inode, there was only one undefined symbol.  In the
> extremely unlikely event that binfmt_elf is a module (how do you load
> modules when binfmt_elf is a module?), smp_num_siblings is unresolved.
>...

My impression is that nowadays it's extremely unlikely that someone tries
to run a current 2.4 kernel on an a.out system - and since there weren't
reports of people trying to build binfmt_elf as a module it seems noone
actually hits this problem. Instead of exporting one symbol that is only
needed in pathological setups I'd suggest the following patch to disallow
the modular bulding of binfmt_elf:

--- arch/i386/config.in.old	Sun Aug  4 18:05:16 2002
+++ arch/i386/config.in	Sun Aug  4 18:05:29 2002
@@ -267,7 +267,7 @@
 	 A.OUT		CONFIG_KCORE_AOUT" ELF
 fi
 tristate 'Kernel support for a.out binaries' CONFIG_BINFMT_AOUT
-tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
+bool 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC

 bool 'Power Management support' CONFIG_PM

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

