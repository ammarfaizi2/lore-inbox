Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUBPXQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266002AbUBPXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:14:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:3724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265979AbUBPXJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:09:50 -0500
Date: Mon, 16 Feb 2004 15:09:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
In-Reply-To: <1076972267.3649.81.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402161503490.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
  <1076904084.12300.189.camel@gaston>  <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
  <1076968236.3648.42.camel@gaston>  <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
  <1076969892.3649.66.camel@gaston>  <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
 <1076972267.3649.81.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> That's what I was talking about: what drivers should I convert :) On
> PPC, I don't build things like vgacon etc... Anyway, patch coming soon.

I'd suggest converting all the ones you can find - on the assumption that 
adding the extra argument (and ignoring it) is the always the right thing 
to do. 

So the "conversion" would be to just change the function declaration, and 
none of the code. Except for fbdev (and even there that conversion would 
be "correct" - it just wouldn't take advantage of the new information).

> Note that a mode_switch separate from blank would have made sense
> too some way...

Yes. I agree. The naming is crap. We're not blanking, we're changing 
state.

But it's not a mode switch either - _sometimes_ it's a mode switch, but 
sometimes the state change is that we're switching to another backing 
store (ie a VC switch) but with the same mode.

So _logically_ the interface should be more of a "con_notify_change()"  
one, with a bitmap of which states have changed (where "graphics vs text"
is just one set of states - resultion is another, VC backing store is one,
etc etc).

(I call it "notify_change()", because we have exactly that in VFS terms,
where the inode change descriptor has an attribute table and a "valid"  
bitmap).

		Linus
