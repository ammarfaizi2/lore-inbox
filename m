Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269036AbTCAVxA>; Sat, 1 Mar 2003 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269042AbTCAVxA>; Sat, 1 Mar 2003 16:53:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3334 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269036AbTCAVxA>; Sat, 1 Mar 2003 16:53:00 -0500
Date: Sat, 1 Mar 2003 14:00:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.63
In-Reply-To: <20030301213853.GA1975@kroah.com>
Message-ID: <Pine.LNX.4.44.0303011357130.2079-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 1 Mar 2003, Greg KH wrote:
> 
> It looks right to me, but I don't have a working cardbus machine at the
> moment, so I can't test it, sorry.

I don't think this is right. When we unplug a device, we're unplugging it 
whether it is unused or not, and pci_remove_device_safe() is the wrong 
thing. It should use the "remove_behind_bridge()" thing, so I think 
Russell's patch is closer to working, but that one looked like it will 
certainly corrupt memory with any multi-function device, so I really would 
want to see something that has actually been tested too.

		Linus

