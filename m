Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262751AbUKRM2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262751AbUKRM2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUKRM2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:28:55 -0500
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:39577 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S262751AbUKRM2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:28:53 -0500
Date: Thu, 18 Nov 2004 13:28:51 +0100 (CET)
From: Pawel Sikora <pld@pld-linux.org>
X-X-Sender: pld@plus.ds14.agh.edu.pl
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Valdis.Kletnieks@vt.edu, A M <alim1993@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Accessing program counter registers from within C or Aseembler.
In-Reply-To: <Pine.LNX.4.53.0411181127510.26614@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.60.0411181311390.12746@plus.ds14.agh.edu.pl>
References: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
 <200411162133.iAGLXn7v018578@turing-police.cc.vt.edu>
 <Pine.LNX.4.53.0411181127510.26614@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Jan Engelhardt wrote:

>>> Does anybody know how to access the address of the
>>> current executing instruction in C while the program
>>> is executing?
>>
>> In other words, are you trying to answer "Where in memory am *I*?"
>> or "Where in memory is <that very recent code I want to look at>?"
>>
>> (Hint - for the former, you can probably get very good approximations
>> by just looking at the entry point address for the function:
>>
>> 	(void *) where = &__FUNCTION__;
>
> Well, that's only the function in which you are (i.e. it's an approximation to
> EIP)

Is this good enough ?

(gdb) disassemble __next_eip
0x08048380 <__next_eip+0>:      mov    (%esp),%eax
0x08048383 <__next_eip+3>:      ret

(gdb) disassemble test1
0x08048390 <test1+0>:   call   0x8048380 <__next_eip>
0x08048395 <test1+5>:   mov    %eax,0x80495ec
0x0804839a <test1+10>:  ret

(gdb) c
Continuing.
eip = 0x8048395

*** src ***

void* eip;
register unsigned* __esp asm("esp");
void* __attribute__((noinline)) __next_eip() { return (void *)(*__esp); }
void test1() { eip = __next_eip(); }
