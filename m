Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSGPLF1>; Tue, 16 Jul 2002 07:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSGPLF0>; Tue, 16 Jul 2002 07:05:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28993 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314451AbSGPLFZ>; Tue, 16 Jul 2002 07:05:25 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removal of pci_find_* in 2.5
References: <20020713003601.GA12118@kroah.com>
	<m1znwuoyze.fsf@frodo.biederman.org>
	<20020716002530.GA32431@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jul 2002 04:56:53 -0600
In-Reply-To: <20020716002530.GA32431@kroah.com>
Message-ID: <m1ofd8ndoq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Sun, Jul 14, 2002 at 02:07:01PM -0600, Eric W. Biederman wrote:
> > 
> > The driver is a mtd map driver.  It knows there is a rom chip behind 
> > a pci->isa bridge.  And it needs to find the pci->isa bridge to
> > properly set it up to access the rom chip (enable writes and the
> > like).  
> > 
> > It isn't a driver for the pci->isa bridge, (I'm not even certain we
> > have a good model for that).  So it does not use pci_register_driver.
> > 
> > If you can give me a good proposal for how to accomplish that kind of
> > functionality I would be happy to use the appropriate
> > xxx_register_driver.
> 
> I don't think there is a good way for you to convert over to
> _register_driver(), that's the main reason I'm keeping the pci_find_*
> functions around, they are quite useful for lots of situations.
> 
> It doesn't sound like you are worrying about your device working in a
> pci hotplug system, and you would probably be willing do any pci device
> conversion work to the new driver model yourself, right?  :)

Assuming I can actually fit in better with the new driver model.  As
far as hot-plug.  It is an abuse but I regularly hot-swap my rom chips
in my development system.

I am probably looking at this from the wrong angle but my problem with
current code base seems to be that I can only have one driver per pci
device.

In any case I would like to have code that fits in nicely with the
new driver system.  I can take about one change in kernel API.  For
the most part the drivers are trivial, and having non-trivial
maintenance for trivial code is less than ideal.

Eric
