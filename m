Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbUBYBqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUBYBnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:43:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:63156 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262359AbUBYBgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:36:25 -0500
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
Message-Id: <1077672591.978.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 12:29:52 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 12:21, James Simmons wrote:
> > Sure, hopefully fbdev drivers became more 'intelligent', with just a
> > 
> > echo "1024x768x16-75" > /sys/class/fbdev/0/geometry
> > 
> > they will compute internally the timings or get it from EDID and
> > glad the user with something correct for the hardware.
> > 
> > cat /sys/class/fbdev/0/modes
> > 
> > will give you the modes supported by the card.
> 
> Yes.

Note that "the modes supported by the card" means nothing.

They depend on something fundamentally dynamic, which is what is
connected to what output, mixed with some card-spcific limitations
(like bandwidth limitations when using 2 very big monitors, vram
limitations, etc...)

You can not really know a-priori what modes will be available for
sure. You can provide a list of modes that are considered as valid
for a given output, but the whole mode setting scheme cannot be
anything else but non-deterministic. You setup a global configuration,
send it down the driver, and obtain a new configuration which may or
may not be what you asked for.

I'm trying to address the API issues as part of the userland library
I'm talking about in the other email. The actual interface to the
kernel driver should ultimately be hidden, and eventually private
between card-specific kernel driver and card-specific module in
the userland API.

Ben.


