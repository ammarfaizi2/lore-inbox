Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbULQFQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbULQFQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 00:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbULQFQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 00:16:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32430 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262747AbULQFQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 00:16:22 -0500
Date: Fri, 17 Dec 2004 00:15:54 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Bryan Fulton <bryan@coverity.com>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>,
       <netfilter-devel@lists.netfilter.org>
Subject: Re: [Coverity] Untrusted user data in kernel
In-Reply-To: <1103247211.3071.74.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.44.0412170012040.12382-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This at least needs CAP_NET_ADMIN.


On Thu, 16 Dec 2004, Bryan Fulton wrote:
> ////////////////////////////////////////////////////////
> // 3:   /net/ipv6/netfilter/ip6_tables.c::do_replace  //
> ////////////////////////////////////////////////////////
>  
> - tainted unsigned scalar tmp.num_counters multiplied and passed to
> vmalloc (1161) and memset (1166) which could overflow or be too large
> 
> Call to function "copy_from_user" TAINTS argument "tmp"
> 
> 1143            if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
> 1144                    return -EFAULT;
> 
> ...
> 
> TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
> sink.
> 
> 1161            counters = vmalloc(tmp.num_counters * sizeof(struct
> ip6t_counters));
> 1162            if (!counters) {
> 1163                    ret = -ENOMEM;
> 1164                    goto free_newinfo;
> 1165            }
> 
> TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
> sink.
> 
> 1166            memset(counters, 0, tmp.num_counters * sizeof(struct
> ip6t_counters));
> 

-- 
James Morris
<jmorris@redhat.com>



