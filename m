Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbVFXFBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbVFXFBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 01:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVFXFBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 01:01:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35029 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263080AbVFXFBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 01:01:47 -0400
Date: Fri, 24 Jun 2005 10:28:54 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
       shai@scalex86.org, akpm@osdl.org
Subject: Re: [PATCH] dst numa: Avoid dst counter cacheline bouncing
Message-ID: <20050624045854.GA6465@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.62.0506231953260.28244@graphe.net> <Pine.LNX.4.62.0506232005030.28244@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506232005030.28244@graphe.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 08:10:06PM -0700, Christoph Lameter wrote:
> The dst_entry structure contains an atomic counter that is incremented and
> decremented for each network packet being sent. If there is a high number of
> packets being sent from multiple processors then cacheline bouncing between
> NUMA nodes can limit the tcp performance in a NUMA system.
> 
> The following patch splits the usage counter into counters per node.
> 

Do we really need to do a distributed reference counter implementation
inside dst cache code ? If you are willing to wait for a while,
we should have modified Rusty's bigref implementation on top of the 
interleaving dynamic per-cpu allocator. We can look at distributed 
reference counter for dst refcount then and see how that can be 
worked out.

Thanks
Dipankar
