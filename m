Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVGaBVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVGaBVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVGaBVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:21:18 -0400
Received: from graphe.net ([209.204.138.32]:61064 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262949AbVGaBVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:21:17 -0400
Date: Sat, 30 Jul 2005 18:21:15 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Paul Jackson <pj@sgi.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] String conversions for memory policy
In-Reply-To: <20050730181418.65caed1f.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0507301814540.31359@graphe.net>
References: <Pine.LNX.4.62.0507291137240.3864@graphe.net>
 <20050729152049.4b172d78.pj@sgi.com> <Pine.LNX.4.62.0507291746000.8663@graphe.net>
 <20050729230026.1aa27e14.pj@sgi.com> <Pine.LNX.4.62.0507301042420.26355@graphe.net>
 <20050730181418.65caed1f.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005, Paul Jackson wrote:

> I suspect you should do the same.  I doubt we want to expose
> zones to user space here.

The problem is how to convert them back for display. Match the zones in 
groups of three to the zones in a node and then print out the node?
 
> I will leave it to Andi to address your questions about memory
> pressure on lower numbered nodes when using MPOL_BIND.  I suspect
> that for some of the uses you consider here, such as binding to a
> set of more than one node, that cpusets will provide capabilities
> closer to what you have in mind.

This has nothing to do with what is in my mind. The implementation is not 
conforming to the documentation. This is from "man numa_set_bind":

numa_bind binds the current thread and its children to the
       nodes  specified  in  nodemask.  They will only run on the
       CPUs of the specified nodes  and  only  able  to  allocate
       memory  from them.  This function is equivalent to calling
       numa_run_on_node_mask and numa_set_membind with  the  same
       argument.

numa_set_membind sets the  memory  allocation  mask.   The
       thread  will  only  allocate  memory from the nodes set in
       nodemask.   Passing  an  argument  of   numa_no_nodes   or
       numa_all_nodes turns off memory binding to specific nodes.


I do not get from this that memory is allocated always beginning with the 
lowest node first but that the nodes from which allocations can be done is 
restricted.

Who else would know details about memory policies?
