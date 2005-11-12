Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVKLF6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVKLF6I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVKLF6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:58:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932097AbVKLF6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:58:07 -0500
Date: Fri, 11 Nov 2005 21:57:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/15] misc: Make sysenter support optional
Message-Id: <20051111215752.623726f4.akpm@osdl.org>
In-Reply-To: <10.282480653@selenic.com>
References: <9.282480653@selenic.com>
	<10.282480653@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> his adds configurable sysenter support on x86. This saves about 5k on
>  small systems.
> 
>     text    data     bss     dec     hex
>  3330172  529036  190556 4049764  3dcb64 baseline
>  3329604  524164  190556 4044324  3db624 sysenter
> 
>  $ bloat-o-meter vmlinux{-baseline,}
>  add/remove: 0/2 grow/shrink: 0/3 up/down: 0/-316 (-316)
>  function                                     old     new   delta
>  __restore_processor_state                     76      62     -14
>  identify_cpu                                 520     500     -20
>  create_elf_tables                            923     883     -40
>  sysenter_setup                               113       -    -113
>  enable_sep_cpu                               129       -    -129
> 
>  Most of the savings is not including the vsyscall DSO which doesn't
>  show up with bloat-o-meter:
> 
>  $ size arch/i386/kernel/vsyscall.o
>     text    data     bss     dec     hex filename
>        0    4826       0    4826    12da arch/i386/kernel/vsyscall.o
> 
>  $ nm arch/i386/kernel/vsyscall.o
>  00000961 T vsyscall_int80_end
>  00000000 T vsyscall_int80_start
>  000012da T vsyscall_sysenter_end
>  00000961 T vsyscall_sysenter_start

Similarly, stub out sysenter_setup() and enable_sep_cpu() and we lose a
bunch of ifdefs.

