Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317290AbSFLPAz>; Wed, 12 Jun 2002 11:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317291AbSFLPAy>; Wed, 12 Jun 2002 11:00:54 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:13061 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S317290AbSFLPAx>; Wed, 12 Jun 2002 11:00:53 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>, "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Wed, 12 Jun 2002 17:00:20 +0200
Message-Id: <20020612150020.11313@smtp.adsl.oleane.com>
In-Reply-To: <3D075739.7010506@pacbell.net>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Those would be designed so they could be shared between
>   devices, invisibly to code talking to a struct device.
>
>   Example:  all USB devices connected to a given bus would
>   normally delegate to the PCI device underlying that bus.
>   (Except for non-PCI host controllers, of course!)
>
>   And the PCI versions of those methods have rather obvious
>   implementations ... :)

Yup. The simplest way I see here is to have a device automatically
inherit, by default, his parent device ones. The arch will provide
default "root" allocators, so a fully coherent or fully non-coherent
arch may not have to do anything but these.

Now, if a given bus in the arch need specific quirks, it's up to
the bus device node to put it's own versions to be used by it's
childs.

Ben.


