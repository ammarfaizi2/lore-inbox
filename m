Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267532AbUHEBRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267532AbUHEBRk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUHEBRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:17:40 -0400
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:6335 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S267532AbUHEBRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:17:38 -0400
Message-ID: <41118AAE.7090107@bigpond.net.au>
Date: Thu, 05 Aug 2004 11:17:34 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube>
In-Reply-To: <1091638227.1232.1750.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Are these going to be numbered consecutively, or might
> they better be done like the task state? SCHED_FIFO is
> in fact already treated this way in one place. One might
> want to test values this way:
> 
> if(foo & (SCHED_ISO|SCHED_RR|SCHED_FIFO))  ...
> 
> (leaving aside SCHED_OTHER==0, or just translate
> that single value for the ABI)
> 
> I'd like to see these get permenant allocations
> soon, even if the code doesn't go into the kernel.
> This is because user-space needs to know the values.

Excellent idea.  The definition of rt_task() could become:

#define rt_task(p) ((p)->policy & (SCHED_RR|SCHED_FIFO))

instead of the highly dodgy:

#define rt_task(p) ((p)->prio < MAX_RT_PRIO)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

