Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUFFNeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUFFNeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUFFNeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:34:25 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:15191 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263616AbUFFNeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:34:23 -0400
Date: Sun, 6 Jun 2004 06:42:22 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: rusty@rustcorp.com.au, mikpe@csd.uu.se, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040606064222.781a5d52.pj@sgi.com>
In-Reply-To: <20040606123611.GU21007@holomorphy.com>
References: <20040604112744.GZ21007@holomorphy.com>
	<20040604113252.GA21007@holomorphy.com>
	<20040604092316.3ab91e36.pj@sgi.com>
	<20040604162853.GB21007@holomorphy.com>
	<20040604104756.472fd542.pj@sgi.com>
	<20040604181233.GF21007@holomorphy.com>
	<1086487651.11454.19.camel@bach>
	<20040606051657.3c9b44d3.pj@sgi.com>
	<20040606121327.GT21007@holomorphy.com>
	<20040606052843.5bbe16f3.pj@sgi.com>
	<20040606123611.GU21007@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William wrote:
> Why do I have to put up with this and why do they always come after me?

I do not understand this.  Probably just as well.

> All of their sizes are rounded up to CHAR_BIT*sizeof(cpumask_t)

The number of bits in a mask is CHAR_BIT*sizeof(cpumask_t), yes.
So -- your point being?

> and all of their contents are variable.

No - not unless my commentary describing these maps in the cpumask.h
file in this patch is wrong.  Some of the contents are fixed at boot,
such as cpu_possible_map.  And again, your point being?

> Hmm. /proc/config.gz will do for now.

Only available if IKCONFIG, IKCONFIG_PROC is configured on.

Care to try again ...

Really, if you want to know which CPUs it is possible to have present,
you are describing cpu_possible_map.  While it is an accident of the
current implementation that in the HOTPLUG configuration this is set to
all CPUs from 0 to NR_CPUS-1, i.e. to CPU_MASK_ALL, that fact is not a
design constant, and hence not any basis for designing what information
should be exposed by the kernel to user space.

The user code needs to know the value of these maps, and they need to
know how big (bytes or longs) the maps are, so they can get them across
the kernel/user boundary.

If you claim they need to know whether NR_CPUS is 47 or 48, for hotplug
purposes, then I can only presume that you are assuming that
cpu_possible_map is by design always set to CPU_MASK_ALL. We wouldn't
even have a cpu_possible_map if that were a design constant.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
