Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSG2Ta1>; Mon, 29 Jul 2002 15:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317591AbSG2Ta1>; Mon, 29 Jul 2002 15:30:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57997 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317590AbSG2Ta0>;
	Mon, 29 Jul 2002 15:30:26 -0400
Date: Mon, 29 Jul 2002 12:33:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Adam Belay <ambx1@netscape.net>
cc: rgooch@atnf.csiro.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrate driverfs and devfs (2.5.28)
In-Reply-To: <3D445C2F.20603@netscape.net>
Message-ID: <Pine.LNX.4.44.0207291214340.22697-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wow. I don't know whether to laugh, or to cry. 

On Sun, 28 Jul 2002, Adam Belay wrote:

> This patch integrates driverfs and devfs.  A summary is as follows:
> - create new interface directory and move interface.c
>        * I intend to add more to this directory later
> - add devfs entry list
> - add devfs related functions
> - create devfs interface
>     This patch is intended to be as non intrusive as possible.  Therefore
> it doesn't modify devfs directly but instead creates a layer above it.
> This is due to the fact that if devfs was modified it would break
> every driver.  Eventually we have to decide when and how to
> integrate it directly,  This patch will provide the necessary
> infrastructure.  Please Apply.

Not a chance. I refuse to apply any devfs interface layers to the device 
model core, or any devfs-specific members to the device model data 
structures. And, that's just on principle. 

As for technical reasons, why on earth would you want to do this in the 
first place? 

We've collectively decided that enforcing device naming policy in the 
kernel is the Wrong Thing To Do. devfs does this; and your patch furthers 
the pain. 

Besides, look at the interace. Tell me devfs_register is not horrid. 8 
parameters is rediculous, and you want to add another one? And, change 
every driver? 

I won't touch devfs, as it's unmaintainable. I won't even look at it, 
because it's unreadable. But, if you really want to build a bridge between 
the two, I would suggest looking at a way to collapse some of the data 
structures and the calls. devfs_register (or the like) should take 1 
structure with all the information it needs in it. Most of that data you 
can derive from other places (like a higher level). In fact, IMO, it 
should be the higher level that is doing the registration of the devices, 
not the individual drivers themselves. 

I appreciate the effort, but I don't support it. We should soon have a 
working device class model, which is where you'll start to see devfs-like 
concepts handled in a sane way. Please look there for ideas, rather than 
devfs. 

Thanks,

	-pat

