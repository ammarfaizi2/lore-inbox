Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318502AbSGaWfn>; Wed, 31 Jul 2002 18:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSGaWfn>; Wed, 31 Jul 2002 18:35:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48874 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318502AbSGaWfm>;
	Wed, 31 Jul 2002 18:35:42 -0400
Date: Wed, 31 Jul 2002 18:39:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Pavel Machek <pavel@ucw.cz>, Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <15688.25919.138565.6427@wombat.chubb.wattle.id.au>
Message-ID: <Pine.GSO.4.21.0207311832270.8505-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Peter Chubb wrote:

> Maybe we need to roll our own?  I suggest something like:
>       struct linux_volume_header {
> 	     char  volname[16];
> 	     __u32 nparts;
> 	     __u32 blocksize;
> 	     struct linux_partition {
> 		    char partname[16]
> 		    __u64  start;
> 		    __u64  len;
> 		    __u32  usage;
> 		    __u32  flags;
> 	    } parts[]
>     }

Oh, ferchrissake!  WHY???  People, we'd seen a lot of demonstrations
of the reasons why binary structures are *bad* for such stuff.

What the bleedin' hell is wrong with <name> <start> <len>\n - all in ASCII?  
Terminated by \0.  No need for flags, no need for endianness crap, no
need to worry about field becoming too narrow...

What, parsing that would be too slow?  Right.  Sure.  How many times do
we parse partition table?  How many times do we end up reading it from
disk?  How does IO time compare to the "overhead" of trivial sscanf loop?

Furrfu...  "ASCII is tough, let's go shopping"...

