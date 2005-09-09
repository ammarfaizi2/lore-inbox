Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVIITX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVIITX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVIITX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:23:57 -0400
Received: from web30311.mail.mud.yahoo.com ([68.142.201.229]:26489 "HELO
	web30311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030280AbVIITX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:23:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=1ql6QcGWiVCZrklkUY1mJWeRtYiONVER5FBmxlOmGFSHKOc+ahPM9Nyd99mFLB6h4ARmQUoyZpCEB61ZurHn3iYHX9lXgxQ3+wJ9V9CsU477sjJPsGdDC7GGh2o5KyK9b2wvqcJmImu4zDfW4x8subX82Q4I2GkE5FSiG0CM3xw=  ;
Message-ID: <20050909192356.10887.qmail@web30311.mail.mud.yahoo.com>
Date: Fri, 9 Sep 2005 20:23:56 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: glikely@gmail.com, David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, basicmark@yahoo.com,
       dpervushin@ru.mvista.com
In-Reply-To: <528646bc0509091040364ae7d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Grant Likely <glikely@gmail.com> wrote:

> On 9/8/05, David Brownell <david-b@pacbell.net>
> wrote:
> > That implies whoever is registering is actually
> going and creating the
> > SPI devices ... and doing it AFTER the controller
> driver is registered.
> > I actually have issues with each of those
> implications.
> > 
> > However, I was also aiming to support the model
> where the controller
> > drivers are modular, and the "add driver" and
> "declare hardware" steps
> > can go in any order.  That way things can work
> "just like other busses"
> > when you load the controller drivers ... and the
> approach is like the
> > familiar "boot firmware gives hardware description
> tables to the OS"
> > approach used by lots of _other_ hardware that
> probes poorly.  (Except
> > that Linux is likely taking over lots of that
> "boot firmware" role.)
> To clarify/confirm what your saying:
> 
> (I'm going to make liberal use of  stars to hilight
> "devices" and
> "drivers" just to make sure that a critical word
> doesn't get
> transposed)
> 
> There should be four parts to the SPI model:
> 1. SPI bus controller *devices*; attached to another
> bus *instance*
> (ie. platform, PCI, etc)
> 2. SPI bus controller *drivers*; registered with the
> other bus
> *subsystem* (platform, PCI, etc)
> 3. SPI slave *devices*; attached to a specifiec SPI
> bus *instance*
> 4. SPI slave *drivers*; registered with the SPI
> *subsystem*
> 
> a. SPI bus controller *drivers* and slave *drivers*
> can be registered
> at any time in any order
> b. SPI bus controller *devices* can be attached to
> the bus subsystem at any time
> c. SPI bus controller *drivers* attach to bus
> controller *devices* to
> create new spi bus instances whenever the driver
> model makes a 'match'
> d. SPI slave devices can be attached to an SPI bus
> instance only after
> that bus instance is created.
> e. SPI slave *drivers* attach to SPI slave *devices*
> when the driver
> model makes a match.  (let's call it an SPI slave
> instance)
> f. Unregistration of any SPI bus controller *driver*
> or *device* will
> cause attached SPI bus instance(s) and any attached
> devices to go away
> g. Unregistration of any SPI slave *driver* or
> *device* will cause SPI
> slave instance to go away.
> 
> [pretty much exactly how the driver model is
> supposed to work I guess  :)  ]
> 
> Ideally controller drivers, controller devices,
> slave drivers and
> slave devices are all independent of each other. 
> The board setup code
> will probably take care of attaching devices to
> busses independent of
> the bus controller drivers and spi slave drivers. 
> Driver code is
> responsible for registering itself with the SPI
> subsystem.
> 
> If this is what your saying, then I *strongly*
> second that opinion. 
> If not, then what is your view?
> 
> I've been dealing with the same problems on my
> project.  Just for
> kicks, here's another implementation to look at.
> 
>
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019259.html
>
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019260.html
>
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019261.html
>
http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019262.html
> 
> It also is not based on i2c in any way and it tries
> ot follow the
> device model.  It solves my problem, but I've held
> off active work on
> it while looking at the other options being
> discussed here.

Another interesting proposal :), although it doesn't
address the platform abstraction issue along with some
others which people have raised in reply to your
posts. It's good to see other people interested in
this, if we can get up enough people then maybe we can
push a SPI subsystem into the kernel :).

Mark

> 
> Thanks,
> g.
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Send instant messages to your online friends http://uk.messenger.yahoo.com 
