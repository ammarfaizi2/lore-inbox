Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261506AbSKNS3I>; Thu, 14 Nov 2002 13:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSKNS3I>; Thu, 14 Nov 2002 13:29:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11794 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261506AbSKNS3G>; Thu, 14 Nov 2002 13:29:06 -0500
Date: Thu, 14 Nov 2002 10:36:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>,
       <mochel@osdl.org>
Subject: Re: [PATCH] eliminate pci_dev name
In-Reply-To: <3DD3EB3D.8050606@pobox.com>
Message-ID: <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Nov 2002, Jeff Garzik wrote:
> 
> You should increase DEVICE_NAME_SIZE in include/linux/device.h from 80 
> to 90, though.  I assume you don't want to take the other option, which 
> is to audit every use and all the id strings to make sure they're short 
> enough.  In fact, IIRC, device name increased in size due to some really 
> long PCI names, so I think '90' will wind up the preferred value in any 
> case.

Actually, I think we should do the reverse (for testing), and make the
name be something small like 8 bytes, and make sure that everybody who
writes the name uses strncpy()  and snprintf() instead of just blindly
writing whatever is in the database.

Otherwise we'll always end up having fragile magic constants.

Anybody willing to do that cleanup?

		Linus

