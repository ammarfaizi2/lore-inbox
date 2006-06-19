Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWFSVli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWFSVli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWFSVli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:41:38 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:16780 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S964906AbWFSVlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:41:36 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 19 Jun 2006 23:40:46 +0200
References: <6pxs2-1AR-5@gated-at.bofh.it> <6pyer-2Pt-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FsRUZ-0001Ll-0K@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
> On Mon, 19 Jun 2006, Andreas Mohr wrote:

>> while looking for loop places to apply cpu_relax() to, I found the
>> following gems:
>>
>> arch/i386/kernel/crash.c/crash_nmi_callback():
>>
>>        /* Assume hlt works */
>>        halt();
>>        for(;;);
>>
>>        return 1;
>> }

This will result in the processor burning energy again after the first
interrupt, won't it?

>> arch/i386/kernel/doublefault.c/doublefault_fn():
>>
>>        for (;;) /* nothing */;
>> }
>>
>> Let's assume that we have a less than moderate fan failure that causes
>> the CPU to heat up beyond the critical limit...
>> That might result in - you guessed it - crashes or doublefaults.
>> In which case we enter the corresponding handler and do... what?
> 
> The double-fault is just a place-holder. The CPU will actually
> reset without even executing this (try it).

If it does reset, you don't need that fuctions (you can use anything),
and if not, doing while(1) halt(); in both cases should DTRT even if the
system is FUBAR, and it should be even smaller.

>> Exactly, we accelerate the CPUs happy march into bit heaven by letting it
>> execute a busy-loop under a non-working fan.
> 
> You accelerate nothing. Bit heaven? A CPU without a fan will go into
> a cold, cold, shutdown, requiring a hardware reset to get it out of
> that latched, no internal clock running, mode.

Some CPU may do this, others will go via the random-generator mode into the
self-deformation-mode instead.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
