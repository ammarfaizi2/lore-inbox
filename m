Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUBYV3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUBYVZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:25:55 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:27653 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261609AbUBYVYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:24:21 -0500
Date: Wed, 25 Feb 2004 21:24:16 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
In-Reply-To: <1077672403.1084.45.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402252109030.24952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is. What we really need right now is a proper way to get the mode
> lists. but more than that. We need to expose per-output detection data,
> mapping of CRTCs to outputs, and a way to change that mapping & trigger
> a re-probe. All of that can probably not be done in a completely card
> neutral way.  

Agree.
 
> I've started working on a userland library taking care of managing
> the "environment", that is the various screens & heads, their modes,
> the geometry (relative screen positions), and such. I haven't gone
> very far yet, but the idea is ultimately to have the entire mode
> setting go through this library. 

   I think this is a bad idea. This has been tried before. In the 
opensource community there is no such a thing as a standard library. 
We can see that with directfb and X windows, sdl, gtk/qt embedded, etc. 
Understand that I have no problem with having lots of libraries. Its 
just the reality is your library will be just one amoung many. 
   The time will come when someone will send you a patch and you will 
reject it and then the person will go off and make his/her own library.
Or someone will look at your work and say I can do better. Then we end
up with a bunch of libraries doing basically similiar things. Which one 
does the developer use then? We can't force them to use the "standard"
one. 
    The kernel really needs to be the only state machine for the hardware. 
Library developers will usually use the kernel standard interfaces. 

> This library will also be responsible to broadcast, possibly via
> D-BUS, events like screen hotplug and mode changes. We are thinking
> about interfacing the fd.o xserver on this among others. It will
> not do anything about rendering though.

I like to see the D-BUS pick up these events :-) It would come in handy 
for the JVMs I work on.
 
> That leads to another issue which is arbitration at the low level
> driver between rendering & mode switching. That should be done by
> the kernel driver at some point, we need to merge the mode setting
> driver (fbdev) and the command queue diver (DRI). 

I agree they have to be merged.

> Probably moving 
> some of the higher level mode management out of the kernel driver
> down to this userland library.

Bad idea.

