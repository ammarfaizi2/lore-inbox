Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292945AbSBVSLK>; Fri, 22 Feb 2002 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292947AbSBVSK7>; Fri, 22 Feb 2002 13:10:59 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:33766 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S292945AbSBVSKm>; Fri, 22 Feb 2002 13:10:42 -0500
Date: Fri, 22 Feb 2002 18:09:57 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zach Brown <zab@zabbo.net>
Subject: Re: is CONFIG_PACKET_MMAP always a win?
Message-ID: <20020222180957.A16796@kushida.apsleyroad.org>
In-Reply-To: <3C75A418.2C848B3F@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C75A418.2C848B3F@kegel.com>; from dank@kegel.com on Thu, Feb 21, 2002 at 05:51:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> c) enable CONFIG_PACKET_MMAP, use PACKET_RX_RING, and read packets from an mmap'd ring buffer
>    Overhead: kernel does a full memcpy of the packet body to get it
>    into the ring buffer, and my program does another to get it out.

I had a look at this about a year ago, and it seems there is no method
provided to read the packets without copying them, if you need them in
user space.

Probably the fastest way to process packets in user space is to use a
special protocol handler of your own that mmaps the area where packets
are already DMAd from the driver.  I have been known to suggest simply
mapping all 1GB of low kernel memory into user space for this :-)  I
haven't tried this, or writing the protocol handler, though.

cheers,
-- Jamie


