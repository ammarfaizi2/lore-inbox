Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVI2Q0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVI2Q0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVI2Q0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:26:33 -0400
Received: from [195.23.16.24] ([195.23.16.24]:12517 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S932177AbVI2Q0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:26:32 -0400
Message-ID: <433C1585.6080800@grupopie.com>
Date: Thu, 29 Sep 2005 17:25:41 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
References: <433C0F3D.30C19186@tv-sign.ru> <Pine.LNX.4.58.0509290901060.3308@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509290901060.3308@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 29 Sep 2005, Oleg Nesterov wrote:
> 
>>[...]
>>However, TASK_NONINTERACTIVE > TASK_STOPPED, so this loop will not
>>count TASK_INTERRUPTIBLE | TASK_NONINTERACTIVE threads.
> 
> [...]
> Using ">" for task states is wrong. It's a bitmask, and if you want to 
> check multiple states, then we should just do so with
> 
> 	if (t->state & (TASK_xxx | TASK_yyy | ...))
> 
> Oh, well. The inequality comparisons are shorter, and historical, so I 
> guess it's debatable whether we should remove them all.

I did a quick grep through 2.6.14-rc2 to see how many "them all" were, 
and the only two places I could find, where a inequality operator was 
being used on a task state, were this one in kernel/signal.c and another 
in kernel/exit.c:

./kernel/exit.c:1194:               unlikely(p->state > TASK_STOPPED)

So maybe it is not so bad to just change these to a bit mask and 
disallow inequality comparisons in the future, if you guys feel that is 
the way to go...

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
