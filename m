Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVL2CwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVL2CwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 21:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVL2CwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 21:52:11 -0500
Received: from smtp-5.smtp.ucla.edu ([169.232.47.138]:28380 "EHLO
	smtp-5.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S964975AbVL2CwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 21:52:10 -0500
Date: Wed, 28 Dec 2005 18:52:06 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20051228001047.GA3607@dmt.cnet>
Message-ID: <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Marcelo Tosatti wrote:
> On Tue, Dec 27, 2005 at 08:58:39AM -0800, Chris Stromsoe wrote:
>>
>> filemap.c:2234: bad pmd 00c001e3.
>> filemap.c:2234: bad pmd 010001e3.
>
> This is usually due to memory corruption. Please verify it with 
> memtest86.

I've run through three complete memtest86 passes so far with no errors. 
I'll keep running, but I'm not expecting to see anything.

I caught another two bad pmd errors followed by an oops this morning. 
This is with 2.4.32, bond/tg3 loaded as modules.  Full .config available.


-Chris

Dec 27 09:28:19 filemap.c:2234: bad pmd 020001e3.
Dec 27 09:28:19 filemap.c:2234: bad pmd 024001e3.

The oops came in ata 09:28:20

ksymoops 2.4.9 on i686 2.4.32.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.32/ (default)
      -m /boot/System.map-2.4.32 (specified)

Unable to handle kernel paging request at virtual address c22eee80
c0259bb3
*pde = 020001e3
Oops: 0002
CPU:    2
EIP:    0010:[alloc_skb+275/480]    Not tainted
EFLAGS: 00010282
eax: c22eee80   ebx: ccbdb480   ecx: 000006bc   edx: 00000680
esi: 000001f0   edi: 00000000   ebp: f663bdf0   esp: f663bddc
ds: 0018   es: 0018   ss: 0018
Process innfeed (pid: 526, stackpage=f663b000)
Stack: 000006bc 000001f0 ccbdb080 00000000 f7185800 f663be68 c027b50b 00000680
        000001f0 000005a8 00000000 f663be54 00000000 00000287 d84bec38 d84bec34
        d84bec54 f663a000 00000000 d5fbd8a0 f663a000 586d4438 0002c774 000005a8 
Call Trace:    [tcp_sendmsg+2619/4512] [inet_sendmsg+65/80] [sock_sendmsg+102/176] [sock_readv_writev+116/176] [sock_writev+79/96]
Code: c7 00 01 00 00 00 8b 83 8c 00 00 00 c7 40 04 00 00 00 00 8b 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; c22eee80 <_end+1f0d380/38650560>
>>ebx; ccbdb480 <_end+c7f9980/38650560>
>>ebp; f663bdf0 <_end+3625a2f0/38650560>
>>esp; f663bddc <_end+3625a2dc/38650560>

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
