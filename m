Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVHIJiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVHIJiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVHIJiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:38:55 -0400
Received: from web30301.mail.mud.yahoo.com ([68.142.200.94]:23482 "HELO
	web30301.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932485AbVHIJiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:38:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=T6q0DUaao3DSoTBuCq1vpaepMuDLCV4R/kKG+aaJTbdYanEBqP73wFK6DcR5O1G1eM1nqRYni5D0LpsPBE2BOG+TlpxCvO38TTSOkFET8iEgFO7ObJtEPT56aekezNK+XVHrmhx8inzVsl5P2TkDZ2LIvgGqsKmxsBWq7hs/NoA=  ;
Message-ID: <20050809093854.88504.qmail@web30301.mail.mud.yahoo.com>
Date: Tue, 9 Aug 2005 10:38:54 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH] spi
To: david-b@pacbell.net, dmitry pervushin <dpervushin@ru.mvista.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050808230707.C5E9DC1661@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- david-b@pacbell.net wrote:

> Well I like this a bit better, but it's still in
> transition from
> the old I2C style stuff over to a newer driver model
> based one.
> (As other folk have noted, with the "bus" v.
> "adapter" confusion.)
> 
>   - Can you make the SPI messages work with an async
> API?
>     It suffices to have a callback and a "void *"
> for the
>     caller's data.  Those callbacks should be able
> to start
>     the next stage of a device protocol request ...
> e.g. the
>     first one issues some command bytes, and its
> completion
>     callback starts the data transfer.  (It's easy
> to build
>     synchronous models over async ones; but not the
> other way.)
> 
>     (I see Mark Underwood commented that he was
> working with
>     one like that.)

Yep. I'm doing some tidying up. The work is still in
development but I'm trying to get some patches ready
so people and compare and contrast :-).

> 
>   - The basic thing that bothers me is that, like
> original I2C,
>     the roles and responsibilities here don't
> correspond in any
>     consistent way to the driver model.  For new
> code like SPI,
>     there's no excuse for that to happen.
> 
>   - It should probably also not assume Linux can
> only act in
>     the "master" role.  SPI controllers are simple,
> and often
>     can implement slave roles just as well.  (This
> is one of
>     several technical details that bother me...)

I'm afraid my SPI subsystem doesn't either :-(. But it
hopefully shouldn't be hard to add :-)

> 
> 
> One thing I've been looking for in your posts about
> SPI is an
> example of how to configure a system using it.  Some
> examples
> come quickly to mind (all Linux-based boards):
> 
>   * System 1 has one SPI bus with two chipselects
> wired.
>     CS0 is for a DataFlash chip on the motherboard;
> while
>     CS3 is a MMC/SD/SPI socket (cards can be
> added/removed)
>     that's primarily used for DataFlash cards.
> 
>   * System 2 uses SPI to talk to to a multi function
> chip,
>     with sensors for battery, temperature, and
> touchscreen
>     (and others not used) as well as stereo audio
> over what's
>     esentially an I2S channel.  Plus an MMC/SD/SPI
> socket,
>     not yet used in SPI mode (it'd use the MMC
> controller in
>     SPI mode, not yet implemented or required).
> 
>   * System 3 uses SPI to talk to an AVR based
> microcontroller,
>     using application-specific protocols to collect
> sensor
>     data and to issue (robotics) commands.  (AVR is
> an 8-bit
>     microcontroller.  In this case its firmware is
> open, but
>     clearly not running under Linux.  In other
> cases, there's
>     no reason both sides can't run Linux.)
> 
> Given that those SPI devices can't usefully be
> probed, and that
> things like some CAN drivers will cheerfully bind to
> a DataFlash
> device, how do you see systems like those getting
> configured?
> Lots of board-specific logic in the SPI bus and
> device drivers?
> (I'd hope to avoid that, though it clearly works!)
> 

The way my subsystem gets around this is that each
adaptor has a CS table which describes what clients
are on what chip select. This is then used in the core
layer to 'probe' for devices. If a match is found (the
name of a client driver matches a name in the CS
table) then the clients probe function gets called
from which the client could also do some checking
(like I2C) and if it is happy that it is talking to
the device it was written for then it attaches the
cline to the bus.

> 
> Anyway, more detailed comments below.  I'm afraid I
> jumped
> right to the end of your post, where you had the
> highest level
> overview I could find:  the <linux/spi.h> header. 
> Next time
> it might be quicker to just review that part.  :)
> 
> I recently came across a FAQ entry that read "SPI is
> actually a
> lot simpler than for example I2C".  True; but I
> don't think it
> looks that way yet in this API!

Hmm, SPI as no protocol like I2C but, to me, that
makes it harder as you can do more things with it. You
also have different clock modes and speeds unlike I2C.

> 
> - Dave
> 

=== message truncated ===

Hopefully more SPI patches coming soon. You have been
warned :-)

Mark



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
