Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTJXJS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJXJS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:18:56 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:969 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S262095AbTJXJSx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:18:53 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Wow.  Suspend to disk works for me in test8. :)
Date: Fri, 24 Oct 2003 04:15:36 -0500
User-Agent: KMail/1.5
Cc: Voicu Liviu <pacman@mscc.huji.ac.il>, linux-kernel@vger.kernel.org
References: <200310200225.11367.rob@landley.net> <200310240209.18678.rob@landley.net> <20031024075600.GC1519@elf.ucw.cz>
In-Reply-To: <20031024075600.GC1519@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310240415.36991.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 02:56, Pavel Machek wrote:
> Hi!
>
> > > > A couple of down sides I've noticed: I have to run "hwclock
> > > > --hctosys" after a resume because the time you saved at is the time
> > > > the system thinks it is when you resume (ouch).  And because of that,
> > > > things that should time out and renew themselves (like dhcp leases)
> > > > have to be thumped manually.
> > >
> > > I sent fix for that yesterday... but you'd need to fix swsusp.c's
> > > sysdev handling and mtrr-s => better wait.
> > > 			Pavel
> >
> > It's largely working for me.  My laptop's backed up regularly, so I'm not
> > risking too much data.  It reliably fails trying to suspend if I close
> > the lid, and if I don't close the lid every once in a while the power
> > down step won't power down immediately and the sucker will boot back up
> > to the desktop and inform me that my dhcp lease file is corrupt, and then
> > suddenly power down right from the desktop.  (I reboot and force a full
> > fsck in this circumstance.)
>
> Well, this looks like ACPI problems to me. You might want to set it to
> reboot and hit powerswitch manually.

Why should it be an ACPI problem?  Shutdown has never had trouble powering 
down since I got the laptop.  Before Patrick forked off a suspend that 
actually worked for me, I'd shut down every time I wanted to move the laptop.  
(Ctrl-alt-backspace, ctrl-alt-delete was the fast way, I tweaked inittab to 
make that call shutdown -h.)  I'd start a shutdown, and while red hat was 
running it's 8 gazillion unnecessary scripts I'd close the lid, put the thing 
in my backpack, and forget about it.  It shut down every time, all the way 
back to at least -test3 (first version I installed on this laptop).

Now I have to leave the lid open until it's finished suspending...

> > I've also had it just hang there, on both suspend and resume, for upwards
> > of 30 seconds doing nothing I can see until I start holding the power
> > button down: after ten seconds it'll hard power off, but after two or
> > three it suddenly wakes up and continues with the suspend or resume. 
> > (Suspend usually hangs in "snapshotting memory" or something like that. 
> > Resume hangs printing ........::::::::] at the end of the boot log, right
> > before it would otherwise clear the screen and rerun the end of the power
> > down phase.
>
> Not sure what is going on there.

Me neither.  If I get some time this weekend I'll stick beep calls into the 
code and try to force it to fail.  If I open the lid after it's hung the 
display is powered off, so I can't see any printout.  No serial port on this 
machine to rig up a serial console.  The "march of progress".  Sigh...

> I have similar hangs on omnibook xe3 when I do not load ohci driver
> (but they happen during regular operation)....

Nah.  My usb scanner works on this puppy just fine when I bother to modprobe 
scanner.  But I haven't plugged that in in a week.  (And that has nothing to 
do with closing the lid, if USB was a problem you'd think it would happen 
when it was open.)

I only had it fail to suspend (booting back up to the desktop with the 
filesystem horked) exactly once, and that was when I let the battery drop 
down to 0% charged.  (It'll keep going for 15 minutes when it's like that, 
there's a reserve for suspend-to-ram.  That might have been an ACPI problem 
somehow, yet if I'd told it to shutdown it would have (it always does, I've 
done it a lot, yes with the battery at 0%), and presumably ACPI is only being 
used to power the puppy off, the rest should just be a variant of module 
unloading, checkpointing process state, and flushing memory to swap...

> 									Pavel

Rob
