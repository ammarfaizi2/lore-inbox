Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWIMX5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWIMX5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 19:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWIMX5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 19:57:13 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:22754 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S1751247AbWIMX5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 19:57:12 -0400
Date: Wed, 13 Sep 2006 16:59:09 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
Message-ID: <20060913235909.GC4359@localhost.localdomain>
References: <20060912144518.GA4653@localhost.localdomain> <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com> <20060912195246.GA4039@localhost.localdomain> <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com> <20060913221435.GA4359@localhost.localdomain> <Pine.LNX.4.64.0609131517370.20316@schroedinger.engr.sgi.com> <20060913233741.GB4359@localhost.localdomain> <Pine.LNX.4.64.0609131641340.20799@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609131641340.20799@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 04:48:58PM -0700, Christoph Lameter wrote:
> On Wed, 13 Sep 2006, Ravikiran G Thirumalai wrote:
> 
> The two cases were your patch still applied memory policies were:
> 
> 1. nodeid = -1. This is one particular case that we wanted to fix because
>    it means use numa_node_id().

OK, I did not realise nodeid = -1 _should_ imply current node.  Not using
mempolicy makes sense then.

> 
> 2. The case where the nodelist does not yet exist.
> 
> AFAIK this situation only occurs on boot strap when we are actually 
> attempting to allocate from a different node than what we are running on. 
> Falling back to the local node is the right thing to do because we have 
> that already working. A process that is running on a node must always have 
> the nodelists for all caches allocated. The cpuup callbacks take care of that.
> 
> kmalloc_node needs work like page_alloc_node. page_alloc_node() never 
> consults memory policies and thus one would not expect kmalloc_node to do 
> so either.

OK.
