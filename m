Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWBFIUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWBFIUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWBFIUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:20:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:34196 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750737AbWBFIUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:20:19 -0500
Date: Mon, 6 Feb 2006 00:19:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206001959.394b33bc.pj@sgi.com>
In-Reply-To: <20060206074334.GA28035@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
	<20060205232253.ddbf02d7.pj@sgi.com>
	<20060206074334.GA28035@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> Could you perhaps outline two actual use-cases 
> that would need two cpusets with different policies,
> on the same box?

We normally run with different policies, in the same box, on different
cpusets at the same time.  But this might be because some cpusets
-need- the memory spreading, and the others that don't are left to the
default policy.

In my immediate experience, I can only outline a hypothetical case,
not an actual case, where the default node-local policy would be sorely
needed, as opposed to just preferred:

    If a job were running several threads, each of which did some
    file i/o in roughly equal amounts, for processing (reading and
    writing) in that thread, it could need the performance that
    depended on these pages being placed node local.

In cpusets running classic Unix loads, such as the daemon processes or
the login sessions, the default node-local would certainly be
preferred, as that policy is well tuned for that sort of load.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
