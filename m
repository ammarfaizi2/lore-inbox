Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSFEJNu>; Wed, 5 Jun 2002 05:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSFEJNt>; Wed, 5 Jun 2002 05:13:49 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:57350 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S314077AbSFEJNs>;
	Wed, 5 Jun 2002 05:13:48 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200206050848.JAA16896@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver
To: ptb@it.uc3m.es
Date: Wed, 5 Jun 2002 09:48:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <200206012113.g51LDur14462@oboe.it.uc3m.es> from "Peter T. Breuer" at Jun 01, 2002 11:13:56 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> "Steven Whitehouse wrote:"
> 
> (somethiung about kernel nbd)
> 
> BTW, are you maintaining kernel nbd? If so, I'd like to propose
> some unifications that would make it possible to run either
> enbd or nbd daemons on the same driver, at least in a "compatibility
> mode".
> 
No. My interest is just to help ensure that its working by sending
the occasional bug fix. Pavel Machek is officially in charge, so you'll
need to convince him of any changes.

> The starting point would be
> 
> 1) make the over-the-wire data formats the same, which means
>    enlarging kernel nbd's nbd_request and nbd_reply structs
>    to match enbd's, or some compromise.
> 
> 2) less important .. make the driver structs the same. enbd has more
>    fields there too, for accounting purposes. That's the nbd_device struct.
> 
> Later on one can add some cross-ioctls.
> 
> Peter
> 
I'm not so convinced that this is a good idea. I've always looked upon nbd
as the "as simple as possible" style of driver and its over the wire format
is good enough to cope with most things I think. Does enbd have a negotiation
sequence at start up like nbd ? Perhaps it would be possible to add some
code so a server could tell which type of client it was talking to ? I
think that would be simpler code changes and I'd be happier to see that kind
of change rather than any change to the over the wire format.

It would be nice to add a bit more accounting. We need also to dynamically
allocate the nbd driver structures because as they get larger its less
efficient to allocate them statically as we currently do. The question is
then when to free them. I think that probably the disconnect ioctl() could
provide a suitable hook for that,

Steve.

