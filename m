Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWDUUDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWDUUDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWDUUDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:03:47 -0400
Received: from mail.parknet.jp ([210.171.160.80]:24840 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751347AbWDUUDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:03:46 -0400
X-AuthUser: hirofumi@parknet.jp
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] X86_NUMAQ build fix
References: <87irp2x69s.fsf@duaron.myhome.or.jp>
	<1145643558.3373.34.camel@localhost.localdomain>
	<874q0mwyor.fsf@duaron.myhome.or.jp>
	<1145645988.3373.38.camel@localhost.localdomain>
	<87zmievi86.fsf@duaron.myhome.or.jp>
	<1145648166.3373.41.camel@localhost.localdomain>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Apr 2006 05:03:40 +0900
In-Reply-To: <1145648166.3373.41.camel@localhost.localdomain> (Dave Hansen's message of "Fri, 21 Apr 2006 12:36:05 -0700")
Message-ID: <87lktyvgpv.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Do you really need anything other than the Kconfig fix?  I thought that
> it alone would be a complete fix.

Yes. I thought I explained those...

>  #ifdef CONFIG_X86_NUMAQ
> -static void * xquad_portio = NULL;
> +/* hack to avoid using xquad_portio=NULL */
> +#undef outb_p
> +#define outb_p		outb_local_p
>  #endif

This fixes the following error.

make -C /devel/linux/works/linux-2.6 O=/devel/linux/works/linux-2.6-devron
  GEN    /devel/linux/works/linux-2.6-devron/Makefile
  CHK     include/linux/version.h
  Using /devel/linux/works/linux-2.6 as source for kernel
  CHK     include/linux/compile.h
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  Building modules, stage 2.
  LD      arch/i386/boot/setup
  CC      arch/i386/boot/compressed/misc.o
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
  GZIP    arch/i386/boot/compressed/vmlinux.bin.gz
/devel/linux/works/linux-2.6/arch/i386/boot/compressed/misc.c:125: error: static declaration of 'xquad_portio' follows non-static declaration
include2/asm/io.h:303: error: previous declaration of 'xquad_portio' was here
make[4]: *** [arch/i386/boot/compressed/misc.o] Error 1
make[4]: *** Waiting for unfinished jobs....
  MODPOST
make[3]: *** [arch/i386/boot/compressed/vmlinux] Error 2
make[2]: *** [bzImage] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [_all] Error 2
make: *** [all] Error 2

>  static int boot_cpu_logical_apicid;
> +#ifdef CONFIG_X86_NUMAQ
>  /* Where the IO area was mapped on multiquad, always 0 otherwise */
>  void *xquad_portio;
> -#ifdef CONFIG_X86_NUMAQ
>  EXPORT_SYMBOL(xquad_portio);
>  #endif

xquad_portio is needed to only X86_NUMAQ.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
