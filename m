Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274892AbTHFHXL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274896AbTHFHXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:23:11 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60166
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S274892AbTHFHXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:23:04 -0400
Date: Wed, 6 Aug 2003 00:12:36 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Werner Almesberger <werner@almesberger.net>,
       Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: TOE brain dump
In-Reply-To: <3F2CAE61.7070401@pobox.com>
Message-ID: <Pine.LNX.4.10.10308060009130.25045-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeff,

Do be sure to check that your data payload is correct.
Everyone knows that a router/gateway/switch with a sticky bit in its
memory will recompute the net crc16 checksum insure it pass the to the nic
regardless.  It is amazing how much data can be corrupted by a network
environment via all the NFS/NBD/etc wantabie storage products out there.

Just a chuckle for you to ponder.

--a

On Sun, 3 Aug 2003, Jeff Garzik wrote:

> Werner Almesberger wrote:
> > Jeff Garzik wrote:
> > 
> >>jabbering at the same time.  TCP is a "one size fits all" solution, but 
> >>it doesn't work well for everyone.
> > 
> > 
> > But then, ten "optimized xxPs" that work well in two different
> > scenarios each, but not so good in the 98 others, wouldn't be
> > much fun either.
> > 
> > It's been tried a number of times. Usually, real life sneaks
> > in at one point or another, leaving behind a complex mess.
> > When they've sorted out these problems, regular TCP has caught
> > up with the great optimized transport protocols. At that point,
> > they return to their niche, sometimes tail between legs and
> > muttering curses, sometimes shaking their fist and boldly
> > proclaiming how badly they'll rub TCP in the dirt in the next
> > round. Maybe they shed off some of the complexity, and trade it
> > for even more aggressive optimization, which puts them into
> > their niche even more firmly. Eventually, they fade away.
> > 
> > There are cases where TCP doesn't work well, like a path of
> > badly mismatched link layers, but such paths don't treat any
> > protocol following the end-to-end principle kindly.
> > 
> > Another problem of TCP is that it has grown a bit too many
> > knobs you need to turn before it works over your really fast
> > really long pipe. (In one of the OLS after dinner speeches,
> > this was quite appropriately called the "wizard gap".)
> > 
> > 
> >>It's obviously not over a WAN...
> > 
> > 
> > That's why NFS turned off UDP checksums ;-) As soon as you put
> > it on IP, it will crawl to distances you didn't imagine in your
> > wildest dreams. It always does.
> 
> Really fast, really long pipes in practice don't exist for 99.9% of all 
> Internet users.
> 
> 
> When you approach traffic levels that push you want to offload most of 
> the TCP net stack, then TCP isn't the right solution for you anymore, 
> all things considered.
> 
> 
> The Linux net stack just isn't built to be offloaded.  TOE engines will 
> either need to (1) fall back to Linux software for all-but-the-common 
> case (otherwise netfilter, etc. break), or, (2) will need to be 
> hideously complex beasts themselves.  And I can't see ASIC and firmware 
> designers being excited about implementing netfilter on a PCI card :)
> 
> Unfortunately some vendors seem to choosing TOE option #3:  TCP offload 
> which introduces many limitations (connection limits, netfilter not 
> supported, etc.) which Linux never had before.  Vendors don't seem to 
> realize TOE has real potential to damage the "good network neighbor" 
> image the net stack has.  The Linux net stack's behavior is known, 
> documented, predictable.  TOE changes all that.
> 
> There is one interesting TOE solution, that I have yet to see created: 
> run Linux on an embedded processor, on the NIC.  This stripped-down 
> Linux kernel would perform all the header parsing, checksumming, etc. 
> into the NIC's local RAM.  The Linux OS driver interface becomes a 
> virtual interface with a large MTU, that communicates from host CPU to 
> NIC across the PCI bus using jumbo-ethernet-like data frames. 
> Management frames would control the ethernet interface on the other side 
> of the PCI bus "tunnel".
> 
> 
> >>So, fix the other end of the pipeline too, otherwise this fast network 
> >>stuff is flashly but pointless.  If you want to serve up data from disk, 
> >>then start creating PCI cards that have both Serial ATA and ethernet 
> >>connectors on them :)  Cut out the middleman of the host CPU and host 
> >>memory bus instead of offloading portions of TCP that do not need to be 
> >>offloaded.
> > 
> > 
> > That's a good point. A hierarchical memory structure can help
> > here. Moving one end closer to the hardware, and letting it
> > know (e.g. through sendfile) that also the other end is close
> > (or can be reached more directly that through some hopelessly
> > crowded main bus) may help too.
> 
> Definitely.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

