Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbUKJW1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUKJW1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUKJW1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:27:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50564 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262040AbUKJW0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:26:33 -0500
Date: Wed, 10 Nov 2004 16:58:13 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Andrey J. Melnikoff (TEMHOTA)" <temnota@kmv.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.28-rc1] process stuck in release_task() call
Message-ID: <20041110185813.GD12867@logos.cnet>
References: <20041109162445.GM24130@kmv.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109162445.GM24130@kmv.ru>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrey,

On Tue, Nov 09, 2004 at 07:24:45PM +0300, Andrey J. Melnikoff (TEMHOTA) wrote:
> Hello!
> 
> With 2.4.28-pre3 and 2.4.28-rc1 i see strange situation - sendmail some
> times get stuck into release_task() call. 
> 
> System - Tyan Tiger MPX, dual Athlon MP 2800+ with 1Gb memory.
> 
> --- SysRq-T output ---
> ksymoops 2.4.9 on i686 2.4.28-rc1.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.28-rc1/ (default)
>      -m /boot/System.map-2.4.28-rc1 (default)
> 
> Reading Oops report from the terminal
> sendmail      S C012073D     0 15814      1 32701         14365 (NOTLB)
> Using defaults from ksymoops -t elf32-i386 -a i386
> Call Trace:    [<c012073d>] [<c0106582>] [<c0107717>]
> sendmail      Z 00000000     4 30459  15814         30669       (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c011547d>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 30669  15814         30707 30459 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     4 30707  15814         31549 30669 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000  2624 31549  15814         31708 30707 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 31708  15814         32269 31549 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 32269  15814         32352 31708 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000    20 32352  15814         32403 32269 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 32403  15814         32413 32352 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000   624 32413  15814         32468 32403 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 32468  15814         32473 32413 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 32473  15814         32482 32468 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> sendmail      Z 00000000     0 32482  15814         32499 32473 (L-TLB)
> Call Trace:    [<c0120f53>] [<c0121600>] [<c0121725>] [<c0107717>]
> ..... many sendmail zombies ......
> 
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Proc;  sendmail
> 
> >>EIP; c012073d <release_task+1fd/230>   <=====
> 
> Trace; c012073d <release_task+1fd/230>
> Trace; c0106582 <sys_rt_sigsuspend+122/160>
> Trace; c0107717 <system_call+33/38>
> Proc;  sendmail
> 
> >>EIP; 00000000 Before first symbol
> 
> Trace; c0120f53 <exit_notify+103/3c0>
> Trace; c0121600 <do_exit+3f0/4e0>
> Trace; c011547d <smp_apic_timer_interrupt+12d/130>
> Trace; c0121725 <sys_exit+15/20>
> Trace; c0107717 <system_call+33/38>
> Proc;  sendmail
> 
> >>EIP; 00000000 Before first symbol
> 
> Trace; c0120f53 <exit_notify+103/3c0>
> Trace; c0121600 <do_exit+3f0/4e0>
> Trace; c0121725 <sys_exit+15/20>
> Trace; c0107717 <system_call+33/38>
> Proc;  sendmail
> 
> .... same trace with other zombies ......
> 
> 
> disassemble show other result - process stuck into free_pages() call:
> 
> c0120540 <release_task>:
> c0120540:       55                      push   %ebp
> ....
> c0120736:       89 d8                   mov    %ebx,%eax
> c0120738:       e8 73 dd 01 00          call   c013e4b0 <free_pages> <= here

is this release_task+1fd?  Can you send me the full disassemble of release_task?

It can't be blocked here, its a "call" instruction. 

free_pages can't block either. Odd.  

It is reproducible? 

First wild guess (because I haven't got much of a clue really) 
would be to revert the mm/page_alloc.c __free_pages() "fastcall" 
gcc3.4 change.
