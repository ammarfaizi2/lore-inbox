Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDGTkh>; Sat, 7 Apr 2001 15:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRDGTk1>; Sat, 7 Apr 2001 15:40:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58801 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130552AbRDGTkR>;
	Sat, 7 Apr 2001 15:40:17 -0400
Message-ID: <3ACF6D1D.63A2A2FE@mandrakesoft.com>
Date: Sat, 07 Apr 2001 15:40:13 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Michael Reinelt <reinelt@eunet.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <Pine.LNX.4.10.10104071043360.1085-100000@linux.local> <20010407200053.B3280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> If we have to do this, then Gunther's approach (multifunc_quirks or
> whatever) looks a lot better than having a separate driver for every
> single multi-IO card.

Who said you have to have a separate driver for every single multi-IO
card?  A single driver could support all serial+parallel multi-IO cards,
for example.

Due to the differences in busses and hardware implementations and such,
typically you want to provide two pieces of code for each common
hardware subsystem (like "parport" or "serial"):  foo_lib.c and
foo_card.c.

foo_lib.c is the guts of the hardware support, and it provides an
[un]register_foodev() interface.  foo_card.c is totally separate, and it
holds the PCI or ISAPNP or USB device ids.  foo_card does all the
hardware detection, and calls register_foodev() for each hardware device
it finds.

For small subsystems, this is obviously overkill.  But for common
subsystems like serial or parport, this makes complete sense.  If an
sbus device appears that acts just like a PC parallel port, all DaveM
needs to do is write a parport_sbus.c shim which calls
register_foodev().  No patching one central file necessary to add
support for a new bus.

Regards,

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
