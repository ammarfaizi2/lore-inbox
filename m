Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWBFU1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWBFU1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWBFU1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:27:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64130 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964781AbWBFU1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:27:44 -0500
Date: Mon, 6 Feb 2006 12:27:24 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@engr.sgi.com, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206122724.03875932.pj@sgi.com>
In-Reply-To: <200602061948.25314.ak@suse.de>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<200602061936.27322.ak@suse.de>
	<Pine.LNX.4.62.0602061039420.16829@schroedinger.engr.sgi.com>
	<200602061948.25314.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes I can see it not working well when a dentry is put at the other 
> end of a 256 node altix. That is why just spreading it to nearby
> nodes might be an alternative.

As I've suggested earlier in this thread:
=========================================

I suspect that spreading evenly over the current tasks mems_allowed is
just what is needed.

There is nothing special about big Altix systems here; just use
task->mems_allowed.  For all but tasks using MPOL_BIND, this means
spreading the caching over the nodes in the tasks cpuset.

We don't want to spread over a larger area, because cpusets need to
maintain a fairly aggressive containment.  One jobs big data set must
not pollute the cpuset of another job, except in cases involving kernel
distress.

Let the cpusets define what is "the right size" to spread across.
We do not need additional kernel heuristics or options to decide this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
