Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUHKWhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUHKWhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUHKWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:37:15 -0400
Received: from holomorphy.com ([207.189.100.168]:62086 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268283AbUHKWhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:37:13 -0400
Date: Wed, 11 Aug 2004 15:33:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1: legacy_va_layout compile error with SYSCTL=n
Message-ID: <20040811223353.GT11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <20040811221825.GM26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811221825.GM26174@fs.tum.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:21:10AM -0700, Andrew Morton wrote:
>> sysctl-tunable-for-flexmmap.patch
>>   sysctl tunable for flexmmap

On Thu, Aug 12, 2004 at 12:18:25AM +0200, Adrian Bunk wrote:
> This patch breaks compilation with CONFIG_SYSCTL=n:
> <--  snip  -->
> ...
>   LD      .tmp_vmlinux1
> arch/i386/mm/built-in.o(.text+0x1cd6): In function `arch_pick_mmap_layout':
> : undefined reference to `sysctl_legacy_va_layout'
> make: *** [.tmp_vmlinux1] Error 1
> <--  snip  -->

Does this help?

Index: mm1-2.6.8-rc4/arch/i386/mm/mmap.c
===================================================================
--- mm1-2.6.8-rc4.orig/arch/i386/mm/mmap.c	2004-08-10 23:01:03.155047360 -0700
+++ mm1-2.6.8-rc4/arch/i386/mm/mmap.c	2004-08-11 15:22:17.606770256 -0700
@@ -47,6 +47,10 @@
 	return TASK_SIZE - (gap & PAGE_MASK);
 }
 
+#ifndef CONFIG_SYSCTL
+#define sysctl_legacy_va_layout	0
+#endif
+
 /*
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
