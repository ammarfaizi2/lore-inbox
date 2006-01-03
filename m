Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWACNaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWACNaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWACNar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:30:47 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:38399 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932367AbWACNaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:30:22 -0500
Date: Tue, 3 Jan 2006 05:28:15 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>, vatsa@in.ibm.com
Subject: Re: [patch] latency tracer, 2.6.15-rc7
In-Reply-To: <20060103111211.GA5075@in.ibm.com>
Message-ID: <Pine.LNX.4.62.0601030524570.30559@qynat.qvtvafvgr.pbz>
References: <1135990270.31111.46.camel@mindpipe> <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
 <1135991732.31111.57.camel@mindpipe> <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
 <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com>
 <1136004855.3050.8.camel@mindpipe> <20051231201426.GD5124@us.ibm.com>
 <1136094372.7005.19.camel@mindpipe> <Pine.LNX.4.64.0601011047320.3668@g5.osdl.org>
 <20060103111211.GA5075@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006, Dipankar Sarma wrote:

> I do agree that the two layers of batching really makes things
> subtle. I think the best we can do is to figure out some way of
> automatic throttling in RCU and forced quiescent state under extreme
> conditions. That way we will have less dependency on softirq
> throttling.

would it make sense to have the RCU subsystems with a threshold so that 
when more then X items are outstanding they trigger a premption of all 
other CPU's ASAP (forceing the scheduling break needed to make progress on 
clearing RCU)? This wouldn't work in all cases, but it could significantly 
reduce the problem situations.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

