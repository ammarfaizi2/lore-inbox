Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbTFRAeX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbTFRAeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:34:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:506 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265031AbTFRAeJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:34:09 -0400
Message-ID: <3EEFB6AA.2040501@mvista.com>
Date: Tue, 17 Jun 2003 17:47:38 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: davidm@hpl.hp.com, Riley Williams <Riley@Williams.Name>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
References: <16110.4883.885590.597687@napali.hpl.hp.com> <BKEGKPICNAKILKJKMHCAEEOAEFAA.Riley@Williams.Name> <16111.37901.389610.100530@napali.hpl.hp.com> <20030618002146.A20956@ucw.cz> <16111.38768.926655.731251@napali.hpl.hp.com> <20030618004233.B21001@ucw.cz> <16111.40816.147471.84610@napali.hpl.hp.com> <20030618011411.A23198@ucw.cz> <16111.41748.667166.867915@napali.hpl.hp.com> <20030618013114.A23697@ucw.cz>
In-Reply-To: <20030618013114.A23697@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Jun 17, 2003 at 04:24:04PM -0700, David Mosberger wrote:
> 
>>>>>>>On Wed, 18 Jun 2003 01:14:11 +0200, Vojtech Pavlik <vojtech@suse.cz> said:
>>
>>  >>  Sounds much better to me.  Wouldn't something along the lines of
>>  >> this make the most sense:
>>
>>  >> #ifdef __ARCH_PIT_FREQ # define PIT_FREQ __ARCH_PIT_FREQ #else #
>>  >> define PIT_FREQ 1193182 #endif
>>
>>  >> After all, it seems like the vast majority of legacy-compatible
>>  >> hardware _do_ use the standard frequency.
>>
>>  Vojtech> Now, if this was in some nice include file, along with the
>>  Vojtech> definition of the i8253 PIT spinlock, that'd be
>>  Vojtech> great. Because not just the beeper driver uses the PIT,
>>  Vojtech> also some joystick code uses it if it is available.
>>
>>ftape, too.  The LATCH() macro should also be moved to such a header
>>file, I think.  How about just creating asm/pit.h?  Only platforms
>>that need to (potentially) support legacy hardware would need to
>>define it.  E.g., on ia64, we could do:
>>
>> #ifndef _ASM_IA64_PIT_H
>> #define _ASM_IA64_PIT_H
>>
>> #include <linux/config.h>
>>
>> #ifdef CONFIG_LEGACY_HW
>> # define PIT_FREQ	1193182
>> # define LATCH		((CLOCK_TICK_RATE + HZ/2) / HZ)
----------------------------------^^^^^^^^^^^^^^^
should be PIT_FREQ me thinks :)

-g
>> #endif
>>
>> #endif /* _ASM_IA64_PIT_H */
>>
>>This way, machines that support legacy hardware can define
>>CONFIG_LEGACY_HW and on others, the macro can be left undefined, so
>>that any attempt to compile drivers requiring legacy hw would fail to
>>compile upfront (much better than accessing random ports!).
> 
> 
> Yes, that looks very good indeed. Riley?
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

