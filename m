Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWI1XIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWI1XIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWI1XIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:08:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:11168 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964910AbWI1XIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:08:23 -0400
From: Andi Kleen <ak@suse.de>
To: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: 2.6.18-mm2
Date: Fri, 29 Sep 2006 01:08:15 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060928014623.ccc9b885.akpm@osdl.org> <451C4F0F.6010307@gmail.com>
In-Reply-To: <451C4F0F.6010307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290108.15400.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 September 2006 00:39, Jim Cromie wrote:
> 
> [jimc@harpo linux-2.6.18-mm2-sk]$ make
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CHK     include/linux/compile.h
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o(.text+0x34f1): In function `do_nmi':
> arch/i386/kernel/traps.c:752: undefined reference to 
> `panic_on_unrecovered_nmi'
> arch/i386/kernel/built-in.o(.text+0x3564):arch/i386/kernel/traps.c:712: 
> undefined reference to `panic_on_unrecovered_nmi'
> 
> 
> $ grep nmi arch/i386/kernel/Makefile
> obj-$(CONFIG_X86_LOCAL_APIC)    += apic.o nmi.o
> 
> which I dont have enabled.

Will fix.

BTW I was planning to make LOCAL_APIC unconditional on i386 too like on x86-64.
There is basically no reason ever to disable it, and the bug work around
for buggy BIOS one can be done at runtime. Overall the #ifdef / compile breakage
ratio vs saved code on disabled APIC code is definitely unbalanced.

-Andi
