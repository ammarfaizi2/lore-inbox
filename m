Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbVEGIHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbVEGIHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVEGIHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:07:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51465 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262770AbVEGIHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:07:16 -0400
Date: Sat, 7 May 2005 09:58:29 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ricky Beam <jfbeam@bluetronic.net>, nico-kernel@schottelius.org,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050507075828.GF777@alpha.home.local>
References: <20050419121530.GB23282@schottelius.org> <Pine.GSO.4.33.0505062324550.1894-100000@sweetums.bluetronic.net> <20050506211455.3d2b3f29.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506211455.3d2b3f29.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, May 06, 2005 at 09:14:55PM -0700, Andrew Morton wrote:
> Ricky Beam <jfbeam@bluetronic.net> wrote:
> >
> > Short of a kernel module to export the kernel variables, that's the only
> >  damned way to find the number of cpus in a Linux system.
> 
> Question is: do you need to know the number of CPUs (why?) or do you need
> to know the number of CPUs which you're currently allowed to use or do you
> need to know the maximum number of CPUs which you are allowed to bind
> yourself to, or what?

I personally think that what would be useful is not "the number of CPUs"
(which does not make any sense), but an enumeration of :

    - the physical nodes (for NUMA)
    - the physical CPUs
    - each CPU's cores (for multi-core)
    - each core's siblings (for HT/SMT)

each of which would report their respective id for {set,get}_affinity().
This way, the application would be able to choose how it needs to spread
over available CPUs depending on its workload. But IMHO, this should
definitely not be put in cpuinfo. I consider that cpuinfo is for the human.

> Probably these things can be worked out via the get/set_affinity() syscalls
> and/or via the cpuset sysfs interfaces, but it isn't as simple as you're
> assuming.

At least it would be simpler with some layout info like above.

Cheers,
Willy

