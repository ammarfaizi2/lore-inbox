Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbTDWM5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbTDWM5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:57:12 -0400
Received: from siaag1ae.compuserve.com ([149.174.40.7]:17898 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S264022AbTDWM5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:57:11 -0400
Date: Wed, 23 Apr 2003 09:02:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Wanted: A decent assembler
To: "root@chaos.analogic.com" <root@chaos.analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304230906_MC3-1-35A3-DF4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote"


>>   Output from 'make bzImage' after making some changes:
>>
>>         Error: non-constant expression in ".if" statement.
>>
>>
>>   Why is the kernel using a 1-pass assembler?
>>
>
> Well it isn't. The AT&T clone assembler will resolve forward
> references and it does it by using as many passes as necessary.
> It even has a 'reasonable' MACRO capability. I use it quite a
> bit to minimize the code-size or to maximize performance in
> embedded systems.


  This is from the info for GNU as:


   "The result of an expression must be an absolute number, or else an
offset into a particular section.  If an expression is not absolute,
and there is not enough information when `as' sees the expression to
know its section, a second pass over the source program might be
necessary to interpret the expression--but the second pass is currently
not implemented.  `as' aborts with an error message in this situation."


> Your error shown above is a real error. If you expose the code
> that it barfed on, maybe somebody could help you fix the code.

if NR_IRQS gt 16			# only build this for IO-APIC
	.align 8,0x90			# make ENTRY have exact address
irq_align=8				# start with 8-byte alignment
ENTRY(high_irq_entries_start)
rept NR_IRQS-16			# the rest of the stubs
	.align irq_align,0x90
1:	pushl $vector-256		# 5-byte instruction
	jmp common_interrupt		# 2 or 5 bytes (8 or 32-bit offset)
2:
if 2b-1b > 8			# <============================= ERROR
	irq_align=16			# switch to 16-byte alignment
endif
data
	.long 1b
text
vector=vector+1
endr
endif


-------
 Chuck
