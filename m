Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVIMWHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVIMWHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 18:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIMWHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 18:07:53 -0400
Received: from serv01.siteground.net ([70.85.91.68]:52441 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932495AbVIMWHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 18:07:52 -0400
Date: Tue, 13 Sep 2005 15:07:37 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       bharata@in.ibm.com, shai@scalex86.org, rusty@rustcorp.com.au,
       netdev@vger.kernel.org
Subject: Re: [patch 9/11] net: dst_entry.refcount, use, lastuse to use alloc_percpu
Message-ID: <20050913220737.GA6249@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain> <20050913161708.GK3570@localhost.localdomain> <20050913.132442.53540386.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913.132442.53540386.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 01:24:42PM -0700, David S. Miller wrote:
> 
> There is no way in the world this enormous amount of NUMA
> complexity is being added to the destination cache layer.

Agreed the dst changes are ugly; that can be worked on.  But the 
cacheline bouncing problem on the atomic_t dst_entry refcounter has been 
around for quite a while -- even on SMPs, not just NUMA.  We need a solution 
for that.  I thought you were against the dst_entry bloat caused by the 
previous version of the dst patch.  alloc_percpu takes that away.  You had
concerns about workloads with low route locality. Unfortunately we don't have
access to infrastructure setup for such tests :( 

As for the ugliness, would something on the lines of net_device refcounter 
patch in the series above be acceptable?

Thanks,
Kiran
