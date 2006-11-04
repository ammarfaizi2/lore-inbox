Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752329AbWKDA2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbWKDA2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbWKDA2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:28:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43236 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752329AbWKDA2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:28:34 -0500
Date: Fri, 3 Nov 2006 16:28:31 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061103143145.85a9c63f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006, Andrew Morton wrote:

> But in this application which you are proposing, any correlation with
> elapsed walltime is very slight.  It's just the wrong baseline to use. 
> What is the *sense* in it?

You just accepted Paul's use of a similar mechanism to void cached 
zonelists. He has a one second timeout for the cache there it seems.

The sense is that memory on nodes may be freed and then we need to 
allocate from those nodes again.

> Yes.  And it is wrong to do so.  Because a node may well have no "free"
> pages but plenty of completely stale ones which should be reclaimed.

But there may be other nodes that have more free pages. If we allocate 
from those then we can avoid reclaim.

> Reclaim isn't expensive.

It is needlessly expensive if its done for an allocation that is not bound 
to a specific node and there are other nodes with free pages. We may throw 
out pages that we need later.

