Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277092AbRJHTNI>; Mon, 8 Oct 2001 15:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277085AbRJHTM6>; Mon, 8 Oct 2001 15:12:58 -0400
Received: from zok.SGI.COM ([204.94.215.101]:35215 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277084AbRJHTMo>;
	Mon, 8 Oct 2001 15:12:44 -0400
Date: Mon, 8 Oct 2001 12:12:06 -0700
From: Jesse Barnes <jbarnes@sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
In-Reply-To: <1814766007.1002542145@mbligh.des.sequent.com>
Message-ID: <Pine.SGI.4.21.0110081207520.1003634-100000@spamtin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Oct 2001, Martin J. Bligh wrote:

> Depending on how much extra latency each hop introduces, it may well
> not be worth adding the complexity of differentiating beyond local vs
> remote? At least at first ...

Well, there's already some code to do that (mm/numa.c), but I'm not sure
how applicable it will be to your arch.
 
> Do you know how many hops SGI can get, and how much extra latency 
> you introduce? I know we're something like 10:1 ratio at the moment 
> between local and remote. 

I think we're something like 1.5:1, and we have machines with up to 256
nodes at the moment, so there can be quite a few hops in the worst case.
 
> I guess my main point was that the number of levels was more like constant 
> than linear. Maybe for large interconnected switched systems with small 
> switches, it's n log n, but in practice I think log n is small enough to be 
> considered constant (the number of levels of switches).

Depends on how big your node count gets I guess.
 
> That's what I was planning on ... we'd need m x n classzones, where m
> was the number of levels, and n the number of nodes. Each search would
> obviously be through m classzones. I'll go poke at the current code some more.

Yeah, classzones is one way to go about this.  There are some other simple
ways to do nearest node allocation though, given the current
codebase.  I'm still trying to figure out which is the most flexible.

Jesse

