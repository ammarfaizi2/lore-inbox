Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbTBNWVC>; Fri, 14 Feb 2003 17:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBNWVC>; Fri, 14 Feb 2003 17:21:02 -0500
Received: from faui11.informatik.uni-erlangen.de ([131.188.31.2]:5257 "EHLO
	faui11.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S267448AbTBNWVB>; Fri, 14 Feb 2003 17:21:01 -0500
From: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
Message-Id: <200302142230.XAA13431@faui11.informatik.uni-erlangen.de>
Subject: Re: [PATCH][2.5][8/14] smp_call_function_on_cpu - s390
To: zwane@holomorphy.com
Date: Fri, 14 Feb 2003 23:30:51 +0100 (MET)
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>+       cpu = get_cpu();
>+       mask &= (1UL << cpu);
>+       num_cpus = hweight32(mask);

I guess you mean 
         mask &= ~(1UL << cpu);
or else num_cpus is always either 0 or 1 ...

>+       for (i = 0; i < NR_CPUS; i++) {
>+               if (cpu_online(i) && ((1UL << cpu) && mask))

This should be
 		 if (cpu_online(i) && ((1UL << i) & mask))
or else the message is sent to all online CPUs anyway ...

Bye,
Ulrich

-- 
  Dr. Ulrich Weigand
  weigand@informatik.uni-erlangen.de
