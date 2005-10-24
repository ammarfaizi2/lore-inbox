Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVJXOhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVJXOhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 10:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVJXOhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 10:37:40 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:63176 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750800AbVJXOhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 10:37:40 -0400
Date: Mon, 24 Oct 2005 07:37:15 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset bitmap and mask remap operators
Message-Id: <20051024073715.02e1f3e3.pj@sgi.com>
In-Reply-To: <20051024013713.25770d14.akpm@osdl.org>
References: <20051024072744.10390.35722.sendpatchset@jackhammer.engr.sgi.com>
	<20051024004833.50d9676b.akpm@osdl.org>
	<20051024011613.691e28f4.pj@sgi.com>
	<20051024013713.25770d14.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> hm.  That hides what's really going on from the programmer.
> 
> Oh well - you're the only guy who dinks with that stuff anyway ;)

Halloween comes a week early to the Morton household.  The patch from
hell, circa April 2004, lives on to haunt Andrew <grin>.

By the time we (wli, rusty, colpatch, ...) incorporated the following
various constraints on these cpumask/nodemask macros, we were fortunate
to only violate the "obvious to the programmer" constraint on the
implementation internals:
  - near perfect code gen on small systems (1 word masks)
  - near perfect code gen on large systems (multiword masks)
  - type checking on arguments
  - keep the existing macro-style calling conventions:
	cpus_and(result, input1, input2)
  - a single bitmap internal implementation - the rest just wrappers
  - dramatic shinkage of kernel source devoted to this stuff
  - reduction in kernel text size across all architectures.

Probably it is best that we not ask too many questions at this time ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
