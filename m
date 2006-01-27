Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWA0W6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWA0W6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWA0W6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:58:17 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:38849 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1422647AbWA0W6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:58:16 -0500
Message-ID: <43DAA586.5050609@cosmosbay.com>
Date: Fri, 27 Jan 2006 23:58:14 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain>
In-Reply-To: <20060127224433.GB3565@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> On Fri, Jan 27, 2006 at 12:16:02PM -0800, Andrew Morton wrote:
>> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>>> which can be assumed as not frequent.  
>>> At sk_stream_mem_schedule(), read_sockets_allocated() is invoked only 
>>> certain conditions, under memory pressure -- on a large CPU count machine, 
>>> you'd have large memory, and I don't think read_sockets_allocated would get 
>>> called often.  It did not atleast on our 8cpu/16G box.  So this should be OK 
>>> I think.
>> That being said, the percpu_counters aren't a terribly successful concept
>> and probably do need a revisit due to the high inaccuracy at high CPU
>> counts.  It might be better to do some generic version of vm_acct_memory()
>> instead.
> 
> AFAICS vm_acct_memory is no better.  The deviation on large cpu counts is the 
> same as percpu_counters -- (NR_CPUS * NR_CPUS * 2) ...

Ah... yes you are right, I read min(16, NR_CPUS*2)

I wonder if it is not a typo... I mean, I understand the more cpus you have, 
the less updates on central atomic_t is desirable, but a quadratic offset 
seems too much...

Eric

