Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNRet>; Thu, 14 Dec 2000 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130125AbQLNRej>; Thu, 14 Dec 2000 12:34:39 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18962 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129267AbQLNRea>;
	Thu, 14 Dec 2000 12:34:30 -0500
Message-ID: <3A38FC9D.7B2F2B7D@mandrakesoft.com>
Date: Thu, 14 Dec 2000 12:00:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>, Nicolas Pitre <nico@cam.org>,
        morton@nortelnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: Fwd: [Fwd: [PATCH] cs89x0 is not only an ISA card]
In-Reply-To: <200012141525.PAA00867@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Erik Mouw writes:
> > The Crystal CS89x0 ethernet chip is also used in quite some embedded
> > systems that don't have an ISA bus at all, so the CONFIG_ISA option in
> > drivers/net/Config.in is inapropriate. Here is a patch against
> > 2.4.0-test12 to fix that. Please consider applying.
> 
> I don't think this is the right way to fix the problem.  Take for instance
> an EBSA285 platform which has only PCI sockets.  It is possible to plug in
> a card with an ISA bridge on, with a ESS SB clone on board (I have one here).
> 
> Maybe the right thing to do is to define CONFIG_ISA on these architectures/
> machine types where the device itself is actually an ISA device, instead of
> going through special-casing the driver configuration entries?

Agreed.  We -don't- want to remove CONFIG_ISA or other dependencies. 
The idea for drivers/net/Config.in at least is that all architectures
can source the file, and be presented with a proper list of devices for
that platform.

For an embedded board that supports cs89x0, as you suggest, defining
CONFIG_ISA is a much better option.  Or, making cs89x0 dependent on
CONFIG_EMBEDDED_PLATFORM -and- CONFIG_ISA.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
