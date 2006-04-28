Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbWD1NnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWD1NnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 09:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWD1NnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 09:43:06 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25325 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1030400AbWD1NnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 09:43:05 -0400
Message-ID: <44521BE6.8040500@grupopie.com>
Date: Fri, 28 Apr 2006 14:43:02 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 11/13] s390: instruction processing damage handling.
References: <20060424150544.GL15613@skybase>	 <20060428073358.GA15166@filer.fsl.cs.sunysb.edu>	 <20060428083903.GA11819@osiris.boeblingen.de.ibm.com> <1146216285.5138.1.camel@localhost>
In-Reply-To: <1146216285.5138.1.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Fri, 2006-04-28 at 10:39 +0200, Heiko Carstens wrote:
> 
>>>>+++ linux-2.6-patched/drivers/s390/s390mach.c	2006-04-24 16:47:28.000000000 +0200
>>>...
>>>>+#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
                                 ^^^^^^^^^^^^^^^^^^^^
				Expression A

>>>I'm no s390 expert, but shouldn't the above use something like HZ?
>>
>>Using HZ here feels just wrong to me. MAX_IPD_TIME has nothing to do with the
>>timer frequency. In this case it's used to tell if there were 30 machine
>>checks within the last 5 minutes (in a usec granularity). It's just by
>>accident that this could be expressed using HZ.
>>(5 * 60 * USEC_PER_SEC) would probably look better...
   ^^^^^^^^^^^^^^^^^^^^^^^
   Expression B

I'm no s390 expert either, but just wanted to point out that expression 
B is 10 times larger than expression A, so something's fishy here.

> Using HZ would be wrong. The check that uses MAX_IPD_TIME compares it
> against the result of a get_clock() call. That uses the TOD Clock
> directly, there is no dependency on HZ.

Looking at include/asm-s390/timex.h:

#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */

makes me wonder if this should be:

#define MAX_IPD_TIME	(5 * 60 * CLOCK_TICK_RATE) /* 5 minutes */

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
