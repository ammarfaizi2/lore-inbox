Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSFTKLD>; Thu, 20 Jun 2002 06:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSFTKLC>; Thu, 20 Jun 2002 06:11:02 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:42912 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313181AbSFTKLC>;
	Thu, 20 Jun 2002 06:11:02 -0400
Date: Thu, 20 Jun 2002 12:11:02 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206201011.MAA10306@harpo.it.uu.se>
To: manik@cisco.com, mingo@elte.hu
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002 00:26:39 -0700, Manik Raina wrote:
>	A small doubt, 
>	Should'nt this function below return something ? 
>	set_task_cpu() should return unsigned int but it
>	seems to do nothing ....
>	
>
>Ingo Molnar wrote:
>> +
>> +static inline unsigned int set_task_cpu(struct task_struct *p, unsigned int cpu)
>> +{
>> +}

My UP CPU number optimisation patch, from which this originates,
made the set_${foo}_cpu() inline 'void'. If for some reason a
return value is needed, just return 0 since that's what the
optimised-away "->cpu = 0" assignment would have had as value.

(The difference is that I had foo=thread_info, but Ingo lifted it
up so foo=task_struct here. I also removed the x86 thread_info cpu
field on UP.)

/Mikael
