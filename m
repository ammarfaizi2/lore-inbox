Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSDWNHP>; Tue, 23 Apr 2002 09:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315194AbSDWNHO>; Tue, 23 Apr 2002 09:07:14 -0400
Received: from [195.223.140.120] ([195.223.140.120]:24853 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315191AbSDWNHO>; Tue, 23 Apr 2002 09:07:14 -0400
Date: Tue, 23 Apr 2002 15:07:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Dennis Schoen <dennis@cns.dnsalias.org>
Subject: Re: BUG: 2.4.19-pre6aa1 (i586) ?
Message-ID: <20020423150709.A4982@dualathlon.random>
In-Reply-To: <20020423092731.GA6327@smart.cobolt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 11:27:32AM +0200, Dennis Schoen wrote:
> Ok thats the second time in 3 days the machine died. Here are the infos:
> 
> AMD-K6(tm) 3D processor
> 
> opel:~# lspci
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5591/5592 Host (rev 02)
> 00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
> 00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
> 00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
> 00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8029(AS)
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
> 86C326 (rev 0b)
> 
> Kernel config is also attached. Contact me if you need more infos.
> 
> Ciao
>   Dennis
> 
> from syslog:
> 
> Apr 21 21:40:03 opel kernel: kernel BUG at page_alloc.c:234!
> Apr 21 21:40:03 opel kernel: invalid operand: 0000
> Apr 21 21:40:03 opel kernel: CPU:    0
> Apr 21 21:40:03 opel kernel: EIP:    0010:[rmqueue+112/548]    Not tainted
> Apr 21 21:40:03 opel kernel: EFLAGS: 00010086
> Apr 21 21:40:03 opel kernel: eax: 0000c000   ebx: c119f37c   ecx: 00001000   edx: e8bac588
> Apr 21 21:40:03 opel kernel: esi: c119f37c   edi: 00000000   ebp: c0230310   esp: ca569e64
> Apr 21 21:40:03 opel kernel: ds: 0018   es: 0018   ss: 0018
> Apr 21 21:40:03 opel kernel: Process w3m-en (pid: 1963, stackpage=ca569000)
> Apr 21 21:40:03 opel kernel: Stack: c02304d4 00000000 00000001 00000001 c0230310 0000a9b0 00000286 c023034c 
> Apr 21 21:40:03 opel kernel:        00000000 c0230310 c012bac4 c1002ccc 00000000 c6ebb274 00000001 c0230310 
> Apr 21 21:40:03 opel kernel:        00000001 c0122684 0000000c c0230310 c02304d0 000001d2 0809deb0 c012213b 
> Apr 21 21:40:03 opel kernel: Call Trace: [__alloc_pages+116/664] [do_no_page+56/380] [do_wp_page+127/440] [handle_mm_fault+144/208] [do_page_fault+447/1336] 
> Apr 21 21:40:03 opel kernel:    [do_page_fault+0/1336] [do_brk+283/508] [sys_brk+193/240] [error_code+52/64] 
> Apr 21 21:40:03 opel kernel: 

I doubt it's a bug in the page freelist management, but it seems the
freelist got corrupted somehow. So I'd say it's either a bug in another
subsystem or faulty dram. Can you try some memchecker to rule out the
hardware possibility?

Andrea
