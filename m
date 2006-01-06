Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752453AbWAFQo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbWAFQo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbWAFQo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:44:59 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:41969 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1752475AbWAFQo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:44:58 -0500
Message-ID: <43BE9E91.9060302@watson.ibm.com>
Date: Fri, 06 Jan 2006 16:45:05 +0000
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@trained-monkey.org>
CC: Matt Helsley <matthltc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>,
       John Hesterberg <jh@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors
References: <43BB05D8.6070101@watson.ibm.com>	<43BB09D4.2060209@watson.ibm.com> <43BC1C43.9020101@engr.sgi.com>	<1136414431.22868.115.camel@stark>	<20060104151730.77df5bf6.akpm@osdl.org>	<1136486566.22868.127.camel@stark> <1136488842.22868.142.camel@stark>	<20060105151016.732612fd.akpm@osdl.org>	<1136505973.22868.192.camel@stark> <yq08xttybrx.fsf@jaguar.mkp.net>
In-Reply-To: <yq08xttybrx.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
>>>>>>"Matt" == Matt Helsley <matthltc@us.ibm.com> writes:
> 
> 
> Matt> 	Right. I forgot to repeat what I mentioned in the parent email
> Matt> -- that this patch is intended to be applied on top of
> Matt> Shailabh's patches.
> 
> Matt> 	The first patch I posted (01/01) is intended for plain
> Matt> 2.6.15. Before proposing 01/01 for -mm I've been trying to see
> Matt> if there are any problems with the value of tsk->exit_signal
> Matt> before exit_mm() -- hence the "[RFC]" in the subject line of
> Matt> that one.
> 
> Matt,
> 
> Any chance one of you could put up a set of current patches somewhere?

I'll upload the delay accounting patches to a newly created lse-tech package.

> I am trying to make heads and tails of them and it's pretty hard as I
> haven't been on lse-tech for long and the lse-tech mailing list
> archives are useless due to the 99 to 1 SPAM ratio ;-(
>


> I am quite concerned about that lock your patches put into struct
> task_struct through struct task_delay_info. Have you done any
> measurements on how this impacts performance on highly threaded apps
> on larger system?

I don't expect the lock contention to be high. The lock is held for a
very short time (across two additions/increments). Moreover, it gets
contended only when the stats are being read (either through /proc or connectors).
Since the reading of stats won't be that frequent (the utility of these
numbers is to influence the I/O priority/rss limit etc. which won't be done
at a very small granularity anyway), I wouldn't expect a problem.

But its better to take some measurements anyway. Any suggestions on a
benchmark ?

> IMHO it seems to make more sense to use something like Jack's proposed
> task_notifier code to lock-less collect the data into task local data
> structures and then take the data from there and ship off to userland
> through netlink or similar like you are doing?
> 
> I am working on modifying Jack's patch to carry task local data and
> use it for not just accounting but other areas that need optional
> callbacks (optional in the sense that it's a feature that can be
> enabled or disabled). Looking at Shailabh's delayacct_blkio() changes
> it seems that it would be really easy to fit those into that
> framework.
> 
> Guess I should post some of this code .....

Please do. If this accounting can fit into some other framework, thats fine too.

-- Shailabh

> Cheers,
> Jes
> 

