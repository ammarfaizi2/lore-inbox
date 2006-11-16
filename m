Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424209AbWKPPvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424209AbWKPPvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424210AbWKPPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:51:22 -0500
Received: from dvhart.com ([64.146.134.43]:1700 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1424209AbWKPPvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:51:22 -0500
Message-ID: <455C8875.3070109@mbligh.org>
Date: Thu, 16 Nov 2006 07:49:09 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Christian Krafft <krafft@de.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, steiner@sgi.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
References: <20061115193049.3457b44c@localhost>	<20061115193437.25cdc371@localhost>	<Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>	<20061115215845.GB20526@sgi.com>	<Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>	<455B9825.3030403@mbligh.org>	<Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>	<20061116095429.0e6109a7.kamezawa.hiroyu@jp.fujitsu.com>	<Pine.LNX.4.64.0611151653560.24565@schroedinger.engr.sgi.com> <20061116164037.58b3aaeb@localhost>
In-Reply-To: <20061116164037.58b3aaeb@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Krafft wrote:
> On Wed, 15 Nov 2006 16:57:56 -0800 (PST)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
>> On Thu, 16 Nov 2006, KAMEZAWA Hiroyuki wrote:
>>
>>>> But there is no memory on the node. Does the zonelist contain the zones of 
>>>> the node without memory or not? We simply fall back each allocation to the 
>>>> next node as if the node was overflowing?
>>> yes. just fallback.
>> Ok, so we got a useless pglist_data struct and the struct zone contains a 
>> zonelist that does not include the zone.
> 
> Okay, I slowly understand what you are talking about.
> I just tried a "numactl --cpunodebind 1 --membind 1 true" which hit an uninitialized zone in slab_node:
> 
> return zone_to_nid(policy->v.zonelist->zones[0]);
> 
> I also still don't know if it makes sense to have memoryless nodes, but supporting it does.
> So wath would be reasonable, to have empty zonelists for those node, or to check if zonelists are uninitialized ?

You don't want empty zonelists on a node containing CPUs, else it won't
know where to allocate from. You just want to make sure that the zones
in that node (if existant) are not contained in *anyone's* zonelist.

M.

