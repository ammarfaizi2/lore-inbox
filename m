Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbTIEUQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbTIEUQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:16:24 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:22917
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265528AbTIEUN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:13:58 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@suse.cz>
Subject: Keyboard stuff (was Re: Fix up power managment in 2.6)
Date: Fri, 5 Sep 2003 16:09:35 -0400
User-Agent: KMail/1.5
Cc: Jeff Garzik <jgarzik@pobox.com>, Patrick Mochel <mochel@osdl.org>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
References: <200309050158.36447.rob@landley.net> <200309051457.37241.rob@landley.net> <20030905190649.GP16859@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20030905190649.GP16859@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309051609.35135.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 September 2003 15:06, Pavel Machek wrote:
> > I was hoping software suspend would avoid having to have IBM firmware
> > involved in the suspend process at all (it can boot, it can shut down, I
> > just want it to snapshot process state so it comes up with the same
> > things up on the desktop as last time).
>
> Yes software suspend can do that.

Footnote 1: If it worked, which I've never been able to get it to do.

> > P.S.  I reeeeeeeeeeeeeeeeeally hate it the way the keys on the keyboard
> > sometimes have an up event delayed (or miss it entirely) and decide to
> > auto-repeat insanely fast.  It happens about twice an hour.  I've seen
> > mouse clicks do it as well.  Not a show-stopper, just annoying.
>
> I guess that *is* showstopper. Unfortunately notebook keyboards tend
> to be crappy :-(.

Not on a thinkpad.  I could probably bring down a wild caribou with this 
thing, it's designed like a tank.  (Part of the reason I bought it. :)

I tried 2.4 for a bit on it when I was first trying to get it working.  
(Largely to assess how much reconfiguration needed to be done, since I'd 
swapped in a hard drive from a toshiba and didn't want to have to reinstall.)

The keyboard never had a problem under 2.4, this is a 2.6 problem.  It also 
affects the mouse at times (not mouse movements, but mouse clicks).  If I had 
to theorize without information, I'd say that the new input event core that 
all this stuff is going through either offloads something on a kernel thread, 
or is getting blocked on a semaphore that another thread is using, and it 
goes 1/10th of a second or so without being secheduled, so the 
acknowledgement of the "up" event gets delayed, and repeat logic triggers 
almost immediately, and something is believing that the key was held down for 
a long time, so I get a bunch of keys.

Sometimes the I'll get say 7 characters (almost instantly) and then it'll 
stop.  And every once in a while, the key will just stick and keep going 
until I hit something else.  (If this happens on the console, hitting 
something else doesn't help, but in X it does.  I'm not in the console enough 
to give too much data about that, I just had it hang once repeating a key, 
and I couldn't figure out which one it was repeating (some sort of function 
key escape code) and there was nothing I could do to make it stop.  That's 
actually an old bug I've seen in 2.4, sometimes during bootup it would think 
a function key was being held down, and keep echoing an escape sequence to 
the screen.  But under 2.4 it would stop when I hit any other key, and in 2.6 
it doesn't listen to the keyboard when it's in that state...)

It's intermittent enough it doesn't stop me from using it.  It's no worse than 
keybounce where dirty keys don't always make contact.  But this is a much 
different symptom...

> 									Pavel

Rob
