Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbVA0AIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbVA0AIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVA0AIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:08:12 -0500
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:60579 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S262461AbVAZVoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 16:44:37 -0500
Message-ID: <41F80F41.5040106@bigpond.net.au>
Date: Thu, 27 Jan 2005 08:44:33 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Jack O'Quin" <joq@io.com>, Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au> <20050126100846.GB8720@elte.hu>
In-Reply-To: <20050126100846.GB8720@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>Oops, after rereading the patch, a task that set its RT_CPU_RATIO
>>rlimit to zero wouldn't be escaping the mechanism at all.  It would be
>>suffering maximum throttling. [...]
> 
> 
> my intention was to let 'limit 0' mean 'old RT semantics' - i.e. 'no RT
> CPU time for unprivileged tasks at all', and only privileged tasks may
> do it and then they'll get full CPU time with no throttling.
> 
> so in that context your observation highlights another bug, which i
> fixed in the -D7 patch available from the usual place:
> 
>   http://redhat.com/~mingo/rt-limit-patches/
> 
> not doing the '0' exception would make it harder to introduce the rlimit
> in a compatible fashion. (My current thinking is that the default RT_CPU
> rlimit should be 0.)

One solution to this dilemma might be to set a PF_FLAG on a task 
whenever it gains RT status via this privilege bypass and only apply the 
limit to tasks that have that flag set.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
