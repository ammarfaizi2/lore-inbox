Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUGREPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUGREPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 00:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUGREPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 00:15:14 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:30340 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S262085AbUGREPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 00:15:02 -0400
Date: Sun, 18 Jul 2004 06:14:59 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Comparing struct pt_regs : asm-i386 vs asm-x86_64
In-Reply-To: <Pine.LNX.4.44.0407171943430.24250-100000@hubble.stokkie.net>
Message-ID: <Pine.LNX.4.44.0407180607320.9290-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2004, Robert M. Stockmann wrote:

> Hi,
> 
> The (X86_64/AMD64/Opteron) platform is pretty compatible with 32 bits
> software written for the ia32 architecture, so to seems.
> 
> However when going down to assembly language it breaks down to pieces :
> 
> include/asm-i386/ptrace.h :
> ===========================
> 
> /* this struct defines the way the registers are stored on the
>    stack during a system call. */
> 
> struct pt_regs {
>         long ebx;
>         long ecx;
>         long edx;
>         long esi;
>         long edi;
>         long ebp;
>         long eax;
>         int  xds;
>         int  xes;
>         long orig_eax;
>         long eip;
>         int  xcs;
>         long eflags;
>         long esp;
>         int  xss;
> };
> 
> 
> include/asm-x86_64/ptrace.h :
> =============================
> 
> #ifndef __ASSEMBLY__
> 
> struct pt_regs {
>         unsigned long r15;
>         unsigned long r14;
>         unsigned long r13;
>         unsigned long r12;
>         unsigned long rbp;
>         unsigned long rbx;
> /* arguments: non interrupts/non tracing syscalls only save upto here*/
>         unsigned long r11;
>         unsigned long r10;
>         unsigned long r9;
>         unsigned long r8;
>         unsigned long rax;
>         unsigned long rcx;
>         unsigned long rdx;
>         unsigned long rsi;
>         unsigned long rdi;
>         unsigned long orig_rax;
> /* end of arguments */
> /* cpu exception frame or undefined */
>         unsigned long rip;
>         unsigned long cs;
>         unsigned long eflags;
>         unsigned long rsp;
>         unsigned long ss;
> /* top of stack page */
> };
> 
> So when porting i386 C-code (which uses the struct pt_regs from
> include/asm-i386/ptrace.h) how does the pt_regs structure translate into
> the struct pt_regs from include/asm-x86_64/ptrace.h  ?
> 

I came across this "Gentle Introduction" on www.x86-64.org :

"Gentle Introduction to x86-64 Assembly "
http://www.x86-64.org/documentation/assembly :

Where the most striking remark is this :

"This document is meant to summarise differences between x86-64 and i386 
assembly assuming that you already know well the i386 gas syntax. I will try 
to keep this document up to date until official documentation is available."

Amazing stuff! How can one manufacture full-functional x86_64 AMD64 and
Opteron CPU's in silicon print, while the white-paper print of the "official
documentation" on assembly programming on x86_64 is NOT available ??

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

