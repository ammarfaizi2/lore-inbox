Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263289AbUCRXsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbUCRXrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:47:46 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:47751 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263306AbUCRXZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:25:01 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Date: Thu, 18 Mar 2004 15:23:10 -0800
User-Agent: KMail/1.6.1
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com
References: <1079651064.8149.158.camel@arrakis>
In-Reply-To: <1079651064.8149.158.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181523.10670.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 March 2004 3:04 pm, Matthew Dobson wrote:
> do most anything you'd want to do with a nodemask.  This stops us from
> open-coding nodemask operations, allows non-consecutive node numbering
> (ie: nodes don't have to be numbered 0...numnodes-1), gets rid of
> numnodes entirely (replaced with num_online_nodes()), and will
> facilitate the hotplugging of whole nodes.

My hero! :)  I think this has been needed for awhile, but now that I
think about it, it begs the question of what a node is.  Is it a set
of CPUs and blocks of memory (that seems to be the most commonly used
definition in the code), just memory, just CPUs, or what?  On sn2
hardware, we have the concept of a node without CPUs.  And due to our
wacky I/O layout, we also have nodes without CPUs *or* memory!  (The
I/O guys call these "ionodes".)  And then of course, there are CPUs
that aren't particularly close to any memory (i.e. they have none of
their own, and have to go several hops and/or through other CPUs to
get at memory at all).

I'll take a look at the ia64 bits when I get them (I've only received
two of the seven patches thus far).

Jesse


