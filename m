Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUADDE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUADDE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:04:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:13795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264927AbUADDE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:04:26 -0500
Date: Sat, 3 Jan 2004 19:04:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040104034934.A3669@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401031856130.2162@home.osdl.org>
References: <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl>
 <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
 <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
 <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
 <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org>
 <20040104034934.A3669@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Andries Brouwer wrote:
> 
> You write long stories - but it really is desirable to have
> stable device numbers.

And I write the long stories because you do not seem to _get_ the point.

The point is that we will most likely ON PURPOSE break those stable device 
numbers, for debugging reasons. Because it is _not_ desirable to have 
people _believe_ that they can depend on stable device numbers.

> I don't see why that would be relevant. One identifies
> things by their UUID. Order is never important.

And this is exactly how it should be. However, it requires that user code 
actually does the right thing.

And to _verify_ that user code properly identifies devices by other things 
than device numbers, we should during 2.7.x explicitly _break_ all 
dependencies on stable device numbers.

And UUID's are _not_ "device numbers". They fundamentally _cannot_ be 
that, because the kernel just doesn't have any information on how to 
generate a unique identifier that is actually stable.

The kernel doesn't know what it can depend on - should it look at the UUID
in the boot sector of the disk, or should it look up the UUID using IP
number reverse lookup, or what? 

The only thing that can generate a UUID is literally user mode. Which is 
_exactly_ why things like udev exists.

So device numbers are _not_ UUID's. Device numbers are needed before the 
UUID's have been identified. 

And that has been my point all along: device numbers do not have any
meaning. They are neither unique nor stable across reboots. They have no
information AT ALL associated with them. Anybody who thinks that they are
is fundamentally _wrong_ about it.

I agree that for a stable kernel we should then go back to "best effort" 
mode, where for simple politeness reasons we should try to keep device 
numbers as stable as we can. 

		Linus
