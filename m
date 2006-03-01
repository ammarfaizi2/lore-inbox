Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWCAT2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWCAT2G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWCAT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:28:05 -0500
Received: from mx1.suse.de ([195.135.220.2]:38097 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750725AbWCAT2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:28:03 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Wed, 1 Mar 2006 20:21:58 +0100
User-Agent: KMail/1.9.1
Cc: clameter@engr.sgi.com, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200603011934.34136.ak@suse.de> <20060301105844.d5b243f2.pj@sgi.com>
In-Reply-To: <20060301105844.d5b243f2.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012021.59638.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 19:58, Paul Jackson wrote:
> Andi wrote:
> > The main reason i'm reluctant to use this is that the cpuset fast path
> > overhead (e.g. in memory allocators etc.) is quite large
> 
> I disagree.
> 
> I spent much time minimizing that overhead over the last few months, as
> a direct result of your recommendation to do so.

IIRC my recommendation only optimized the case of nobody using
cpuset if I remember correctly. 

Using a single cpuset would already drop into the slow path, right?

Hmm, possibly it's better now, but I remember being shocked last
time I looked at the code in detail ow much code it executed for a normal 
page allocation and how many cache lines it touched. This was some time
ago admittedly.

Also on a different angle I would like to make the dcache/inode spreading 
basically default on x86-64 and I'm not sure I want to get into the business
of explaining all the distributions how to set up cpusets and set up
new file systems.
For that a single switch that can be just set by default is much more
practical.

> 
> Especially in the case that all tasks are in the root cpuset (as in the
> scenario I just suggested for setting this memory spreading policy for
> all tasks), the overhead is practically zero. 

Ok.

> The key hook is an 
> inline test done (usually) once per page allocation on an essentially
> read only global 'number_of_cpusets' that determines it is <= 1.
> 
> I disagree with your "quite large" characterization.

Agreed perhaps it was somewhat exaggerated.

-Andi
