Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVLVWIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVLVWIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 17:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVLVWIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 17:08:19 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:46494 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1030317AbVLVWIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 17:08:18 -0500
Message-ID: <43AB23C9.8010904@cosmosbay.com>
Date: Thu, 22 Dec 2005 23:08:09 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
References: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu> <43A90225.4060007@cosmosbay.com> <20051221074346.GA2398@elte.hu> <43A90C07.4000003@cosmosbay.com> <20051222211132.GA21742@elte.hu>
In-Reply-To: <20051222211132.GA21742@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> 
> CLI/STI is extremely fast. (In fact in the -rt tree i'm using them 
> within mutexes instead of preempt_enable()/preempt_disable(), because 
> they are faster and generate less register side-effect.)
> 

Yes, but most of my machines have a ! CONFIG_PREEMPT kernel, so 
preempt_enable()/preempt_disable() are empty, thus faster than CLI/STI for sure :)

Then, maybe the patch that moves 'current' in a dedicated x86_64 register may 
help to lower  the cost of preempt_enable()/preempt_disable() on a 
CONFIG_PREEMPT kernel ?

Eric
