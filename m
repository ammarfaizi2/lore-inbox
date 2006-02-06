Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWBFSG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWBFSG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWBFSG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:06:57 -0500
Received: from ns2.suse.de ([195.135.220.15]:4780 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932239AbWBFSG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:06:56 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Mon, 6 Feb 2006 18:11:47 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, mingo@elte.hu, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060206063549.d155c619.pj@sgi.com> <Pine.LNX.4.62.0602060839440.16337@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602060839440.16337@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061811.49113.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 17:48, Christoph Lameter wrote:

> This is very different from the typical case of a single threaded process 
> roaming across some data and then terminating. In that case we always want 
> placement of memory as near to the process as possible. In cases were we 
> are not sure about future application behavior it is best to assume that 
> node local is best. Spreading memory allocations for storage that is only 
> accessed from one processor will reduce the performance of an application.
> 
> So the default operating mode needs to be node local.

I still don't quite agree. As long as the latency penalty of going
off node is not too bad (let's say < factor 2) i think it's better
to spread out the caches than to always locate them locally.
That is because kernel object/data cache accesses are far less frequent
than user mapped memory accesses. And it's a good idea to give
the later memory some headstart for local memory.

If you have a much worse worst case NUMA factor it might be different,
but even there it would be a good idea to at least spread it out
to nearby nodes.

-Andi

