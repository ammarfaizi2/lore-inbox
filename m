Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUBPR4a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUBPR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:56:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:50570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265801AbUBPR41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:56:27 -0500
Date: Mon, 16 Feb 2004 09:56:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
In-Reply-To: <1076904084.12300.189.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
 <1076904084.12300.189.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> No, it's not. I posted a patch fixing that. Enclosed again below.

I don't think this is right.

It gets the same-tty case wrong, and the reason it gets it wrong is that 
it does its thing in entirely the wrong place.

The console layer already always calls "unblank_screen()" on any switch to
text mode, _regardless_ of whether it was switching from another console
or not. That should be the place where this is done, and perhaps by
changing the console layer to be a bit more helpful about things (mainly
re-name the damn thing, since it has nothing to do with "unblank" any
more).

"unblank_screen()" is really the same as "reset_screen" - it's also called
on resume. While "do_blank_screen()" is basically "go away".

So why don't you just reset the thing in "con_blank()" that gets called in 
all the right cases?

		Linus
