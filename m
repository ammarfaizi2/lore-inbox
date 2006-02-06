Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWBFOgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWBFOgS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWBFOgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:36:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30658 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751095AbWBFOgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:36:17 -0500
Date: Mon, 6 Feb 2006 06:35:49 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206063549.d155c619.pj@sgi.com>
In-Reply-To: <200602061116.44040.ak@suse.de>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<200602061109.45788.ak@suse.de>
	<20060206101156.GA1761@elte.hu>
	<200602061116.44040.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Perhaps one could do a "near" caching policy for big machines: e.g. 
> if on a big Altix prefer to put it on a not too far away node, but
> spread it out evenly. But it's not clear yet such complexity is needed.

I suspect that spreading evenly over the current tasks mems_allowed is
just what is needed.

There is nothing special about big Altix systems here; just use
task->mems_allowed.  For all but tasks using MPOL_BIND, this means
spreading the caching over the nodes in the tasks cpuset.

We don't want to spread over a larger area, because cpusets need to
maintain a fairly aggressive containment.  One jobs big data set must
not pollute the cpuset of another job, except in cases involving kernel
distress.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
