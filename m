Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266627AbUG0Uhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266627AbUG0Uhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266624AbUG0Uhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:37:35 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40640 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266614AbUG0UhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:37:09 -0400
Date: Tue, 27 Jul 2004 22:36:55 +0200 (MEST)
Message-Id: <200407272036.i6RKatf1013827@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: macro@linux-mips.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] decode local APIC errors
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 20:21:34 +0200 (CEST), Mikael Pettersson wrote:
>On Tue, 27 Jul 2004, Mikael Pettersson wrote:
>
>> I got tired of having to manually decode local APIC
>> error codes in problem reports sent to LKML, so I
>> rewrote arch/i386/kernel/apic:smp_error_interrupt()
>> to do the decoding for us. Instead of:
>> 
>> APIC error on CPU0: 04(00)
>> 
>> this patch makes the kernel print:
>> 
>> APIC error on CPU0: Send Accept Error (0x00)
>> 
>> The code handles multiple set error flags, and will
>> also report if any unknown or reserved bits are set.
>
> Hmm, no objection in principle, but calling printk() for a string that
>does not end with a trailing '\n' leads to log being messed up if another
>message is placed from elsewhere inbetween.  Using sprintf() to construct
>the message may be an unnecessary complication, though.

You're right, separate printk()s don't work, and formatting the
text to a buffer gets into other problems(*).

Andrew, please feel free to toss my crappy patch in /dev/null...

(*) A static buffer needs locking, but an on-stack
buffer needs to be small, requiring shortened flag names,
making the error messages unreadable again. Sigh.
