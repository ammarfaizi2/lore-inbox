Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270625AbRHJAUm>; Thu, 9 Aug 2001 20:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270626AbRHJAUW>; Thu, 9 Aug 2001 20:20:22 -0400
Received: from biancha.hardboiledegg.com ([66.38.186.202]:53516 "HELO
	biancha.hardboiledegg.com") by vger.kernel.org with SMTP
	id <S270625AbRHJAUV>; Thu, 9 Aug 2001 20:20:21 -0400
Message-ID: <32779.213.7.62.75.997402832.squirrel@webmail.hbesoftware.com>
Date: Thu, 9 Aug 2001 20:20:32 -0400 (EDT)
Subject: Re: 2.4.8-pre7: still buffer cache problems
From: "marc heckmann" <heckmann@hbesoftware.com>
To: riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.33L.0108091749580.1439-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108091749580.1439-100000@duckman.distro.conectiva>
Cc: heckmann@hbesoftware.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> OK, there is no obvious way to do do drop-behind on
> buffer cache pages, but I think we can use a quick
> hack to make the system behave well under the presence
> of large amounts of buffer cache pages.
> 
> What we could do is, in refill_inactive_scan(), just
> moving buffer cache pages to the inactive list regardless
> of page aging when there are too many buffercache pages
> around in the system.
> 
> Does the patch below help you ?

well, the buffer cache still got huge and the system still swapped out like
mad, but it seemed like the buffer cache grew _slower_ and that the vm was
more fair towards other vm users. so interactivity was better but still far
from 2.2. and then it oops'ed [I don't think it was because of your patch
though..]:


Oops: kernel access of bad area, sig: 11
NIP: C005DEDC XER: 00000000 LR: C005B78C SP: C1251E10 REGS: c1251d60 TRAP: 0300
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1250000[1386] 'vmstat' Last syscall: 3 
last math c4568000 last altivec 00000000
GPR00: 00002000 C1251E10 C1250000 C8CC8000 C7262000 C01536F0 C5549880 00000000 
GPR08: 00007262 7FFFE000 00000000 00000000 84004883 10019BEC 7FFFF678 7FFFF680 
GPR16: 00000000 00000000 C7262000 00000052 00000625 00000440 00000000 C8CC8232 
GPR24: C0003CE0 7FFFF634 0020D000 C1251EA8 C1251EA0 C681A67C C681A660 C8CC8000 
Call backtrace: 
C58631A0 C005B78C C003A980 C0003D3C 1000141C 10000E18 0FEB5308 
00000000 
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c005dedc <proc_pid_stat+104/300>   <=====
Trace; c58631a0 <_end+567567c/d64853c>
Trace; c005b78c <proc_info_read+74/19c>
Trace; c003a980 <sys_read+c8/114>
Trace; c0003d3c <ret_from_syscall_1+0/b4>
Trace; 1000141c Before first symbol
Trace; 10000e18 Before first symbol
Trace; 0feb5308 Before first symbol
Trace; 00000000 Before first symbol


20 warnings issued.  Results may not be reliable.

Cheers,

-marc

-- 
	Marc Heckmann <heckmann@hbe.ca>

	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/


