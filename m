Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265888AbUAEHF6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 02:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAEHF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 02:05:58 -0500
Received: from web21501.mail.yahoo.com ([66.163.169.12]:8081 "HELO
	web21501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265888AbUAEHFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 02:05:32 -0500
Message-ID: <20040105070531.74437.qmail@web21501.mail.yahoo.com>
Date: Sun, 4 Jan 2004 23:05:31 -0800 (PST)
From: Shivu V <shivu_sv2004@yahoo.com>
Subject: Re: oops from my test driver at poll_wait (__pollwait from select.c)
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040104220859.22913.qmail@web21508.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tested it on kernel version 2.4.21-4.ELsmp and
it works fine.

-Shivu


--- Shivu V <shivu_sv2004@yahoo.com> wrote:
> And the Kernel version is : 2.4.18-14
> 
> -Shivu
> 
> --- Shivu V <shivu_sv2004@yahoo.com> wrote:
> > Hello,
> > 
> > I am a newbie in driver development. In one of my
> > test
> > driver, I am getting the oops at poll_wait.  The
> > ksymoops o/p is as follows :
> > 
> > Unable to handle kernel NULL pointer dereference
> at
> > virtual address 00000005
> > c01190f5
> > *pde = 00000000
> > Oops: 0002
> > CPU:    0
> > EIP:    0010:[<c01190f5>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010046
> > eax: f7ae0f18   ebx: 00000001   ecx: f6d40014  
> edx:
> > f6d4000c
> > esi: 00000246   edi: 00000000   ebp: f6d47ef4  
> esp:
> > f6d47ec0
> > ds: 0018   es: 0018   ss: 0018
> > Process test (pid: 1228, stackpage=f6d47000)
> > Stack: f72b3520 f7ae0e80 f8e144c6 f6d8f0e0
> f7ae0f18
> > f6d47fa8 f6d47f04 00000000
> >       c012bee9 f6f513c0 f6d8f0e0 00000000 f6d47fa8
> > f6d47f24 f8e14987 f6d8f0e0
> >       f6d47fa8 420d2220 f6d93900 c01169f8 00000212
> > 00001000 00000145 f6d41000
> > Call Trace: [<f8e144c6>] daemon_poll [mytest] 0x78
> > (0xf6d47ec8))
> > [<c012bee9>] handle_mm_fault [kernel] 0x89
> > (0xf6d47ee0))
> > [<f8e14987>] mytest_poll [mytest] 0x6d
> (0xf6d47ef8))
> > [<c01169f8>] do_page_fault [kernel] 0x138
> > (0xf6d47f0c))
> > [<c0150255>] do_pollfd [kernel] 0x95 (0xf6d47f28))
> > [<c015035f>] do_pollfd [kernel] 0x19f
> (0xf6d47f44))
> > [<c01504d3>] sys_poll [kernel] 0x163 (0xf6d47f78))
> > [<c010910f>] system_call [kernel] 0x33
> (0xf6d47fc0))
> > Code: 89 4b 04 89 5a 08 89 41 04 89 08 56 9d 8b 1c
> > 24
> > 8b 74 24 04
> > 
> > 
> > >>EIP; c01190f5 <add_wait_queue+15/30>   <=====
> > 
> > >>eax; f7ae0f18 <_end+3770f398/384564e0>
> > >>ecx; f6d40014 <_end+3696e494/384564e0>
> > >>edx; f6d4000c <_end+3696e48c/384564e0>
> > >>ebp; f6d47ef4 <_end+36976374/384564e0>
> > >>esp; f6d47ec0 <_end+36976340/384564e0>
> > 
> > Trace; f8e144c6 <[mytest]daemon_poll+78/d6>
> > Trace; c012bee9 <handle_mm_fault+89/160>
> > Trace; f8e14987 <[mytest]mytest_poll+6d/96>
> > Trace; c01169f8 <do_page_fault+138/4cf>
> > Trace; c0150255 <do_pollfd+95/a0>
> > Trace; c015035f <do_poll+ff/110>
> > Trace; c01504d3 <sys_poll+163/300>
> > Trace; c010910f <system_call+33/38>
> > 
> > Code;  c01190f5 <add_wait_queue+15/30>
> > 00000000 <_EIP>:
> > Code;  c01190f5 <add_wait_queue+15/30>   <=====
> >   0:   89 4b 04                  mov   
> > %ecx,0x4(%ebx)
> >   <=====
> > Code;  c01190f8 <add_wait_queue+18/30>
> >   3:   89 5a 08                  mov   
> > %ebx,0x8(%edx)
> > Code;  c01190fb <add_wait_queue+1b/30>
> >   6:   89 41 04                  mov   
> > %eax,0x4(%ecx)
> > Code;  c01190fe <add_wait_queue+1e/30>
> >   9:   89 08                     mov   
> %ecx,(%eax)
> > Code;  c0119100 <add_wait_queue+20/30>
> >   b:   56                        push   %esi
> > Code;  c0119101 <add_wait_queue+21/30>
> >   c:   9d                        popf  Code; 
> > c0119102
> > <add_wait_queue+22/30>
> >   d:   8b 1c 24                  mov   
> > (%esp,1),%ebx
> > Code;  c0119105 <add_wait_queue+25/30>
> >  10:   8b 74 24 04               mov   
> > 0x4(%esp,1),%esi
> > 
> > 
> > 2 warnings and 5 errors issued.  Results may not
> be
> > reliable. 
> > 
> > 
> > 
> > Any ideas ??
> > 
> > Thanks
> > -Shivu
> > 
> > __________________________________
> > Do you Yahoo!?
> > Find out what made the Top Yahoo! Searches of 2003
> > http://search.yahoo.com/top2003
> > 
> 
> 
> __________________________________
> Do you Yahoo!?
> Find out what made the Top Yahoo! Searches of 2003
> http://search.yahoo.com/top2003
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
Find out what made the Top Yahoo! Searches of 2003
http://search.yahoo.com/top2003
