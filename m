Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWBFIrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWBFIrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWBFIrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:47:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56265 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750800AbWBFIri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:47:38 -0500
Date: Mon, 6 Feb 2006 00:47:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206004720.0374b820.pj@sgi.com>
In-Reply-To: <20060206082258.GA1991@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154944.36387a86.akpm@osdl.org>
	<20060205203358.1fdcea43.akpm@osdl.org>
	<20060205215052.c5ab1651.pj@sgi.com>
	<20060205220204.194ba477.akpm@osdl.org>
	<20060206061743.GA14679@elte.hu>
	<20060205232253.ddbf02d7.pj@sgi.com>
	<20060206074334.GA28035@elte.hu>
	<20060206001959.394b33bc.pj@sgi.com>
	<20060206082258.GA1991@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo asked:
> so in practice, the memory spreading is in fact a global setting, used
> by all cpusets that matter? 

I don't know if that is true or not.

I'll have to ask my field engineers, who actually have experience
with a variety of customer workloads.

... well, I do have partial knowledge of this.

When I was coding this, I suggested that instead of picking some of the
slab caches to memory spread, we pick them all, as that would be easier
to code.

That suggestion was shot down by others more experienced within SGI, as
some slab caches hold what is essentially per-thread data, that is
fairly hot in the thread context that allocated it.  Spreading that data
would quite predictably increase cross-node bus traffic, which is bad.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
