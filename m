Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVHSKMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVHSKMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 06:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVHSKMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 06:12:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:20163 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932467AbVHSKMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 06:12:39 -0400
Date: Fri, 19 Aug 2005 12:12:03 +0200 (MEST)
Message-Id: <200508191012.j7JAC31j010985@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, rostedt@goodmis.org
Subject: Re: [PATCH] Mobil Pentium 4 HT and the NMI
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 20:23:00 -0700, Andrew Morton wrote:
>Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> Hi,
>> 
>> I'm resending this since I don't see it in git yet, and I'm wondering if
>> there is a problem with this patch.  I have a IBM ThinkPad G41 with a
>> Mobile Pentium 4 HT.  Without this patch, the NMI won't be setup.  Is
>> there a reason that if the x86_model is greater than 0x3 it will return.
>> Since my processor has a 0x4 x86_model, I upped it to that. Otherwise my
>> laptop won't be able to use the NMI.
>> 
>
>Well I was hoping that someone with knowledge of the low-level Intel model
>differences would pipe up, but they all seem to be in hiding.  (Wildly
>bcc's lots of x86 people).
>
>> 
>> Description:
>>   This patch is to allow the Mobile Penitum 4 HT to use the NMI.
>> 
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

The patch is OK, but it doesn't fix a bug or regression.
Since Linus' kernel seems to be in bug-fix-only mode, it
shouldn't go in there until after 2.6.13.

Acked-by: Mikael Pettersson <mikpe@csd.uu.se>

>> 
>> --- linux-2.6.13-rc6-git10/arch/i386/kernel/nmi.c.orig	2005-08-18 21:51:11.000000000 -0400
>> +++ linux-2.6.13-rc6-git10/arch/i386/kernel/nmi.c	2005-08-18 21:52:03.000000000 -0400
>> @@ -195,7 +195,7 @@ static void disable_lapic_nmi_watchdog(v
>>  			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
>>  			break;
>>  		case 15:
>> -			if (boot_cpu_data.x86_model > 0x3)
>> +			if (boot_cpu_data.x86_model > 0x4)
>>  				break;
>>  
>>  			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
>> @@ -432,7 +432,7 @@ void setup_apic_nmi_watchdog (void)
>>  			setup_p6_watchdog();
>>  			break;
>>  		case 15:
>> -			if (boot_cpu_data.x86_model > 0x3)
>> +			if (boot_cpu_data.x86_model > 0x4)
>>  				return;
>>  
>>  			if (!setup_p4_watchdog())
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
