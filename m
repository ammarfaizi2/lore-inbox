Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132230AbRAQOjE>; Wed, 17 Jan 2001 09:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135317AbRAQOip>; Wed, 17 Jan 2001 09:38:45 -0500
Received: from cav.logica.co.uk ([158.234.10.66]:8012 "EHLO cav.logica.co.uk")
	by vger.kernel.org with ESMTP id <S132230AbRAQOim>;
	Wed, 17 Jan 2001 09:38:42 -0500
Message-ID: <593D817077A5D211A055009027285F28017BDAD7@knuth.logica.co.uk>
From: "Chandler, Alan" <ChandlerA@logica.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE:[preview] VIA IDE driver v3.11 with vt82c686b UDMA100 support
Date: Wed, 17 Jan 2001 14:38:00 -0000
X-Mailer: Internet Mail Service (5.5.2448.0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 10 2001 - 06:45:24 EST Vojtech Pavlik <vojtech@suse.cz> wrote

>For all of you who had problems getting the VIA IDE driver to work 
>correctly on the 686b, here is a driver that should work with those 
>chips, even in UDMA 100 mode. I've not tested it, because I don't have 
>the 686b myself. So it may eat your filesystem as well. 

Although not subscribed to the list (so please cc any comments to me at 
alan@chandlerfamily.org.uk) , I have been tracking the various comments
with errors on VIA IDE drivers under 2.4.0 as I have been experiencing them
myself.

I have been reading the code in vt82cxxx.c in the ide directory of the linux
source
to try and understand what was happening. One thing in the code has been
bugging me as
not right, and although the code attatched to the above message from Vojtech
seems to
sidestep the problem the underlying issue seems still to be there.
[Apologies I am
on a business trip to the US so I cannot access it directly]

within the original code in 2.4.0 there is a table of timings for the
various transfer modes
(I assume they are in 10**-9 secs) - lets call any particular value t.

There is then a piece of code that creates T = 1000/pci_bus_speed which I
assume is the time
of a bus-cycle in 10**-9 secs.

There seems a calculation t/T to calculate the number of bus clocks needed
to meet the
timings above which will get loaded into the ide controller.  There appears
to be a
macro called ENOUGH to do this and I am assuming it is called "ENOUGH"
because it tries to
be a little generous so that the timing is not tight.

The calculation this macro does is (t-1)/(T+1) - AND THIS IS THE CRUX OF MY
POINT but this
seems to me to give a number TOO SMALL, not too large (as desired).

I would like to change this (maybe to (t+1)/(T-1) to see if it fixes the
problem but 

a) I am not at home with access to a machine, and
b) If I am totally mistaken about this I might hose my disks

It seemed more appropriate to seek the indulgence of this list to get
another opinions
as to whether I have misunderstood what the code is trying to do before
taking this step.

I can be reached on chandlera@logica.com until approx 4:00pm EST 17th Jan or
alan@chandlerfamily.org.uk from Sat afternoon (UK time).




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
