Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131057AbRAQPFO>; Wed, 17 Jan 2001 10:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131781AbRAQPFD>; Wed, 17 Jan 2001 10:05:03 -0500
Received: from styx.suse.cz ([195.70.145.226]:15354 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131057AbRAQPEy>;
	Wed, 17 Jan 2001 10:04:54 -0500
Date: Wed, 17 Jan 2001 16:03:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Chandler, Alan" <ChandlerA@logica.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [preview] VIA IDE driver v3.11 with vt82c686b UDMA100 support
Message-ID: <20010117160340.A2042@suse.cz>
In-Reply-To: <593D817077A5D211A055009027285F28017BDAD7@knuth.logica.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <593D817077A5D211A055009027285F28017BDAD7@knuth.logica.co.uk>; from ChandlerA@logica.com on Wed, Jan 17, 2001 at 02:38:00PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The macro is defined as (in your symbols):

(((t)-1)/(T)+1)

The same macro is used both in 2.1e (2.4.0 driver) and in 3.11
(686b-capable driver). If you minimize the parentheses, you'll get:

E = (t-1)/T + 1

Which gives the correct answer. We need E*T >= t.

Vojtech

On Wed, Jan 17, 2001 at 02:38:00PM -0000, Chandler, Alan wrote:
> On Wed Jan 10 2001 - 06:45:24 EST Vojtech Pavlik <vojtech@suse.cz> wrote
> 
> >For all of you who had problems getting the VIA IDE driver to work 
> >correctly on the 686b, here is a driver that should work with those 
> >chips, even in UDMA 100 mode. I've not tested it, because I don't have 
> >the 686b myself. So it may eat your filesystem as well. 
> 
> Although not subscribed to the list (so please cc any comments to me at 
> alan@chandlerfamily.org.uk) , I have been tracking the various comments
> with errors on VIA IDE drivers under 2.4.0 as I have been experiencing them
> myself.
> 
> I have been reading the code in vt82cxxx.c in the ide directory of the linux
> source
> to try and understand what was happening. One thing in the code has been
> bugging me as
> not right, and although the code attatched to the above message from Vojtech
> seems to
> sidestep the problem the underlying issue seems still to be there.
> [Apologies I am
> on a business trip to the US so I cannot access it directly]
> 
> within the original code in 2.4.0 there is a table of timings for the
> various transfer modes
> (I assume they are in 10**-9 secs) - lets call any particular value t.
> 
> There is then a piece of code that creates T = 1000/pci_bus_speed which I
> assume is the time
> of a bus-cycle in 10**-9 secs.
> 
> There seems a calculation t/T to calculate the number of bus clocks needed
> to meet the
> timings above which will get loaded into the ide controller.  There appears
> to be a
> macro called ENOUGH to do this and I am assuming it is called "ENOUGH"
> because it tries to
> be a little generous so that the timing is not tight.
> 
> The calculation this macro does is (t-1)/(T+1) - AND THIS IS THE CRUX OF MY
> POINT but this
> seems to me to give a number TOO SMALL, not too large (as desired).
> 
> I would like to change this (maybe to (t+1)/(T-1) to see if it fixes the
> problem but 
> 
> a) I am not at home with access to a machine, and
> b) If I am totally mistaken about this I might hose my disks
> 
> It seemed more appropriate to seek the indulgence of this list to get
> another opinions
> as to whether I have misunderstood what the code is trying to do before
> taking this step.
> 
> I can be reached on chandlera@logica.com until approx 4:00pm EST 17th Jan or
> alan@chandlerfamily.org.uk from Sat afternoon (UK time).
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
