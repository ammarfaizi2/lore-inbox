Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbVIVPiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbVIVPiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVIVPiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:38:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42695 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030408AbVIVPiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:38:02 -0400
Date: Thu, 22 Sep 2005 08:37:36 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Christoph Hellwig <hch@infradead.org>, Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <200509221505.05395.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de>
 <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Andi Kleen wrote:

> On Thursday 22 September 2005 14:58, Christoph Hellwig wrote:
> 
> > Umm, no - adding set_fs/get_fs mess for things like that is not right.
> 
> I think it's fine. We're using it for various other interfaces too. In fact
> sys_set_mempolicy is already used elsewhere in the kernel too.

It should really be do_set_mempolicy instead to be cleaner. I got a patch 
here that fixes the policy layer.

But still I agree with Christoph that a real vmalloc_node is better. There 
will be no fuzzing around with memory policies etc and its certainly 
better performance wise.
