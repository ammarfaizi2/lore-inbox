Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272842AbTGaH7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 03:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272870AbTGaH7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 03:59:33 -0400
Received: from dyn-ctb-210-9-243-68.webone.com.au ([210.9.243.68]:3332 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S272842AbTGaH71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 03:59:27 -0400
Message-ID: <3F28CC40.3030100@cyberone.com.au>
Date: Thu, 31 Jul 2003 17:58:56 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, Johoho <johoho@hojo-net.de>, wodecki@gmx.de,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org> <20030728143545.1d989946.akpm@osdl.org> <3F28B8D5.4040600@cyberone.com.au> <200307311743.17370.kernel@kolivas.org>
In-Reply-To: <200307311743.17370.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Thu, 31 Jul 2003 16:36, Nick Piggin wrote:
>
>>Oh, and the process scheduler can definitely be a contributing factor.
>>Even if it looks like your process is getting enough cpu, if your
>>process doesn't get woken in less than 5ms after its read completes,
>>then AS will give up waiting for it.
>>
>
>This part interests me. It would seem that either 
>1. The AS scheduler should not bother waiting at all if the process is not 
>going to wake up in that time
>

It doesn't. Lacking a crystal ball, it relies on heuristics
to achive this. It generally works.

>
>2. The process should be woken in that time to ensure the AS scheduler is not 
>wasting it's time waiting.
>or a combination of 1 and 2 depending on some heuristic deciding on how 
>important it is for 2 instead of 1.
>

Well yes, for any IO scheduler its important that a process being
woken for IO is run ASAP. It is realy up to the process scheduler
to hash out the policy here, just keep in mind that this is an
important metric.

If the scheduler / CPU can't keep up, then AS's heuristic should
kick in quickly.

>
>No, I'm not planning on trying to implement either of these <insert usual 
>complaint about time and knowledge here>, but I thought I should at least 
>contribute my thoughts.
>
>

No need! Just keep in mind that newly waking processes are important.
Not just for disk but any sort of IO: network, soundcard buffers, etc.


