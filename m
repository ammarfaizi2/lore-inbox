Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUBYBda (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUBYBda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:33:30 -0500
Received: from gate.crashing.org ([63.228.1.57]:61364 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262560AbUBYBdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:33:20 -0500
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077672403.1084.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 12:26:43 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > We have now with 2.6 a good input and sound layers.  Just by fixing
> > the graphics layer many interesting userland projects could be born.
> 
> I agree. The graphics layer is the last frontier.

It is. What we really need right now is a proper way to get the mode
lists. but more than that. We need to expose per-output detection data,
mapping of CRTCs to outputs, and a way to change that mapping & trigger
a re-probe. All of that can probably not be done in a completely card
neutral way.  

I've started working on a userland library taking care of managing
the "environment", that is the various screens & heads, their modes,
the geometry (relative screen positions), and such. I haven't gone
very far yet, but the idea is ultimately to have the entire mode
setting go through this library. That include proper interface to
the kernel drivers (whatever they become, fbdev is what we have to
day but that may change) and that also probably means moving some
of the monitor management down to userland.

This library will also be responsible to broadcast, possibly via
D-BUS, events like screen hotplug and mode changes. We are thinking
about interfacing the fd.o xserver on this among others. It will
not do anything about rendering though.

That leads to another issue which is arbitration at the low level
driver between rendering & mode switching. That should be done by
the kernel driver at some point, we need to merge the mode setting
driver (fbdev) and the command queue diver (DRI). Probably moving 
some of the higher level mode management out of the kernel driver
down to this userland library.

Anyway, it's all mostly ideas at this point. I'm trying to get an
API out with a test implementation on top of fbdev. At which point
we'll be able to move further.

Ben.


