Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVC1X6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVC1X6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVC1X6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:58:13 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:18834 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S262128AbVC1X6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:58:00 -0500
Message-ID: <424899D7.1080407@tlinx.org>
Date: Mon, 28 Mar 2005 15:57:11 -0800
From: "L. A. Walsh" <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Adrian Bunk <bunk@stusta.de>, Jean Delvare <khali@linux-fr.org>
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a
 check after use)
References: <20050327205014.GD4285@stusta.de> <20050327232158.46146243.khali@linux-fr.org> <20050327214323.GH4285@stusta.de>
In-Reply-To: <20050327214323.GH4285@stusta.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adrian Bunk wrote:

>On Sun, Mar 27, 2005 at 11:21:58PM +0200, Jean Delvare wrote:
>  
>
>
>There are two cases:
>1. NULL is impossible, the check is superfluous
>2. this was an actual bug
>
>In the first case, my patch doesn't do any harm (a superfluous isn't a 
>real bug).
>
>In the second case, it fixed a bug.
>It might be a bug not many people hit because it might be in some error 
>path of some esoteric driver.
>
>If a maintainer of a well-maintained subsystem like i2c says
>"The check is superfluous." that's the perfect solution.
>
>But in less maintained parts of the kernel, even a low possibility that 
>it fixes a possible bug is IMHO worth making such a riskless patch.
>  
>
---
    I'd agree in [al]most any part of the kernel.  Unless it
is extremely time critical code, subroutines should expect
possible garbage from their callers.

    Just because it may be perfect today doesn't mean someone down
the line won't call the routine with less than perfect parameters.

    It used to be called "defensive" programming.

    However, in this case, if the author is _certain_ the
pointer can never be NULL, than an "ASSERT(card!=NULL);" might
be appropriate, where ASSERT is a macro that normally compiles
in the check, but could compile to "nothing" for embedded or
kernels that aren't being developed in.

-linda

>  
>
>>Thanks,
>>Jean Delvare
>>    
>>
>
>cu
>Adrian
>
>  
>
