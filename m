Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbRFHAzr>; Thu, 7 Jun 2001 20:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbRFHAzh>; Thu, 7 Jun 2001 20:55:37 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:25482 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S263012AbRFHAzY>; Thu, 7 Jun 2001 20:55:24 -0400
Date: Thu, 7 Jun 2001 20:54:47 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Chris Boot <bootc@worldnet.fr>, David Rees <dbr@greenhydrant.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010607205447.A29121@alcove.wittsend.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Chris Boot <bootc@worldnet.fr>, David Rees <dbr@greenhydrant.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <B745C09D.F8BF%bootc@worldnet.fr> <200106080003.f5803wl370740@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <200106080003.f5803wl370740@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, Jun 07, 2001 at 08:03:58PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 08:03:58PM -0400, Albert D. Cahalan wrote:
> Chris Boot writes:
> 
> >>>> Kelvins good idea in general - it is always positive ;-)
> >>>>
> >>>> 0.01*K fits in 16 bits and gives reasonable range.
> ...
> > OK, I think by now we've all agreed the following:
> >  - The issue is NOT displaying temperatures to the user, but a userspace
> >    program reading them from the kernel.  The userspace program itself can
> >    do temperature conversions for the user if he/she wants.
> >  - The most preferable units would be decikelvins, as the value can give a
> >    relatively precise as well as wide range of numbers ranging from absolute
> >    zero to about 6340 degrees Celsius ((65535 / 10) - 273) which is well
> >    within anything that a computer can operate.  It also gives us a good
> >    base for all sorts of other temperature sensing devices.
> >
> > Do we all agree on those now?
> 
> I nearly do.
> 
> There isn't any need to cram the data into 16 bits.
> The offset to Celsius is 273.15 degrees.
> So hundredths of a degree, in Kelvin, is a better choice.

	[Let's see if I can argue boths sides of this fence plus a
third here.]

	Who cares if you cram it into 16 bits.  It still works.

	I think we can agree that negative degrees Kelvin are not relevant
(outside of VERY esoteric physics circles where negative absolute
temperatures are real and represent quantum mechanical states in
"population inversions".  i.e. Quantum mechanical temperatures hotter
than infinite - reference SciAm back in the mid 1970s.  I won an arguement
with a PhD high energy physics prof over that point back then).

	Therefore, we have a 16 bit unsigned quantity which gives us a
range of 0 - 65535.  Translated as hundreths of a Kelvin, that works
out to 0 -> 655.35 K.  Ok...  That's -273.15 C -> 382.20 C.  And...
That's roughly -524 F -> 720 F.  Ok...  That covers everything from
superfluid Helium through MELTS GLASS with room for bobble.

	In 16 bits.

	What's the problem?

	Other than what's the need for two digits of precision in something
that does not have even 1/100 of that accuracy?

	A plague of many measuring systems is "false precision".  Why
provide precision (the units to which a measurement can be divided or
quantized) when the accuracy can not support it.  I would be amazed if
ANY CPU temperature monitors were any more accurate than to a degree C/K
or ~2 degrees F).  Hundreths of a degree K is basically silly nonsense.
The precision even for tenths of a degree K or C are just not supported by
the accuracy of the measuring device and are meaningless.  Even if it
COULD provide even something remotely similar to that level of precision
in it's accuracy, is it really relevant to know the CPU temperature to
1/100 of a degree C?

	Looking at most temperature measuring chips today, unless you are
looking at lab-quality high-precision high-accuracy sensors, you are really
talking about a 12 bit sensor (+- a couple of bits) with an accuracy of
not much better than +-1 C.

	Add the tenths if you want to be silly but returning hundreths
is just meaningless jibberish.

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

