Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTIDCdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTIDCdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:33:51 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:3498 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264470AbTIDCdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:33:49 -0400
Date: Wed, 03 Sep 2003 19:31:13 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Brown, Len" <len.brown@intel.com>, Giuliano Pochini <pochini@shiny.it>,
       Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <7420000.1062642672@[10.10.2.4]>
In-Reply-To: <20030904013253.GB4306@holomorphy.com>
References: <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com> <20030904013253.GB4306@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 03, 2003 at 06:06:53PM -0700, Larry McVoy wrote:
>> Here's a thought.  Maybe the next kernel summit needs to have a CC cluster
>> BOF or whatever.  I'd be happy to show up, describe what it is that I see
>> and have you all try and poke holes in it.  If the net result was that you
>> walked away with the same picture in your head that I have that would be
>> cool.  Heck, I'll sponser it and buy beer and food if you like.
> 
> It'd be nice if there were a prototype or something around to at least
> get a feel for whether it's worthwhile and how it behaves.
> 
> Most of the individual mechanisms have other uses ranging from playing
> the good citizen under a hypervisor to just plain old filesharing, so
> it should be vaguely possible to get a couple kernels talking and
> farting around without much more than 1-2 P-Y's for bootstrapping bits
> and some unspecified amount of pain for missing pieces of the above.
> 
> Unfortunately, this means
> (a) the box needs a hypervisor (or equivalent in native nomenclature)
> (b) substantial outlay of kernel hacking time (who's doing this?)
> 
> I'm vaguely attached to the idea of there being _something_ to assess,
> otherwise it's difficult to ground the discussions in evidence, though
> worse comes to worse, we can break down to plotting and scheming again.

I don't think the initial development baby-steps are *too* bad, and don't
even have to be done on a NUMA box - a pair of PCs connected by 100baseT
would work. Personally, I think the first step is to do task migration - 
migrate a process without it realising from one linux instance to another. 
Start without the more complex bits like shared filehandles, etc. Something 
that just writes 1,2,3,4 to a file. It could even just use shared root NFS, 
I think that works already.

Basically swap it out on one node, and in on another, though obviously
there's more state to take across than just RAM. I was talking to Tridge
the other day, and he said someone had hacked up something in userspace
which kinda worked ... I'll get some details.

I view UP -> SMP -> NUMA -> SSI on NUMA -> SSI on many PCs -> beowulf cluster
as a continuum ... the SSI problems are easier on NUMA, because you can
wimp out on things like shmem much easier, but it's all similar.

M.

