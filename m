Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277859AbRJRRsw>; Thu, 18 Oct 2001 13:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277861AbRJRRsm>; Thu, 18 Oct 2001 13:48:42 -0400
Received: from marty.infinity.powertie.org ([63.105.29.14]:35590 "HELO
	marty.infinity.powertie.org") by vger.kernel.org with SMTP
	id <S277859AbRJRRs1>; Thu, 18 Oct 2001 13:48:27 -0400
Date: Thu, 18 Oct 2001 10:33:25 -0700 (PDT)
From: Patrick Mochel <mochelp@infinity.powertie.org>
To: Jonathan Corbet <corbet-lk@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5 
In-Reply-To: <20011018170512.25468.qmail@eklektix.com>
Message-ID: <Pine.LNX.4.21.0110181009580.16868-100000@marty.infinity.powertie.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > probe:
> > 	Check for device existence and associate driver with it. 
> 
> What, exactly, does "associate driver" mean?  Filling in the struct device
> field, perhaps?  Calling register_chrdev (or register_whatever)?  Creation
> of a ddfs entry?  As a driver writer I can understand that the probe
> routine should check for the existence of some device, and perhaps set up
> an internal data structure.  What else happens?

That's basically it. The bus should have already known about the existence
of the device, filled in the fields of struct device and registered it in
the global tree. 

As Jeff Garzik suggested: 

probe:
        register interface
        sanity check h/w to make sure it's there and alive
        stop DMA/interrupts/etc., just in case
        start timer to powerdown h/w in N seconds

in which interface would be your device node (char dev, devfs node, etc).


	-pat



