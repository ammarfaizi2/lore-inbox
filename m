Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292438AbSBPQxR>; Sat, 16 Feb 2002 11:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292439AbSBPQxI>; Sat, 16 Feb 2002 11:53:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31238 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292438AbSBPQww>; Sat, 16 Feb 2002 11:52:52 -0500
Subject: Re: what serial driver restructure is planned?
To: Telford002@aol.com
Date: Sat, 16 Feb 2002 17:06:01 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, ncw@axis.demon.co.uk, linux@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <194.2606a8e.299fb282@aol.com> from "Telford002@aol.com" at Feb 16, 2002 08:02:58 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c8Hh-0006dd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The flip buffer and output tmp_buf logic is not particularly
> friendly to packetized serial data streams, which are normal
> with most synchronous serial communications or IP over
> asynchronous link setups  -- especially when the
> serial interface chip understands PPP frames.

There I disagree with dumber devices

> The current TTY formalism is not particularly
> friendly to dial-on-demand synchronous WAN
> communications.  It is not impossible that 
> a /dev/ttyraw device, which could easily shift
> between asynchronous and synchronous modes,
> might be a better approach.

I think thats misunderstanding how to use the existing interfaces. If you
have an ioctl to switch the mode of your device, you can exist dually as
a network interface (DMA into skbuff, fire at network stack through generic
PPP or the cisco hdlc layer) and as a tty interface in async mode.

The byte by byte PPP code we currently have exists primarily for the normal
dumb or minimally intelligent devices. If your device is smaller you can
simply give it a dual personality. The Z85230 driver I wrote did
this although the generic 8530 async code never got ported into the final
device and released in that form.


