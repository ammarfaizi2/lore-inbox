Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271355AbTHDBri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 21:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271356AbTHDBri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 21:47:38 -0400
Received: from clix.aarnet.edu.au ([192.94.63.10]:30890 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S271355AbTHDBrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 21:47:35 -0400
Message-ID: <3F2DBB2B.9050803@aarnet.edu.au>
Date: Mon, 04 Aug 2003 11:17:23 +0930
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australian Academic and Research Network
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com> <3F2C0C44.6020002@pobox.com> <20030802184901.G5798@almesberger.net> <3F2CAE61.7070401@pobox.com>
In-Reply-To: <3F2CAE61.7070401@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -101.8 IN_REP_TO,DOUBLE_CAPSWORD,PORN_3,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Really fast, really long pipes in practice don't exist for 99.9% of all 
> Internet users.

Writing from Australia, I think you're out by at least
one order of magnitude and probably two.  That is, I'd
expect about 10% of the net to be on long fast pipes.

Here every worthwhile fast pipe is a long fast pipe.  90% of
Australia's net traffic goes to the West Coast of the USA,
that's 14,000Km away.

Australia accounts for about 10% of current net traffic. About
30% of Australia's net traffic is from AARNet, typically
100Base-TX hosts.

So you're out by about an order of magnitude, just accounting
for one ISP in one small country.  I'll leave the calculations
for the academic networks of China to others.

> There is one interesting TOE solution, that I have yet to see created: 
> run Linux on an embedded processor, on the NIC.  This stripped-down 
> Linux kernel would perform all the header parsing, checksumming, etc. 
> into the NIC's local RAM.  The Linux OS driver interface becomes a 
> virtual interface with a large MTU, that communicates from host CPU to 
> NIC across the PCI bus using jumbo-ethernet-like data frames. Management 
> frames would control the ethernet interface on the other side of the PCI 
> bus "tunnel".

This assumes the offload processor is at least 100x faster at
processing the IP frames than the kernel.  There is silicon where
that is true (eg, network processors), but good GCC support for
that silicon is unlikely (as good GCC support for popular silicon
is somewhat lacking).

Someone else wrote:
> It's been tried a number of times. Usually, real life sneaks
> in at one point or another, leaving behind a complex mess.
> When they've sorted out these problems, regular TCP has caught
> up with the great optimized transport protocols. At that point,
> they return to their niche, sometimes tail between legs and
> muttering curses, sometimes shaking their fist and boldly
> proclaiming how badly they'll rub TCP in the dirt in the next
> round. Maybe they shed off some of the complexity, and trade it
> for even more aggressive optimization, which puts them into
> their niche even more firmly. Eventually, they fade away. 

This ignores the push-back of platform support onto protocol
design.  The IETF iSCSI WG discussed using tranpsort protocols
which allow out-of-order delivery of SCSI blocks, rather than
the head-of-queue blocking that happens using TCP, but it
was felt that iSCSI would never gain vendor support unless
it ran over TCP.

 > Another problem of TCP is that it has grown a bit too many
 > knobs you need to turn before it works over your really fast
 > really long pipe. (In one of the OLS after dinner speeches,
 > this was quite appropriately called the "wizard gap".)

That's Matt Mathis's phrase.  The Web100 project
<http://www.web100.org/> has a set of patches to the kernel
which go a long way to reducing the wizard gap.  It would be
nice to see those patches eventually appear in the Linux
mainstream.

It's disturbing to see patches with a similar purpose (such
as those instrumenting UDP) being knocked back on grounds
of slowing the TCP/IP path.  Which is a wonderful example
of suboptimisation.

 > That's why NFS turned off UDP checksums ;-) As soon as you put
 > it on IP, it will crawl to distances you didn't imagine in your
 > wildest dreams. It always does.

I'll note that Sun turned UDP checksumming back on.  Not
only is disk corruption forever, but Sun servers running
DNS servers were notorious for not checksumming DNS responses,
having the nasty effect of poisoning DNS caches.

The NANOG mailing list (a list of US ISP network engineers)
cooperated in finding all of these and getting those Classic
SunOS kernels patched to activate checksumming.  We couldn't
do that nowdays, the net is just so much bigger.

Do the net a favour, don't stuff with UDP checksumming.
RFC1122 (Host Requirements) states that checksumming
MUST be on by default and that hosts MAY allow checksumming
to be turned off per *program* (ie, not across the entire
box).  That requirement is born of bitter experience with
Classic SunOS's "no checksumming across the entire box by
default".

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Network Engineer          Email: glen.turner@aarnet.edu.au
  Australian Academic & Research Network   www.aarnet.edu.au
-- 
  linux.conf.au 2004, Adelaide          lca2004.linux.org.au
  Main conference 14-17 January 2004   Miniconfs from 12 Jan

