Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUAEECh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUAEECh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:02:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:57485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265869AbUAEECf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:02:35 -0500
Date: Sun, 4 Jan 2004 20:02:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401041954010.2162@home.osdl.org>
References: <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org>
 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
 <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> What is _not_ OK, though, is to have folks suddenly see /dev/hda3 changing
> its device number - then we would break existing setups that worked all
> along; even if admin can fix the breakage, it's not a good thing to do.

Ehh, it will actually happen.

If nothing else, things like SATA will end up meaning that the device you 
were used to seeign as /dev/hdc will suddenly show up as /dev/scd0 
instead. Just because you changed the cabling while you upgraded to a 
newer version of your CD-ROM drive.

And the thing is, with fs labels and udev, even "existing systems" really
shouldn't much care.

Now, we'd probably not want to force the switch, but I do suspect we'll 
have exactly this as a switch in the "Kernel Debugging Config" section. 
Where even _common_ things like disks could end up with per-bootup values. 
Just to verify that every part of the system ends up having it right.

Think of it this way: RedHat not that long ago decided to break with a
_lot_ of tradition by switching over to UTF-8 as the common text encoring.  
It broke some _major_ programs in how they dealt with "simple" things like
keyboard input that had worked for literally _decades_.

And you could switch it off if you really wanted to, but quite frankly, it 
wasn't even a simple choice in the install. You had to know what you were 
doing to switch it off.

And the thing is, that is _the_ single thing that cleaned up a lot of 
remaining problems wrt UTF-8 on Linux. Yes, almost all of them had been 
solved already, or RH wouldn't have dared do the switch. But to get there 
all the way, you had to literally force the cut-over.

(Yeah, I'm a bad person, and I personally went back to the C locale,
because "pine" still doesn't get UTF-8 right, and nobody is apparently
ever going to fix it. Oh, well. But at least I know I'm doing something
_wrong_, which in itself is a good thing.).

		Linus
