Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTIGFOI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 01:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTIGFOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 01:14:08 -0400
Received: from static-ctb-210-9-247-166.webone.com.au ([210.9.247.166]:49925
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262196AbTIGFOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 01:14:05 -0400
Message-ID: <3F5ABE90.2040003@cyberone.com.au>
Date: Sun, 07 Sep 2003 15:13:52 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: John Yau <jyau_kernel_dev@hotmail.com>
CC: "'Robert Love'" <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <000201c374c8$1124ee20$f40a0a0a@Aria>
In-Reply-To: <000201c374c8$1124ee20$f40a0a0a@Aria>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Yau wrote:

>>The rationale behind Ingo's patch is to "break up" the timeslices to give
>>
>better scheduling latency to 
>
>>multiple tasks at the same priority. 
>>So it is not "unnecessary context switches," just "extra context switches."
>>
>
>Hmm...my reasoning is that those switches are unnecessary because the
>interactivity bonus/penalty will take care of breaking the timeslices up in
>case of a CPU hog, albeit not at precise 25 ms granularity.  Though having
>regularity in scheduling is nice, I think Ingo's patch somewhat negates the
>purpose of having heterogenous time slice lengths.  I suspect Ingo's
>approach will thrash the caches quite a bit more than mine; we should
>definitely test this a bit to find out for sure.  Any suggestions on how to
>go about that?
>
>If we're going to do a context switch every 25 ms no matter what, we might
>as well just make the scheduler a true real time scheduler, dump having
>different time slice lengths and interactivity recalculations, and go
>completely round robin with strictly enforced priorities and a single class
>of time slice somewhere 1 to 5 ms long.
>

Heh, your logic is entertaining. I don't know how you got from step 1
to step 3 ;)

Anyway, you don't have to dump different timeslice lengths because you
don't really have them to begin with. See how "Nick's scheduler policy
v12" fixes your problems by mostly reducing complexity, not adding to
it.


