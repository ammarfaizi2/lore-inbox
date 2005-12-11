Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbVLKWlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVLKWlY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 17:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbVLKWlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 17:41:24 -0500
Received: from styx.suse.cz ([82.119.242.94]:64669 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750900AbVLKWlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 17:41:23 -0500
Date: Sun, 11 Dec 2005 23:40:59 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: dtor_core@ameritech.net, "Yu, Luming" <luming.yu@intel.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [git pull 02/14] Add Wistron driver
Message-ID: <20051211224059.GA28388@midnight.suse.cz>
References: <3ACA40606221794F80A5670F0AF15F840A53FCC5@pdsmsx403> <d120d5000512060721j3a75ff7bh40309f4fa132b39a@mail.gmail.com> <200512111310.14984.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512111310.14984.bero@arklinux.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 01:10:13PM +0000, Bernhard Rosenkraenzer wrote:
> On Tuesday 06 December 2005 15:21, Dmitry Torokhov wrote:
> 
> Hi, sorry for the delay, just returning from Spain...
> 
> > > There are acpi daemon for any evetnts that needs user space attention.
> > > I'm not sure if these events should be routed to input layer.
> >
> > How do you suggest handle buttons such as "Mail", "WWW", etc? Through
> > acpid? And then tunnel them to X somewhow?
> 
> I think routing them to the input layer makes most sense because they are keys 
> like everything else -- of course hacking acpid to pass on ACPI key events to 
> Xorg via the XTest extension is not exactly hard, but that would break the 
> keys in text mode (who knows, maybe someone wants to map his mail key to 
> "mutt[RETURN]"?), and of course launching an application from acpid is a bit 
> hard (acpid runs as root --> need to figure out which user is pressed the 
> button, switch user IDs, find the correct X display if any, .....) if it's an 
> input event, solutions for the expected functionality already exist - e.g. 
> khotkeys.

You also can hack acpid to use uinput to feed the events back to the
input subsystem, but I agree with you that going there directly is
probably the best way to go.

> > > With acpi enabled - wistron module, bluetooth works.
> > > From these test cases, do you still think wistron driver can help my
> > > laptop?
> >
> > No, you have proven that the driver will not help to your laptop. Now,
> > as it is, it won't even load on your laptop either, because of
> > different DMI signature. So why are you complaining? I am pretty sure
> > Bernhard (who added bluetooth handling) has his working with ACPI.
> > Bernhard, any input on this?
> 
> I have ACPI + wistron module. Can't tell if bluetooth actually works because I 
> don't have any bluetooth hardware, but I can tell the bluetooth LED can be 
> turned on and off.

You should see the bluetooth USB device appearing and disappearing in
'lsusb'.

> ACPI works on this box, but not the ACPI buttons stuff (guess they aren't 
> following standards...). I'm running a modified 2.6.15-rc5-mm1 here (none of 
> the modifications touch ACPI though).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
