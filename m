Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUCBATc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 19:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUCBATc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 19:19:32 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:27920 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261516AbUCBATb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 19:19:31 -0500
Date: Tue, 2 Mar 2004 00:19:27 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix VT mode change vs. fbcon
In-Reply-To: <1077931714.22954.61.camel@gaston>
Message-ID: <Pine.LNX.4.44.0403012325010.7718-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > How about calling resize_screen in vt.c instead in this function. This way 
> > fbcon could reset the hardware state :-) 
> 
> Because I don't want to change the semantics in VT too much, the whole
> VT code is rather fragile and I want to avoid beeing invasive at this
> point and trigger all sort of funny side effects.

I have been pondering the code working out a clean method. Basically you 
have two areas of concern with this matter. Both are in vt_ioctl.c
One in vt_ioctl for the case of KDSETMODE. The other place in the same 
file, vt_ioctl.c, is function complete_change_console. 

In functions involved in this are two functions. One is do_blank_screen.
Looking at it you could just break out a new function in vt_ioctl.c. 
Now do_unblank_screen function is a bit trickier. It makes sense that 
a unblank function is called. This is where we would also call other 
functions to reset the display.




