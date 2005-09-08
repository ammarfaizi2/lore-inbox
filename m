Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVIHJdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVIHJdB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 05:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVIHJdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 05:33:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40157 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932437AbVIHJdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 05:33:00 -0400
Message-ID: <4320053D.5000408@volny.cz>
Date: Thu, 08 Sep 2005 11:32:45 +0200
From: Miloslav Trmac <mitr@volny.cz>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Wistron laptop button driver
References: <431E4E28.5020604@volny.cz> <20050907222347.493f1047.akpm@osdl.org>
In-Reply-To: <20050907222347.493f1047.akpm@osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Miloslav Trmac <mitr@volny.cz> wrote:
> 
>>+static void call_bios(struct regs *regs)
>> +{
>> +	unsigned long flags;
>> +
>> +	preempt_disable();
>> +	local_irq_save(flags);
>> +	asm volatile ("pushl %%ebp;"
>> +		      "movl %[data], %%ebp;"
>> +		      "call *%[routine];"
>> +		      "popl %%ebp"
>> +		      : "=a" (regs->eax), "=b" (regs->ebx), "=c" (regs->ecx)
>> +		      : "0" (regs->eax), "1" (regs->ebx), "2" (regs->ecx),
>> +			[routine] "m" (bios_entry_point),
>> +			[data] "m" (bios_data_map_base)
>> +		      : "edx", "edi", "esi", "memory");
>> +	local_irq_restore(flags);
>> +	preempt_enable();
>> +}
>> +
> 
> gcc-2.95.x spits the dummy over this [routine] stuff.  What compiler does
> this require?
(info gcc) says gcc >= 3.1.

> Is it necessary to open-code the BIOS call in the driver?  Does it make
> sense to have some library function to do this?
A general library function (handling all registers) would have to be
written in assembler because gcc has trouble allocating registers
otherwise; considering that we should ideally avoid BIOS calls and that
such a function wasn't needed in the last 14 years, I don't think it is
worth the effort.
	Mirek
