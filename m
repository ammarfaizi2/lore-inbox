Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131447AbRAGTYt>; Sun, 7 Jan 2001 14:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131528AbRAGTYj>; Sun, 7 Jan 2001 14:24:39 -0500
Received: from mail.zmailer.org ([194.252.70.162]:53518 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131447AbRAGTYZ>;
	Sun, 7 Jan 2001 14:24:25 -0500
Date: Sun, 7 Jan 2001 21:24:14 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
Message-ID: <20010107212414.B25659@mea-ext.zmailer.org>
In-Reply-To: <20010107210036.G25076@mea-ext.zmailer.org> <Pine.GSO.4.30.0101071408140.18916-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0101071408140.18916-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Jan 07, 2001 at 02:10:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 02:10:52PM -0500, jamal wrote:
> On Sun, 7 Jan 2001, Matti Aarnio wrote:
> > 	Read what I wrote about the issue to Alan.
> > 	Ben's code has no problems with receiving VLANs with network
> > 	cards which have "hardware support" for VLANs.
> 
> OK. I suppose an skb->vlan_tag is passed to the driver and it will know
> what to do with it (pass it on a descriptor etc).

	Sure, nice.  WHY SHOULD THERE BE MORE LAYER-2 STUFF ADDED TO
	SKB OBJECTS ?

	One of important abstraction issues is to isolate device specific
	new things (like what VLAN/PVC/SVC is used at your favourtite
	802.1Q/ATM/X.25/FrameRelay connection).

	The less we leak that kind of things to SKB, the better, IMO.
	They are net_device issues, after all.

	Tell me (if you can), why packet sender calls hardware-header
	generation for packet, if the card can insert it for you ?
	Consider the structure of Ethernet MAC header, where is source
	address ?  Where is the destination address ?  If you write the
	destination, why should you not write the source there too ?

	No doubt some cards can fill in the source address while doing
	frame transmit, but is it worth the hazzle ?

> cheers,
> jamal

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
