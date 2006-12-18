Return-Path: <linux-kernel-owner+w=401wt.eu-S1754700AbWLRWol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbWLRWol (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754715AbWLRWol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:44:41 -0500
Received: from nigel.suspend2.net ([203.171.70.205]:53971 "EHLO
	nigel.suspend2.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbWLRWok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:44:40 -0500
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
From: Nigel Cunningham <nigel@nigel.suspend2.net>
Reply-To: nigel@nigel.suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-pm@lists.osdl.org,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-pm@osdl.org
In-Reply-To: <200612182338.24843.rjw@sisk.pl>
References: <4586797B.3080007@gmail.com> <200612181646.23292.rjw@sisk.pl>
	 <4586C99C.9020606@gmail.com>  <200612182338.24843.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 09:44:38 +1100
Message-Id: <1166481878.5044.4.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2006-12-18 at 23:38 +0100, Rafael J. Wysocki wrote:
> On Monday, 18 December 2006 18:02, Jiri Slaby wrote:
> > Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > On Monday, 18 December 2006 12:20, Jiri Slaby wrote:
> > >> Hi.
> > >>
> > >> I got this oops while suspending:
> > >> [  309.366557] Disabling non-boot CPUs ...
> > >> [  309.386563] CPU 1 is now offline
> > >> [  309.387625] CPU1 is down
> > >> [  309.387704] Stopping tasks ... done.
> > >> [  310.030991] Shrinking memory... -<0>divide error: 0000 [#1]
> > >> [  310.456669] SMP
> > >> [  310.456814] last sysfs file:
> > >> /devices/pci0000:00/0000:00:1e.0/0000:02:08.0/eth0/statistics/collisions
> > >> [  310.456919] Modules linked in: eth1394 floppy ohci1394 ide_cd ieee1394 cdrom
> > >> [  310.457259] CPU:    0
> > >> [  310.457260] EIP:    0060:[<c0150c9a>]    Not tainted VLI
> > >> [  310.457261] EFLAGS: 00210246   (2.6.20-rc1-mm1 #207)
> > >> [  310.457478] EIP is at shrink_slab+0x9e/0x169
> > > 
> > > Looks like we have a problem with slab shrinking here.
> > > 
> > > Could you please use gdb to check what exactly is at shrink_slab+0x9e?
> > 
> > Sure, but not till Friday, sorry (I am away).
> 
> I reproduced this on one box, but then it turned out that EIP was at line 195
> of mm/vmscan.c where there was
> 
> do_div(delta, lru_pages + 1);
> 
> Well, I have no idea how this can lead to a divide error (lru_pages is
> unsigned).
> 
> I'm unable to reproduce this on another i386 box, so it seems to be somewhat
> configuration specific.
> 
> Does 2.6.20-rc1 work for you?

I have a patch in -mm that reduces lru_pages by what shrink_all_zones
returns. Could shrink_all_zones perhaps be returning incorrect values
such that lru_pages ends up becoming -1?

Regards,

Nigel

