Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSHKFOo>; Sun, 11 Aug 2002 01:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSHKFOo>; Sun, 11 Aug 2002 01:14:44 -0400
Received: from clmboh1-smtp4.columbus.rr.com ([65.24.0.114]:2504 "EHLO
	clmboh1-smtp4.columbus.rr.com") by vger.kernel.org with ESMTP
	id <S317693AbSHKFOn>; Sun, 11 Aug 2002 01:14:43 -0400
Message-ID: <3D55F3A3.8080607@cinci.rr.com>
Date: Sun, 11 Aug 2002 01:18:27 -0400
From: Nathaniel <nwf@cinci.rr.com>
Organization: BentTroll Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.31
References: <Pine.LNX.4.33.0208101854340.2656-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus Torvalds <torvalds@home.transmeta.com>:
>   o Fix up problem with Alan's pnpbios fixes for per-cpu GDT'

   gcc -Wp,-MD,./.pnpbios_core.o.d -D__KERNEL__ -I/home/nwf/src/kernel/linux-2.5.31/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 
-malign-functions=4  -nostdinc -iwithprefix include    -DKBUILD_BASENAME=pnpbios_core -DEXPORT_SYMTAB  -c -o pnpbios_core.o pnpbios_core.c
pnpbios_core.c: In function `call_pnp_bios':
pnpbios_core.c:166: invalid lvalue in unary `&'
pnpbios_core.c:166: invalid lvalue in unary `&'
pnpbios_core.c:168: invalid lvalue in unary `&'
pnpbios_core.c:168: invalid lvalue in unary `&'
pnpbios_core.c: In function `pnpbios_init':
pnpbios_core.c:1275: invalid lvalue in unary `&'
pnpbios_core.c:1275: invalid lvalue in unary `&'
pnpbios_core.c:1276: invalid lvalue in unary `&'
pnpbios_core.c:1276: invalid lvalue in unary `&'
pnpbios_core.c:1277: invalid lvalue in unary `&'
pnpbios_core.c:1277: invalid lvalue in unary `&'

This patch allows it to compile (have not yet tested booting):

--- drivers/pnp/pnpbios_core.c.orig-nwf Sun Aug 11 01:11:40 2002
+++ drivers/pnp/pnpbios_core.c  Sun Aug 11 01:11:54 2002
@@ -126,11 +126,11 @@

  #define Q_SET_SEL(cpu, selname, address, size) \
  set_base(cpu_gdt_table[cpu][(selname) >> 3], __va((u32)(address))); \
-set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)

  #define Q2_SET_SEL(cpu, selname, address, size) \
  set_base(cpu_gdt_table[cpu][(selname) >> 3], (u32)(address)); \
-set_limit(&cpu_gdt_table[cpu][(selname) >> 3], size)
+set_limit(cpu_gdt_table[cpu][(selname) >> 3], size)

  /*
   * At some point we want to use this stack frame pointer to unwind

--Nathan

