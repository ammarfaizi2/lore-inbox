Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282674AbRK0AVY>; Mon, 26 Nov 2001 19:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282666AbRK0AUc>; Mon, 26 Nov 2001 19:20:32 -0500
Received: from femail36.sdc1.sfba.home.com ([24.254.60.26]:50065 "EHLO
	femail36.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282672AbRK0AT7>; Mon, 26 Nov 2001 19:19:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Journaling pointless with today's hard disks? [wandering OT]
Date: Mon, 26 Nov 2001 16:18:52 -0500
X-Mailer: KMail [version 1.2]
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011126151922.29433A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1011126151922.29433A-100000@chaos.analogic.com>
MIME-Version: 1.0
Message-Id: <0111261618520K.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 November 2001 15:53, Richard B. Johnson wrote:
>
>
> It isn't that easy!  Any kind of power storage within the drive would
> have to be isolated with diodes so that it doesn't try to run your
> motherboard as well as the drive. This means that +5 volt logic supply
> would now be 5.0 - 0.6 =  4.4 volts at the drive, well below the design
> voltage. Use of a Schottky diode (0.34 volts) would help somewhat, but you
> have now narrowed the normal power design-margin by 90 percent, not good.

At this point I have to hand the conversation over to either my father (a 
professional electrical engineer), my grandfather (ditto for 50 years, 
including helping GE debug its early vacuum tube lines), or my friend chip 
(who got a 4.0 from a technical college and who modifies playstations with a 
soldering iron for fun).

Me, I'm mostly a software person, but this strikes me as a fairly 
straightforward voltage regulation and switching problem.  Must admit I was 
considering transistors sealing off the rest of the world's power supply when 
the sensor says it's going bye-bye, but I can't say I'm familiar with the 
kind of load you can hit one of them with.  (I remember using one to drive a 
motor once, but that was smoke signals lab back in college and a significant 
number of the components I used gave up their magic smoke along the way.  I 
ran an awful lot of current through the big evil black three-prong 
transistors, though.  That's a problem they solved back in the 1960's, isn't 
it?)

> There is supposed to be a "power good" line out of your power supply
> which is supposed to tell equipment when the main power has failed or
> is about to fail. There isn't a "power good" line in SCSI so that
> doesn't help.

Shouldn't be too hard to fake something up to detect a current fluctuation.  
Sheesh, in a way that's what the whole high/low logic gates reading the data 
bus do, isn't it?  And the cache dump logic is more or less constant (you 
WANT it to go to disk), it's not so much triggering it as making sure you 
limit what it has to do to what you can guarantee it'll have time to do, and 
then adding a few miliseconds of extra power to guarantee it'll have time to 
do it.

Maybe I'm oversimplifying.  I'm a software person.  We do that with 
hardware...

> Basically, when the power fails, all bets are off. A write in progress
> may not succeed any more than a seek in progress would.

Currently, sure.  But nobody said this was a GOOD thing.

> Seeks take a
> lot of power, usually from the +12 volt line.

I've seen capacitors melt screws.  (And in one instance, a screwdriver.)  
Admittedly those were the monster big ones (the screw melter was about 10 
cubic centimeters, the screwdriver got melted by a friend poking around in 
the back of an unplugged television set; he lived), but saying a capacitor 
doesn't have enough power to do something without specifying the capacitor in 
question...

My grandfather has capacitors that simulate lightning strikes to stress-test 
equipment against electromagnetic pulse interference during thrunderstorms.  
(They're a little larger than a printer paper box, and he hooks a half-dozen 
of them up in series.)

> Typically, if a write
> is in progress, when low power is sensed by the drive, write current
> is terminated. At one time, there was a electromagnet that was
> released to move the heads to a landing zone. Now there is none.
> The center of radius of the head arm is slightly forward of the
> center of rotation of the disk so that when the heads "land", they
> skate to the inside of the platter, off the active media. The media
> is supposed to be able to take this abuse for quite some time.

I'd heard the parking these days was sometimes done centrifugally, but didn't 
know it skipped in...

> The solution is an UPS. When the UPS power gets low, shut down
> the computer, preferably automatically.

I admit that laptops are driving desktops into the "workstation" market, so 
we'll all have battery backup automatically anyway, but saying a piece of 
equipment that doesn't gracefully deal with a condition CAN'T gracefully deal 
with that condition...

If current processors ate their microcode on an unclean loss of power, or 
flashable bioses glitched themselves on an unclean loss of power, would you 
consider this behavior justifiable because you should have been using a UPS?

We're not talking server side hosted RAID systems here.  (Although this could 
easily take out multiple drives from a raid simultaneously.)  We're talking a 
college student's home desktop system went bye-bye because his roommate hit 
the light switch that the computer's outlet was plugged into, and his 
journaling FS did no good.

You're arguing that there's no real world demand for journaling filesystems.  
You realise this, don't you?  (If an unclean shutdown can create hard errors 
on your drive as well as eating who knows how much write-cached data that the 
journal thought was committed, what's the point of journaling?)

> Also, if your computer is on all day long as is typical at a
> workplace, never shut it off.

I don't.

> Just turn off the monitor when you
> go home. Your disk drives will last until you decide to replace
> then because they are too small or too slow.

They do.  However, I have power failures from time to time.  Even with a UPS, 
the power cord has been knocked out of the back of the box (or the switch got 
hit by somebody's foot) on more than one occasion.  And then there was the 
time an entire Dr. Pepper went flying all over the machine and a very quick 
power down was required before liquid could drip down onto the electronics.  
(Not a server room scenario, no.  But more common than you'd think in 
desktops and workstations.)

> And beware when you finally do turn off the computer. The disks
> may not spin up the next time you start the computer. It's a good
> idea to back up everything before shutting down a computer that
> has been running for a year or two.

Why wait until you shut the box down?

http://content.techweb.com/wire/story/TWB20010409S0012

If you have 3 year old data you still care about and you haven't backed it up 
yet, something is wrong.  Forget the drive going bad, I had lighting cause 
one of the chips in my modem to explode once.  (Literally.  Strangely, the 
rest of the system, an old 386, worked fine after a reboot, but there was no 
reason to expect that.)  Or the power supply filling up with dust and doing 
all SORTS of fun things to the rest of the system.

> Of course you can re-boot as much as you want. Just don't kill the power!

Worst case scenario this is what data recovery services are for.  Assuming 
you can budget $10k for them to crack open your drive in their cleanroom. :)

Also, sticking the drive in the freezer for a bit often works long enough to 
get the data off.  Several theories on why (lower the resistance of stuff in 
the motor, contract and bring worn contacts closer together, stop the 
lubrication from acting like glue) but it's a good "the drive's hosed, what 
do we do" hail mary pass.  Just don't think it's a fix longer than it takes 
the drive to warm up.  (Oh yeah, put it in a plastic bag first.  
Condensation, you know.  Bad for electronics.)

In my personal experience the drive's bearings seem to go before the motor, 
but I know that's not a general rule...

> Cheers,
> Dick Johnson

Rob
