Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288649AbSATO1S>; Sun, 20 Jan 2002 09:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288639AbSATO1B>; Sun, 20 Jan 2002 09:27:01 -0500
Received: from colorfullife.com ([216.156.138.34]:51466 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S288645AbSATO0p>;
	Sun, 20 Jan 2002 09:26:45 -0500
Message-ID: <3C4AD38F.7754CCC4@colorfullife.com>
Date: Sun, 20 Jan 2002 15:26:23 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sched] [patch] migration-fixes-2.5.3-pre2-A1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   */
>  #define SPURIOUS_APIC_VECTOR   0xff
>  #define ERROR_APIC_VECTOR      0xfe
>  #define INVALIDATE_TLB_VECTOR  0xfd
>  #define RESCHEDULE_VECTOR      0xfc
> -#define CALL_FUNCTION_VECTOR   0xfb
> +#define TASK_MIGRATION_VECTOR  0xfb
> +#define CALL_FUNCTION_VECTOR   0xfa
>  
Are you sure it's a good idea to have 6 interrupts at priority 15?
The local apic of the P6 has only one in-service entry and one holding
entry for each priority.

I'm not sure what happens if the entries overflow - either an interrupt
is lost or the message is resent.

<<<< Newest ia32 docu, vol3, chap. 7.6.4.3:
The P6 family and Pentium processor's local APIC includes an in-service
entryy and a holding entry for each priority level. Optimally, software
should allocate no more than 2 interrupts per priority.
<<<<<

<<< Original PPro, Vol 3, chap 7.4.2:
The processor's local APIC includes an in-service entry and a holding
entry for each proirity level. To avoid losing interrupts, software
should allocate no more than 2 interrupts per priority.
<<<<<

--
	Manfred
