Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318078AbSHHXsr>; Thu, 8 Aug 2002 19:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSHHXsq>; Thu, 8 Aug 2002 19:48:46 -0400
Received: from quattro.sventech.com ([205.252.248.110]:27404 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S318078AbSHHXsq>; Thu, 8 Aug 2002 19:48:46 -0400
Date: Thu, 8 Aug 2002 19:52:29 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mjr@znex.org
Subject: Re: [linux-usb-devel] Re: USBLP_WRITE_TIMEOUT too short for Kyocera FS-1010.
Message-ID: <20020808195229.C3414@sventech.com>
References: <200208082333.QAA11560@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208082333.QAA11560@adam.yggdrasil.com>; from adam@yggdrasil.com on Thu, Aug 08, 2002 at 04:33:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002, Adam J. Richter <adam@yggdrasil.com> wrote:
> Mark J Roberts writes:
> >Printing complicated postscript documents makes my Kyocera FS-1010
> >hit that timeout. I increased it to 240 seconds and the problem
> >seems to have disappeared.
> >
> >I guess there ought to be a blacklist or something.
> 
> 	I saw a similar thing a few weeks ago (under 2.5.27?) with the
> Hewlett-Packard 656C ink jet printer, which only occurred when I would
> send a page with images on it, so the printer really would need a long
> time before it was ready to accept more data.
> 
> 	I would hope that the kernel should be able to wait as long
> as the printer wants before the printer indicates that it is ready for
> more data.  I don't know if this is a bug in these printers' USB
> implementations or if it is a real kernel bug.  I just haven't had
> time to investigate it yet (and I no longer have access to that printer,
> although 656C's are only $30 at Fry's).

I suspect it's a bug in the kernel.

It sounds like the printer is NAKing all of the transfers while it's
busy flushing out the data sent to it. This is to be expected because it
can only store so much data and sending data is MUCH faster than it can
print it.

I think the problem is that the printer driver has a timeout. I don't
think it should. It just doesn't make sense in this case. I say let the
device NAK as long as it wants. It's the applications job to decide if
it's been too long or not.

JE

