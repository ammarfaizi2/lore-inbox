Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSKMVS4>; Wed, 13 Nov 2002 16:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSKMVRu>; Wed, 13 Nov 2002 16:17:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47885 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262881AbSKMVRm>;
	Wed, 13 Nov 2002 16:17:42 -0500
Message-ID: <3DD2C30B.9000404@pobox.com>
Date: Wed, 13 Nov 2002 16:24:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Brownell <david-b@pacbell.net>, rusty@rustcorp.com.au,
       kaos <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
References: <3DD2B1D5.7020903@pacbell.net> <20021113201710.GB7238@kroah.com> <3DD2B8D3.6060106@pacbell.net> <3DD2BD4C.7060502@pobox.com> <20021113210711.GA7810@kroah.com>
In-Reply-To: <3DD2B1D5.7020903@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Wed, Nov 13, 2002 at 03:59:56PM -0500, Jeff Garzik wrote:
>
> >(tangent warning!)
> >Another long term idea I would eventually like to realize is the removal
> >of device ids from the C source code.  I don't care where they go --
> >drivers/net/pci_ids [per directory ids?], drivers/net/3c59x.meta,
> >whereever.  Anywhere but the C source code.  It's quite silly to require
> >a driver rebuild just to add a single PCI id, and further, embedding
> >metadata in C source is rarely a good idea in the long term.  [reference
> >some of Linus's counter-arguments when it was mentioned that Donald
> >Becker's method of including Config.{in,help} data in C source might be
> >useful]
>
>
> True, this would be nice, but how would the driver know to bind to a new
> device, if it isn't rebuilt, and doesn't know about the new id that was
> just added?  In the current scheme of driver matching to devices, I
> don't see how this could be done.


I think that truly seamless rebinding is doable but would require too 
much additional complexity in the kernel.  Rebinding to a new id table 
between unregister() ... register() pairs, or between mod unload and mod 
load, should be enough to be useable for 98% of the cases.

It should be noted that David Hinds' pcmcia-cs package stores id in an 
external database.  There are both positive and negative lessons that 
have been learned from that experience (WRT external id tables only! 
:):)) too.


> Not to say I would not want to see this changed to allow this to happen,
> I'm very tired of telling USB Palm users to get a new kernel version
> just because a single device id was added which their new device has.


Indeed :/  There are also issues like vendors who want to GPG-sign 
drivers, and updating the PCI id table makes the GnuPG signature and the 
certification that goes along with it invalid, requiring a vendor update.

	Jeff


