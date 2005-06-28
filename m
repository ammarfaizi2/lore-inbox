Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVF1JZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVF1JZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVF1JXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:23:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58033 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262026AbVF1JVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:21:42 -0400
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
From: Arjan van de Ven <arjan@infradead.org>
To: Mike Bell <kernel@mikebell.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050628090852.GA966@mikebell.org>
References: <20050624081808.GA26174@kroah.com>
	 <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org>
	 <200506271735.50565.dtor_core@ameritech.net>
	 <20050627232559.GA7690@mikebell.org> <20050628074015.GA3577@kroah.com>
	 <20050628090852.GA966@mikebell.org>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 11:21:27 +0200
Message-Id: <1119950487.3175.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 02:08 -0700, Mike Bell wrote:
> On Tue, Jun 28, 2005 at 12:40:15AM -0700, Greg KH wrote:
> > > 1) Predictable, canonical device names are a Good Thing.
> > 
> > And impossible for the kernel to generate given hotpluggable devices.
> 
> Bull. It's clear I'm talking about per-subsystem, not having individual
> devices show up with the same name each time. 

you still can't have that. think USB harddisks for example. The only way
you can do this reliable is to use UUIDs from the disks. Guess what..
udev does that. devfs doesn't.

Same for PCI hotplug; the "path" to your pci IDE controller might change
after you "hotplugged" some stuff. And no that's not just high end
hardware; most docking stations are like this too. Again, only the disk
UUID is usable for getting stable naming.


> > I don't accept it, and neither does anyone else.
> 
> So then explain this to me, I've got a GUI sound player, on first
> invocation it displays a list of sound cards installed on the system,
> allows the user to select one, and then plays the sound file. How is it
> supposed to do that if the device nodes for sound card 0 could be named
> anything? I can get a list of sound cards from /proc/asound or
> /sys/class/sound, but unless the sound card device nodes are predictably
> named there's no way to find them short of searching every node in /dev.


actually.. linphone for example shows you the name of the device, not
the device node. And at runtime it finds which device node belongs to
that name somehow. I didn't look at the code how it does that, but it
sure isn't impossible since it's done in practice already.


