Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTIOV7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTIOV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:59:11 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:17937 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S261624AbTIOV7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:59:07 -0400
Date: Mon, 15 Sep 2003 19:01:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-kernel@vger.kernel.org>
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
In-Reply-To: <20030912085435.6a26fec4.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0309151847160.2914-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Sep 2003, Stephan von Krawczynski wrote:

> On Fri, 12 Sep 2003 12:46:46 +1000
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> > > Both are 2.4.22. 192.168.1.1 is the testbox. I saw those with 2GB, but
> > > could fix it through more nfs-daemons and
> > > 
> > >         echo 2097152 >/proc/sys/net/core/rmem_max
> > >         echo 2097152 >/proc/sys/net/core/wmem_max
> > > 
> > > Are these values too small for 6 GB?
> > 
> > No.  The values are proportional to the number of server threads, not
> > the amount of RAM... and they should be un-necessary after 2.4.20
> > anyway as nfsd in the kernel makes the appropriate settings.
> 
> Oh. That's interesting. Then everything should be the same if I deleted
> those...
> 
> > > 2) Box is very slow, kswapd looks very active during tar of a local
> > > harddisk. Interactivity is really bad. Seems vm has a high time looking for
> > > free or usable pages. Compared to 2 GB the behaviour is unbelievably bad.
> > > 
> > > 3) Network performance has a remarkable dropdown during above tar. In fact
> > > doing simple pings every few minutes shows that quite a lot of them are
> > > simply dropped, never make it over the ethernet.
> > 
> > My only guess is that it is doing a lot of copying into low memory
> > because your devices can only DMA into/outof low memory.
> 
> I forgot to mention: Both network card and controller are 64 bit cards.
> Network card is (vendor 3com):
> Ethernet controller: Broadcom Corporation NetXtreme BCM5701 Gigabit Ethernet
> (rev 15) (tg3-driver)
> Controller is:
> RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
> I have "CONFIG_HIGHIO=y"
> 
> > Have you tried 2.6 ??
> 
> No, not yet. I have not dared :-)
> 
> > How about CONFIG_HIGHMEM4G ?
> > It won't use all the RAM, but it would be interesting if it were
> > faster.
> 
> I already thought about that and tried. In fact it is as fast and fine as 2 GB
> setup. It runs really smooth. 
> The really simple test for the problem is running "updatedb" (find over the
> whole filesystem). The box comes to a crawl while this is running, network is
> absolutely bad, interactivity is rather dead, very often not even a ssh login
> works.

Does -pre4 (with the VM changes from Andrea) show any difference? There 
are significant changes in the per-zone decisions which might help.

Have you tried 2.4.22-aa?

Thanks


