Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751862AbWB1B4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbWB1B4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWB1B4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:56:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8107 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751862AbWB1B4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:56:17 -0500
Date: Mon, 27 Feb 2006 17:56:03 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060227175603.e858eade.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602271510320.12637@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<200602272202.34346.ak@suse.de>
	<Pine.LNX.4.64.0602271414290.12093@schroedinger.engr.sgi.com>
	<200602272339.42574.ak@suse.de>
	<Pine.LNX.4.64.0602271510320.12637@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm ... your thread with Andi confuses me ...

Oh well.

I take it that Andi is suggesting that there be the option to override
the tasks mempolicy, in the particular case of these file i/o slab
caches, with an interleave over the online nodes.

This option would be useful in the case that a system is not using
cpusets, but still wants to spread out these particular (sometimes
large) file i/o caches.

Questions for Andi:

 1) Are you content to have such a interleave of these particular file
    i/o slabs triggered by a mm/mempolicy.c option?  Or do you think
    we need some sort of task external API to invoke this policy?

    If mempolicy API works, then I would think that someone, such as
    yourself or Christoph, could easily enough propose an extension to
    the mempolicy API that invoked such a policy.  It could leverage
    some of the apparatus already provided by my current patchset here,
    such as the per-slab SLAB_MEMP_SPREAD flag settings, the task
    PF_* flag bits and the hook in ____cache_alloc() to call out to
    alternate_node_alloc().

    If a system wide API (that can be externally imposed on some or
    all tasks from outside the task) is desirable, then I am left
    wondering why you don't use cpusets for this.

 2) Do you recommend that the page (file buffer) cache also be
    interleavable, across all online nodes, if optionally requested,
    on systems not using cpusets?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
