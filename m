Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278719AbRJTDZF>; Fri, 19 Oct 2001 23:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278720AbRJTDY4>; Fri, 19 Oct 2001 23:24:56 -0400
Received: from marine.sonic.net ([208.201.224.37]:21781 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S278719AbRJTDYm>;
	Fri, 19 Oct 2001 23:24:42 -0400
Date: Fri, 19 Oct 2001 20:24:42 -0700
From: David Hinds <dhinds@sonic.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [patch] ip autoconfig for PCMCIA NICs
Message-ID: <20011019202442.A2666@sonic.net>
In-Reply-To: <3BD092A6.26A1CFE9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BD092A6.26A1CFE9@zip.com.au>; from akpm@zip.com.au on Fri, Oct 19, 2001 at 01:52:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 01:52:54PM -0700, Andrew Morton wrote:
> 
> This all works fine.  However it probably breaks something, but the rather
> unilluminating comment
> 
> #ifdef CONFIG_PCMCIA
>         init_pcmcia_ds();               /* Do this last */
> #endif
> 
> doesn't tell us what.

I'm not sure about the origin of the comment.  But I can think of one
reason for starting PCMCIA after at least other device drivers have
started: since the kernel generally relies on individual drivers to
announce their resource allocations, there is no way to reliably do
resource allocation for hot plug devices before non-hot-plug devices
have enumerated what resources they're already using.

> Now, every time I try to understand the relationship between socket
> services, card services, socket drivers and driver services my brain
> bursts.  Could some kind soul please what these things do, and how
> they fit together?   Thanks.

Card services manages a few things for PCMCIA client drivers: hot plug
event handling, resource allocation, PCMCIA bus configuration, Card
Information Structure parsing, and some abstractions for talking to
memory cards.  The Linux version, in the pcmcia_core module, is based
heavily on the PCMCIA standard documents.  Socket services is the
PCMCIA standard API for talking to socket drivers; Linux does not
really implement this API and there's a simpler interface between
pcmcia_core and socket drivers.  The Linux driver services layer, in
the "ds" module, supplies a few things for managing device drivers:
stuff for keeping track of which drivers manage which cards, and which
logical devices are associated with which cards and drivers.  It also
provides a user mode pseudo-device for some Card Services functions.

This stuff is also explained in the intro of the Linux PCMCIA
Programmer's Guide.

-- Dave
