Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWBFXpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWBFXpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWBFXpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:45:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12461 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964876AbWBFXpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:45:55 -0500
Date: Mon, 6 Feb 2006 15:45:37 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: ak@suse.de, clameter@engr.sgi.com, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206154537.a3e8cc25.pj@sgi.com>
In-Reply-To: <20060206200506.GA13466@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<200602061811.49113.ak@suse.de>
	<Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
	<200602061936.27322.ak@suse.de>
	<20060206184330.GA22275@elte.hu>
	<20060206120109.0738d6a2.pj@sgi.com>
	<20060206200506.GA13466@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> And it seems that for the workloads you cited, the most natural 
> direction to drive the 'spreading' of resources is from the VFS side.  
> That would also avoid the problem Andrew observed: the ugliness of a 
> sysadmin configuring the placement strategy of kernel-internal slab 
> caches. It also feels a much more robust choice from the conceptual POV.

Arrghh ...

I'm confused, on several points.

I've discussed this some with my SGI colleagues, and think I understand
where they are coming from.

But I can't make sense of your recommendation, Ingo.

I don't yet see why you find this more natural or robust, but let me
deal with some details first.

I don't recall Andrew observing ugliness in a sysadmin configuring
a kernel slab.  I recall him asking to add such ugliness.  My proposal
just had a "memory_spread" boolean, which asked for the kernel (1) to
spread memory, at least getting the big kinds of allocations done from
the apps perspective, within the kernel, but (2) leaving the user
address space pages to be placed by the default node-local policy.
No mention there of slab caches.  It was Andrew who wanted to add
such details.

First it might be most useful to explain a detail of your proposal that
I don't get, which is blocking me from considering it seriously.

I understand mount options, but I don't know what mechanisms (at the
kernel-user API) you have in mind to manage per-directory and per-file
options.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
