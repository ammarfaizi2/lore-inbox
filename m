Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUBPXc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUBPXc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:32:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:46753 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265922AbUBPXc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:32:26 -0500
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402161503490.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
	 <1076904084.12300.189.camel@gaston>
	 <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
	 <1076968236.3648.42.camel@gaston>
	 <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
	 <1076969892.3649.66.camel@gaston>
	 <Pine.LNX.4.58.0402161420390.30742@home.osdl.org>
	 <1076972267.3649.81.camel@gaston>
	 <Pine.LNX.4.58.0402161503490.30742@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076974304.1046.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 10:31:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes. I agree. The naming is crap. We're not blanking, we're changing 
> state.
> 
> But it's not a mode switch either - _sometimes_ it's a mode switch, but 
> sometimes the state change is that we're switching to another backing 
> store (ie a VC switch) but with the same mode.
> 
> So _logically_ the interface should be more of a "con_notify_change()"  
> one, with a bitmap of which states have changed (where "graphics vs text"
> is just one set of states - resultion is another, VC backing store is one,
> etc etc).
> 
> (I call it "notify_change()", because we have exactly that in VFS terms,
> where the inode change descriptor has an attribute table and a "valid"  
> bitmap).

Ok, if it's ok to delay it to 2.6.4, i'd prefer going all the way trough
calling it properly and passing the proper "state" flags instead of
hacking more on broken blank/unblank semantics. It can stay in -mm for
a while if we want enough testing.

Ben.


