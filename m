Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264108AbUD2Lkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUD2Lkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 07:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUD2Lkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 07:40:37 -0400
Received: from gizmo11bw.bigpond.com ([144.140.70.21]:65178 "HELO
	gizmo11bw.bigpond.com") by vger.kernel.org with SMTP
	id S264108AbUD2Lkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 07:40:33 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jesse Allen <the3dfxdude@hotmail.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Thu, 29 Apr 2004 21:44:37 +1000
User-Agent: KMail/1.5.1
Cc: Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local>
In-Reply-To: <20040428205938.GA1995@tesore.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404292144.37479.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 06:59, Jesse Allen wrote:
> On Wed, Apr 28, 2004 at 09:33:34PM +1000, Ross Dickson wrote:
> > > 
> > > It may be this board never hangs no matter what,
> > > or perhaps C1 disconnect was simply disabled in that BIOS
> > > b/c there was no option for it in Advanced Chipset Features
> > > like there is for the most recent BIOS.
> > 
> > Maybe other MOBO manufacturers skimp on filter caps and regulator damping
> > ability and a resonance occurs in the on-board supply rails? Do Shuttle make
> > any claims to using an improved on board regulator? Or Shuttle may have 
> > always programmed more time in C1 cycle handshakes if such is 
> > configurable? 
> 
> Do you really think so?  I think there may be a resonance occuring, even with 
> this new BIOS.  I plugged in new headphones into my nforce2 onboard sound, and 
> get a high pitched noise.  Now here is where it gets weird:  This noise does 
> not occur on boot until sometime after the IDE driver is loaded.  I also 
> believe it varies under a high load.  If you disable C1 disconnect, it's gone.  
> Also I've heard a high pitched noise at certain times coming right from the 
> copmuter (very faint, but I do have very good hearing, I can even hear a hush 
> sounding from my router.  my brother was quite astonished when I pointed that 
> out)  I try to distinguish whats doing it.  It could be the hard drive.  But 
> when I found the other sound in the head phones, I found that the sound varies 
> almost in unison with the sound coming from the computer.  Maybe the IDE or 
> hard drive is related, but it is too much related to C1 disconnect.

I think I might break out my oscilloscope this weekend and have a look at how 
clean the supply rails are around the cpu and northbridge and southbridge. 
Who knows I might get lucky and see some unexpected ripple or spikes.

> 
> Whether it is really possible that my board can really generate this sound, I 
> don't know.  Though, I have once determined that resonance was occuring in an 
> old system, causing unstable CPU operation.  It wasn't that I heard a sound 
> coming from it =).  But what I thought was the case was causing it, and pulled 
> it out of the case.  I ran it on the table and found it to be stable.  That 
> was the only thing wrong.  I've also studied resonance before a bit.  I know 
> resonance can break systems.  But to think that my board is doing emmitting 
> noise like that is pretty bizarre.

Not as bizarre as you may think. I have heard coils and even capacitors "sing"
in years past whilst servicing electronics.

> 
> It may be true that this Shuttle board may have resonance problems.  So that 
> would indicate that they did something much like you describe by changing the 
> C1 handshake time?  Isn't that much like what your patch does?

I had not really thought about it from that perspective. Whilst my patch cannot 
alter the handshake times it does prevent consecutive C1 cycles from occurring
too close together. Too close together I think being less than about 800ns. I 
guess I could look at that with a cro too - use an appropriate pin as the trigger
source and see if supply rails have load dump voltage rises when going into
disconnect. Maybe rail voltage rings for about 700ns and might be out of 
tolerence inside Athlon during that time. Would be very interesting if a 
few hundred picofarad of low esr decoupling cap placed on a supply rail near a
chip makes a difference? A pinout of the nforce2 chipset would help a great deal
here but I do not have one. Can anyone oblige me?

> 
> 
> > 
> > > hang issue is completely explained and solved.
> > 
> > I have had good (100%) success in reproducing the fault with the Albatron 
> > KM18G pro MOBO. I needed m-atx form factor and distributor was local to me.
> > Makes very nice - cheap and stable system but only with the lockup workaround.
> > 
> > I also recollect that Windows had lockups with nforce2 for a while depending 
> > whether you ran the Nvidia or Microsoft driver.
> > http://lkml.org/lkml/2003/12/13/5
> > Anybody got the inside running on that one and what was different between the 
> > two drivers?
> > 
> 
> Yeah, unfortunately, I didn't save a link to the message board that I found 
> that on.  But the issue is pretty common.  I'm sure more info can be found on i
> the windows side.

No tech info but this link shows user had Lockups with Nvidia's ide driver but
OK with MS one.
http://club.cdfreaks.com/showthread/t-91381.html

-Ross

> 
> Jesse
> 
> 
> 
> 

