Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268451AbTCFWWQ>; Thu, 6 Mar 2003 17:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268458AbTCFWWP>; Thu, 6 Mar 2003 17:22:15 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:13965 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268451AbTCFWWM>; Thu, 6 Mar 2003 17:22:12 -0500
Date: Thu, 06 Mar 2003 14:22:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel@vger.kernel.org
cc: John Levon <levon@movementarian.org>
Subject: Re: HT and idle = poll
Message-ID: <17740000.1046989368@flay>
In-Reply-To: <b487l2$1tn$1@penguin.transmeta.com>
References: <200303052318.04647.habanero@us.ibm.com> <b487l2$1tn$1@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Theurer  <habanero@us.ibm.com> wrote:
>> The test:  kernbench (average of  kernel compiles5) with -j2 on a 2 physical/4 
>> logical P4 system.  This is on 2.5.64-HTschedB3:
>> 
>> idle != poll: Elapsed: 136.692s User: 249.846s System: 30.596s CPU: 204.8%
>> idle  = poll: Elapsed: 161.868s User: 295.738s System: 32.966s CPU: 202.6%
>> 
>> A 15.5% increase in compile times.
>> 
>> So, don't use idle=poll with HT when you know your workload has idle time!  I 
>> have not tried oprofile, but it stands to reason that this would be a 
>> problem.  There's no point in using idle=poll with oprofile and HT anyway, as 
>> the cpu utilization is totally wrong with HT to begin with (more on that 
>> later).
>> 
>> Presumably a logical cpu polling while idle uses too many cpu resources 
>> unnecessarily and significantly affects the performance of its sibling. 
> 
> Btw, I think this is exactly what the new HT prescott instructions are
> for: instead of having busy loops polling for a change in memory (be it
> a spinlock or a "need_resched" flag), new HT CPU's will support a
> "mwait" instruction. 
> 
> But yes, at least for now, I really don't think you should really _ever_
> use "idle=poll" on HT-enabled hardware. The idle CPU's will just suck
> cycles from the real work.

BTW, could someone give a brief summary of why idle=poll is needed for 
oprofile, I'd love to add it do the "documentation for dummies" file I
was writing.

M.

