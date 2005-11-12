Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbVKLF4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbVKLF4N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVKLF4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:56:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932154AbVKLF4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:56:11 -0500
Date: Fri, 11 Nov 2005 21:55:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] misc: Make vm86 support optional
Message-Id: <20051111215556.2333c523.akpm@osdl.org>
In-Reply-To: <9.282480653@selenic.com>
References: <8.282480653@selenic.com>
	<9.282480653@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Make vm86 support optional
> 
> add/remove: 0/14 grow/shrink: 0/5 up/down: 0/-5221 (-5221)
> function                                     old     new   delta
> do_simd_coprocessor_error                    133     132      -1
> irqbits                                        4       -      -4
> irqbits_lock                                   8       -      -8
> release_thread                                72      52     -20
> do_debug                                     212     186     -26
> do_general_protection                        475     428     -47
> do_trap                                      196     140     -56
> release_vm86_irqs                            112       -    -112
> vm86_irqs                                    128       -    -128
> sys_vm86old                                  146       -    -146
> irq_handler                                  151       -    -151
> mark_screen_rdonly                           159       -    -159
> sys_vm86                                     199       -    -199
> handle_vm86_trap                             231       -    -231
> save_v86_state                               339       -    -339
> do_sys_vm86                                  379       -    -379
> do_vm86_irq_handling                         482       -    -482
> do_int                                       508       -    -508
> handle_vm86_fault                           2225       -   -2225


bix:/usr/src/25> grep '#ifdef' patches/tiny-make-vm86-support-optional.patch
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86
+#ifdef CONFIG_VM86

This one has a rather low bytes-to-ifdefs ratio.

I bet you can get most of these benefits by stubbing out handle_vm86_*()
and friends and perhaps setting VM_MASK to zero.
