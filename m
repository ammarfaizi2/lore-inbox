Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTHWJT1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 05:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTHWJT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 05:19:27 -0400
Received: from dyn-ctb-210-9-245-87.webone.com.au ([210.9.245.87]:3599 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263555AbTHWJTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 05:19:25 -0400
Message-ID: <3F47317D.3030802@cyberone.com.au>
Date: Sat, 23 Aug 2003 19:18:53 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@uni-mannheim.de>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O18.1int
References: <200308231555.24530.kernel@kolivas.org> <200308231108.48053.schlicht@uni-mannheim.de>
In-Reply-To: <200308231108.48053.schlicht@uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Schlichter wrote:

>On Saturday 23 August 2003 07:55, Con Kolivas wrote:
>
>>Some high credit tasks were being missed due to their prolonged cpu burn at
>>startup flagging them as low credit tasks.
>>
>>Low credit tasks can now recover to become high credit.
>>
>>Con
>>
>
>Hi Con!
>
>First of all... Your interactive scheduler work is GREAT! I really like it...!
>
>Now I tried to unterstand what exacly the latest patch does, and as far as I 
>can see the first and the third hunk just delete respectively expand the 
>macro VARYING_CREDIT(p). But the second hunk helps processes to get some 
>interactive_credit until they become a HIGH_CREDIT task. This looks 
>reasonable to me...
>
>So, now I wanted to know how a task may lose its interactive_credit again... 
>The only code I saw doing this is exaclty the third hunk of your patch. But 
>if a process is a HIGH_CREDIT task it can never lose its interactive_credit 
>again. Is that intented?
>
>I think the third hunk should look like following:
>@@ -1548,7 +1545,7 @@ switch_tasks:
>        prev->sleep_avg -= run_time;
>        if ((long)prev->sleep_avg <= 0){
>                prev->sleep_avg = 0;
>-               prev->interactive_credit -= VARYING_CREDIT(prev);
>+               prev->interactive_credit -= !(LOW_CREDIT(prev));
>        }
>        prev->timestamp = now;
>
>As an additional idea I think interactive_credit should be allowed to be a bit 
>bigger than MAX_SLEEP_AVG and a bit lower than -MAX_SLEEP_AVG. This would 
>make LOW_CREDIT processes stay LOW_CREDIT even if they do some sleep and 
>HIGH_CREDIT processes star HIGH_CREDIT even if they do some computing...
>
>But of course I may completely miss something...
>
>

Hi
I don't know what is preferred on lkml, but I dislike mixing booleans
and integer arithmetic.

if (!LOW_CREDIT(prev))
    prev->interactive_credit--;

Easier to read IMO.


