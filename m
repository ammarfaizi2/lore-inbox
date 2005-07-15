Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVGOCDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVGOCDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbVGOCBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:01:49 -0400
Received: from mail.tmr.com ([64.65.253.246]:37817 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S263139AbVGOCB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:01:27 -0400
Message-ID: <42D71A68.6030701@tmr.com>
Date: Thu, 14 Jul 2005 22:07:36 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com>  <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>  <20050713184227.GB2072@ucw.cz>  <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>  <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>  <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe> <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 14 Jul 2005, Lee Revell wrote:
>  
>
>>I don't think this will fly because we take a big performance hit by
>>calculating HZ at runtime.
>>    
>>
>
>I think it might be an acceptable solution for a distribution that really 
>needed it, since it should be fairly simple. However, it's definitely not 
>the right solution.
>
>HOWEVER. I bet that somebody who really really cares (hint hint) could
>easily make HZ be 1000, and then dynamically tweak the divisor at bootup
>to be either 1000, 250, or 100, and then increment "jiffies" by 1, 4 or
>10.
>
>My wild guess is that this is 20 lines of code, plus another 20 for 
>"setup", so that you can choose between 100/250/1000 Hz with a kernel 
>command line.
>
>It wouldn't be "dynamic" at first - you'd just set it up at bootup, and 
>set a "jiffies_increment" variable, and change the
>
>	jiffies_64++;
>
>into
>
>	jiffies_64 += jiffies_increment;
>
>and you'd be done. 
>
>Really. I dare you guys. First one to send me a tested patch gets a gold 
>star.
>
>Then, a year from now, people will realize how _easy_ it is to change the
>jiffies_increment on the fly, and add a /sys/kernel/timer_frequency file, 
>and then you can switch it around at run-time.
>
>Trust me. When I say that the right thing to do is to just have a fixed 
>(but high) HZ value, and just changing the timer rate, I'm -right-.
>
>I'm always right. This time I'm just even more right than usual.
>

And humble, too ;-)

Do you actually have something against tickless, or just don't think it 
can be done in reasonable time? I can see this needing very careful 
thought on SMP.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

