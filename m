Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbULAQkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbULAQkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbULAQkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:40:51 -0500
Received: from zeus.kernel.org ([204.152.189.113]:16852 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261305AbULAQkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:40:42 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Michael Thomas Heath <mheath06@wsdmail.net>, linux-kernel@vger.kernel.org
Subject: Re: INVALID CHECKSUM error (In Linux Video Capture Interface?)
Date: Wed, 1 Dec 2004 10:24:55 -0600
X-Mailer: KMail [version 1.2]
Cc: Mike.Thomas.Heath@gmail.com
References: <1101913737.41adde8998978@imp.wsdmail.net>
In-Reply-To: <1101913737.41adde8998978@imp.wsdmail.net>
MIME-Version: 1.0
Message-Id: <04120110245500.12163@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 December 2004 09:08, Michael Thomas Heath wrote:
> I recently underwent the effort to setup an older parallel Colour QuickCam
> on Linux using the Video4Linux interface. However, when I went to boot, I
> got an "INVALID CHECKSUM 0005" error:
>
> 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
> 0000:00:09.0: 3Com PCI 3c900 Cyclone 10Mbps TPO at 0xd400. Vers LK1.1.19
>  ***INVALID CHECKSUM 0005*** <6>Linux video capture interface: v1.00
> Colour QuickCam for Video4Linux v0.05
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>
>
> I've never encountered an error like this before; I asked around and people
> suggested testing my RAM (Which I did, everything was fine), and
> recompiling my kernel. I recompiled my kernel image, and used dd to copy to
> avoid errors in the copying of the kernel.

It is the network card... (you can find the message in drivers/net/3c59x.c)
The 0005 is the difference between the incorrect checksum and the eprom 
version

I believe there is an utility (also written by D. Becker) that can fix this.
It isn't a severe error - I've seen this after a W95 boot on other interfaces,
and I'm not sure why it occurs... (In the windows case, the problem was
cleared for every other reboot - wierd.)

In my case, it happens on a 3c509 card, and the utility is a 3c5x9setup.c
It allows inspection of the eprom on the network card, and had the ability
to recompute the checksum and update it. I suspect your card has a similar
capability to be programmed (like a netboot .

In your case you might look for a 3c59??setup.c utility. For all I know
it may be the SAME utility.

I checked www.scyld.com for such an utility, but got some "page not found" 
reportedly because of incompleted updates.

I don't think it should cause a problem, the driver looks like it goes ahead
and completes setup anyway. I think of it more as a hint of possible problem,
not an actual problem. The checksum SHOULD be correct, but isn't.

> I'd apreaciate you CC any replies to my home e-
> mail, "Mike.Thomas.Heath@gmail.com"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
