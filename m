Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSKMUxt>; Wed, 13 Nov 2002 15:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSKMUxt>; Wed, 13 Nov 2002 15:53:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13069 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262875AbSKMUxs>;
	Wed, 13 Nov 2002 15:53:48 -0500
Message-ID: <3DD2BD4C.7060502@pobox.com>
Date: Wed, 13 Nov 2002 15:59:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, rusty@rustcorp.com.au, kaos <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
References: <3DD2B1D5.7020903@pacbell.net> <20021113201710.GB7238@kroah.com> <3DD2B8D3.6060106@pacbell.net>
In-Reply-To: <3DD2B1D5.7020903@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

> Greg KH wrote:
>
> > On Wed, Nov 13, 2002 at 12:11:01PM -0800, David Brownell wrote:
> >
> >> The module-init-tools-0.6.tar.gz utilities (or something
> >> related -- kbuild changes?) break hotplug since they no
> >> longer produce the /lib/modules/$(uname -r)/modules.*map
> >> files as output ... so the hotplug agents don't have the
> >> pre-built database mapping device info to drivers.
> >
> >
> >
> > Last I heard, Rusty's still working on this.  He's also going to be
> > changing the format so we don't expose kernel structures to userspace,
> > which would be a good thing.
>
>
> So long as the _information_ in those structures stays available, good.


Agreed.

> And it'd be handy if the text format for that information didn't change;
> how it's stored in object modules doesn't matter.



Correction -- the tools that read the text format are buggy if they do 
not transparently support changes to the text format.
(Corollary: the text format is buggy if it does not support a method of 
noticing format changes)

I am planning on adding PCI revision id to the information exported via 
MODULE_DEVICE_TABLE(pci,...).  Tools which correctly read the 
first-line-format-definition will continue to function as before, 
regardless of additional fields I want to add.  Tools which make silly 
assumptions will have those assumptions come back to bite them ;-)

(tangent warning!)
Another long term idea I would eventually like to realize is the removal 
of device ids from the C source code.  I don't care where they go -- 
drivers/net/pci_ids [per directory ids?], drivers/net/3c59x.meta, 
whereever.  Anywhere but the C source code.  It's quite silly to require 
a driver rebuild just to add a single PCI id, and further, embedding 
metadata in C source is rarely a good idea in the long term.  [reference 
some of Linus's counter-arguments when it was mentioned that Donald 
Becker's method of including Config.{in,help} data in C source might be 
useful]

	Jeff



