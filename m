Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFETQC>; Wed, 5 Jun 2002 15:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSFETQB>; Wed, 5 Jun 2002 15:16:01 -0400
Received: from air-2.osdl.org ([65.201.151.6]:60040 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315943AbSFETP7>;
	Wed, 5 Jun 2002 15:15:59 -0400
Date: Wed, 5 Jun 2002 12:11:56 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
cc: <linux-kernel@vger.kernel.org>,
        <linux-hotplug-devel@lists.sourceforge.net>,
        <linux-usb-devel@lists.sourceforge.net>
Subject: Re: device model documentation 2/3
In-Reply-To: <200206051253.g55Crs331876@fachschaft.cup.uni-muenchen.de>
Message-ID: <Pine.LNX.4.33.0206051205150.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Oliver Neukum wrote:

> 
> > SUSPEND_DISABLE tells the device to stop I/O transactions. When it
> > stops transactions, or what it should do with unfinished transactions
> > is a policy of the driver. After this call, the driver should not
> > accept any other I/O requests.
> 
> Does this mean that memory allocations in the suspend/resume
> implementations must be made with GFP_NOIO respectively
> GFP_ATOMIC ?
> It would seem so.

Why would you allocate memory on a resume transition? 

As for suspending, this is something that has been discussed a few times 
before. No definitive decision has come out of it because it hasn't been 
implemented yet. It hasn't been implemented yet because the infrastructure 
isn't complete. It's real close, but still not quite there. 

Nonetheless, you have to do one of a couple things: use GFP_NOIO or
special case the swap device(s) so they don't stop I/O when everything
else does. (Of course, you have to eventually stop it)

Check the archives; there are lots of ideas there wrt this topic. But, 
there are bigger fish to fry in the meantime ;)

	-pat

