Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277755AbRJRPcZ>; Thu, 18 Oct 2001 11:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277751AbRJRPcP>; Thu, 18 Oct 2001 11:32:15 -0400
Received: from marty.infinity.powertie.org ([63.105.29.14]:22533 "HELO
	marty.infinity.powertie.org") by vger.kernel.org with SMTP
	id <S277755AbRJRPcC>; Thu, 18 Oct 2001 11:32:02 -0400
Date: Thu, 18 Oct 2001 08:17:01 -0700 (PDT)
From: Patrick Mochel <mochelp@infinity.powertie.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <3BCE7568.1DAB9FF0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0110180807380.16868-100000@marty.infinity.powertie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> So, remove() might be called without a shutdown(), and then asked to
> perform the duties normally performed by shutdown()?  That sounds like
> API dain bramage.  :)

:) I cannot disagree. I probably shouldn't have actually stated that in
the document, since the cases in which that could happen are very rare -
hotplug devices that can survive a suprise removal..Those drivers are
special and (should they ever exist) will have to know to do
that. Consider it removed. 

> Your proposal sounds ok, my one objection is separating probe/remove
> further into init/shutdown.  Can you give real-life cases where this
> will be useful?  I don't see it causing much except headache.
> 
> The preferred way of doing things (IMHO) is to do some simply sanity
> checking of the h/w device at probe time, and then perform lots of
> initialization and such at device/interface open time.  You ideally want
> a device driver lifecycle to look like
> 
> probe:
> 	register interface
> 	sanity check h/w to make sure it's there and alive
> 	stop DMA/interrupts/etc., just in case
> 	start timer to powerdown h/w in N seconds
> 
> dev_open:
> 	wake up device, if necessary
> 	init device
> 
> dev_close:
> 	stop DMA/interrupts/etc.
> 	start timer to powerdown h/w in N seconds
> 
> With that in mind, init -really- happens at device open, and in
> additional is driven more through normal user interaction via standard
> APIs, than the PCI and PM subsystems.

I agree. My main goal was to change probe() to be simple answer to the
question "Hey, are you there?", and move the init features out of it. 
In devices that support power management, that would happen anyway, so
anyway, so that resume() could re-init the device. 

I will update the code and the document to note that. 

Thanks,

	-pat

