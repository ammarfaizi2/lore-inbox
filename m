Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVIWRsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVIWRsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIWRsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:48:01 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:48672 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1750900AbVIWRsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:48:00 -0400
Message-ID: <43343FC9.5090601@cosmosbay.com>
Date: Fri, 23 Sep 2005 19:47:53 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Harald Welte <laforge@netfilter.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Andi Kleen <ak@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de> <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de> <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com> <4332D2D9.7090802@cosmosbay.com> <20050923171120.GO731@sunbeam.de.gnumonks.org>
In-Reply-To: <20050923171120.GO731@sunbeam.de.gnumonks.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte a écrit :
> On Thu, Sep 22, 2005 at 05:50:49PM +0200, Eric Dumazet wrote:
> 
>>Christoph Lameter a écrit :
>>
>>>It should really be do_set_mempolicy instead to be cleaner. I got a patch here that fixes the 
>>>policy layer.
>>>But still I agree with Christoph that a real vmalloc_node is better. There will be no fuzzing 
>>>around with memory policies etc and its certainly better performance wise.
>>
>>vmalloc_node() should be seldom used, at driver init, or when a new
>>ip_tables is loaded. If it happens to be a performance problem, then
>>we can optimize it.  Why should we spend days of work for a function
>>that is yet to be used ?
> 
> 
> I see a contradiction in your sentence.  "a new ip_tables is loaded"
> every time a user changes a single rule.  There are numerous setups that
> dynamically change the ruleset (e.g. at interface up/down point, or even
> think of your typical wlan hotspot, where once a user is authorized,
> he'll get different rules.
> 

But a user changing a single rule usually calls (fork()/exec()) a program 
called iptables. The underlying cost of all this, plus copying the rules to 
user space, so that iptables change them and reload them in the kernel is far 
more important than an hypothetical vmalloc_node() performance problem.

Eric
