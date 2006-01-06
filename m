Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWAFVyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWAFVyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWAFVyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:54:53 -0500
Received: from smtp-3.smtp.ucla.edu ([169.232.48.136]:35290 "EHLO
	smtp-3.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S932472AbWAFVyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:54:52 -0500
Date: Fri, 6 Jan 2006 13:54:45 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20060105054348.GA28125@w.ods.org>
Message-ID: <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Willy Tarreau wrote:
> On Wed, Jan 04, 2006 at 07:52:36PM -0800, Chris Stromsoe wrote:
> 
>> I booted 2.4.32 with the aic7xxx patch you pointed me at last week. 
>> It's been up for a few hours.  I'll let it run for at least a week or 
>> two and will report back positive or negative results.  After that, 
>> I'll try 2.4.32 with nosmp and acpi=off.
>
> Thanks for your continued feedback, Chris. Your reports are very 
> helpful, they tend to prove that your hardware is OK and that there's a 
> bug in mainline 2.4.32 with SMP+ACPI+aic7xxx enabled. That's already a 
> good piece of information.

After a little more than one day up with 2.4.32 SMP+ACP+aic7xxx, I got 
another bad pmd and an oops this morning at 4:23am.  I'm going to boot 
vanilla 2.4.32 with nosmp and acpi=off.


-Chris

ksymoops 2.4.9 on i686 2.4.32-aic79xx.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.32-aic79xx/ (default)
      -m /boot/System.map-2.4.32-aic79xx (specified)

Unable to handle kernel paging request at virtual address c2deee80
c025b3d3
*pde = 02c001e3
Oops: 0002
CPU:    2
EIP:    0010:[alloc_skb+275/480]    Not tainted
EFLAGS: 00010282
eax: c2deee80   ebx: e0508880   ecx: 000006bc   edx: 00000680
esi: 000001f0   edi: 00000000   ebp: f6cf7df0   esp: f6cf7ddc
ds: 0018   es: 0018   ss: 0018
Process innfeed (pid: 523, stackpage=f6cf7000)
Stack: 000006bc 000001f0 f3023b80 00000000 d307e000 f6cf7e68 c027cd2b 00000680
        000001f0 000005a8 00000000 f6cf7e54 00000000 00000283 cb3f3000 c025a339
        c8083280 00000000 00000000 c43428a0 f6cf6000 461800d6 00009bc7 00010430 
Call Trace:    [tcp_sendmsg+2619/4512] [sock_wfree+73/80] [inet_sendmsg+65/80] [sock_sendmsg+102/176] [sock_readv_writev+116/176]
Code: c7 00 01 00 00 00 8b 83 8c 00 00 00 c7 40 04 00 00 00 00 8b 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c2deee80 <_end+2a0b300/3864e4e0>
>>ebx; e0508880 <_end+20124d00/3864e4e0>
>>ebp; f6cf7df0 <_end+36914270/3864e4e0>
>>esp; f6cf7ddc <_end+3691425c/3864e4e0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   c7 00 01 00 00 00         movl   $0x1,(%eax)
Code;  00000006 Before first symbol
    6:   8b 83 8c 00 00 00         mov    0x8c(%ebx),%eax
Code;  0000000c Before first symbol
    c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
Code;  00000013 Before first symbol
   13:   8b 00                     mov    (%eax),%eax

