Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267311AbUIEXEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267311AbUIEXEc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 19:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUIEXEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 19:04:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267311AbUIEXE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 19:04:27 -0400
Date: Mon, 6 Sep 2004 00:04:25 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       willy@debian.org
Subject: Re: multi-domain PCI and sysfs
Message-ID: <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409041527.50136.jbarnes@engr.sgi.com> <9e47339104090415451c1f454f@mail.gmail.com> <200409041603.56324.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409041603.56324.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 04:03:56PM -0700, Jesse Barnes wrote:
> On Saturday, September 4, 2004 3:45 pm, Jon Smirl wrote:
> > Is this a multipath configuration where pci0000:01 and pci0000:02 can
> > both get to the same target bus? So both busses are top level busses?
> >
> > I'm trying to figure out where to stick the vga=0/1 attribute for
> > disabling all the VGA devices in a domain. It's starting to look like
> > there isn't a single node in sysfs that corresponds to a domain, in
> > this case there are two for the same domain.
> 
> Yes, I think that's the case.  Matthew would probably know for sure though.

Huh, eh, what?  There's no such thing as multipath PCI configurations.
The important concepts in PCI are:

 - the function
 - the device
 - the bus
 - the root bus
 - the domain
 - the machine

That is, a machine contains one or more PCI domains, each domain contains
one or more root busses, each root bus may have bridges to a collection
of other busses, each bus contains one or more devices, each device
contains one or more functions.

Many people confuse the domain and the root bus.  HP has made many
machines with multiple root busses in a single PCI domain, particularly
in the PA-RISC line.  Frequently the topology of these machines looks
like this: http://www.hp.com/products1/itanium/chipset/2-way_block.html

Each of the six chips labelled "hp zx1 I/O adapters" is a host to PCI
bridge; thus this sample machine has 6 root busses.  Despite that, it's
a single domain -- all the devices are numbered so as to not overlap.
It's theoretically possible to communicate between devices under different
I/O adapters, but this isn't a supported configuration.

HP's multiple domain machines (eg rx8620) look something like several
of these tied together.  That's not really how it works, but that's a
good way to imagine them.

I haven't really looked at the VGA attribute.  I think Ivan or Grant
would be better equipped to help you on this front.  I remember them
rehashing it 2-3 years ago.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
