Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263527AbSITVYV>; Fri, 20 Sep 2002 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbSITVYV>; Fri, 20 Sep 2002 17:24:21 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23045
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263527AbSITVYU>; Fri, 20 Sep 2002 17:24:20 -0400
Subject: Re: pre-empt and smp in 2.5.37 - is it supposed to work? [contains
	2 oopses, one in set_cpus_allowed, one in md code]
From: Robert Love <rml@tech9.net>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020920210225.GA526@middle.of.nowhere>
References: <20020920200441.GA3677@middle.of.nowhere>
	<1032552562.966.832.camel@phantasy> 
	<20020920210225.GA526@middle.of.nowhere>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 17:29:26 -0400
Message-Id: <1032557366.2105.858.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-20 at 17:02, Jurriaan wrote:

> Trace; c01165f1 <schedule+3d/404>
> Trace; c0116c3c <wait_for_completion+9c/f8>
> Trace; c01169fc <default_wake_function+0/80>
> Trace; c01169fc <default_wake_function+0/80>
> Trace; c01180e6 <set_cpus_allowed+13a/744>
> Trace; c0118158 <set_cpus_allowed+1ac/744>
> Trace; c0118108 <set_cpus_allowed+15c/744>
> Trace; c01054f1 <enable_hlt+1c9/1d0>
> Trace; c01165f1 <schedule+3d/404>
> Trace; c0116c3c <wait_for_completion+9c/f8>
> Trace; c01169fc <default_wake_function+0/80>
> Trace; c01169fc <default_wake_function+0/80>
> Trace; c01180e6 <set_cpus_allowed+13a/744>
> Trace; c012031d <__run_task_queue+dd/168>
> Trace; c01202cc <__run_task_queue+8c/168>
> Trace; c01054f1 <enable_hlt+1c9/1d0>

This is known, its due to set_cpus_allowed() sleeping while holding a
preempt_disable().  It is harmless but something I need to fix.

> 8139too Fast Ethernet driver 0.9.26
> Unable to handle kernel NULL pointer dereference at virtual address 0000000e
> c024b6b9
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0060:[<c024b6b9>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 0000001e   ebx: fffffffa   ecx: c03675a8   edx: 00000292
> esi: fffffffa   edi: ffffffea   ebp: 00002103   esp: f7737eec
> ds: 0068   es: 0068   ss: 0068
> Stack: 00002103 c024d562 fffffffa 00000931 00002103 00002103 00000000 c024dfd9 
>        00002103 00000931 f7ca5e40 00002103 f77a3ee0 00000000 00000000 f778ba00 
>        000061b0 00000001 00000000 00000006 00002103 00000000 00000000 00000000 
> Call Trace: [<c024d562>] [<c024dfd9>] [<c014a826>] [<c0152d39>] [<c01071eb>] 
> Code: 8b 43 14 85 c0 74 10 0f b7 50 10 b2 00 66 0f b6 40 10 09 c2 

What is this?  Do you normally see this?

	Robert Love

