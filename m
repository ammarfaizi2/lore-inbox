Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWBFJ1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWBFJ1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWBFJ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:27:45 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1950 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750837AbWBFJ1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:27:44 -0500
Date: Mon, 6 Feb 2006 01:27:26 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206012726.e3c7a537.pj@sgi.com>
In-Reply-To: <20060206090927.GA11933@elte.hu>
References: <20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
	<20060205232253.ddbf02d7.pj@sgi.com>
	<20060206074334.GA28035@elte.hu>
	<20060206001959.394b33bc.pj@sgi.com>
	<20060206082258.GA1991@elte.hu>
	<20060206084001.GA5600@elte.hu>
	<20060206010304.e79ca2e5.pj@sgi.com>
	<20060206090927.GA11933@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo asked:
> what type of objects need to be spread (currently)? It seems that your 
> current focus is on filesystem related objects: 

In addition to the filesystem related objects called out in
this current patch set, we also have some xfs directory
and inode caches.  An xfs patch is winding its way toward
lkml that will enhance the xfs cache creation calls a little,
so that we can pick off the particular slab caches we need to
be able to spread, while leaving other xfs slab caches with
the default node-local policy.

>  does any userspace mapped memory need to be spread 

I don't think so, but I am not entirely confident of my answer
tonight.  I would expect the applications I care about to place mapped
pages by being careful to make the first access (load or store) of that
page from a cpu on the node where they wanted that page placed.

So, yes, either mostly filesystem related objects, or all such.

I'm not sure which.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
