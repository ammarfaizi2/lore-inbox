Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTHYWtA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTHYWtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:49:00 -0400
Received: from bolt.sonic.net ([208.201.242.18]:41100 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S262357AbTHYWsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:48:55 -0400
Date: Mon, 25 Aug 2003 15:48:29 -0700
From: David Hinds <dhinds@sonic.net>
To: damjan@bagra.net.mk
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au,
       dahinds@users.sourceforge.net
Subject: Re: Trivial patch for drivers/serial/8250_cs
Message-ID: <20030825154829.B20096@sonic.net>
References: <3F4A7F2C.7080205@bagra.net.mk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4A7F2C.7080205@bagra.net.mk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 11:27:08PM +0200, ???????????? ?????????????????????? wrote:
> This patch is against 2.6.0-test4.
> It fixes the pcmcia serial driver to know its now called 8250_cs and not 
> serial_cs...
> 
> Without this patch 8250_cs compiles but doesn't work.

What do you mean by "doesn't work", exactly?  The existing name should
work if you have:

  device "serial_cs" module "8250_cs"

in /etc/pcmcia/config.  With your patch, it would work with:

  device "8250_cs" module "8250_cs"

(and also changing every instance of serial_cs to 8250_cs)

> All the patch does is change several "serial_cs" occurences to "8250_cs".
>
> PS.
> another possible sollution is to change everything (including the file 
> name) from "8250_cs" to "serial_cs" like it is in 2.4

I would say that "serial_cs" is more accurate since this is the driver
for cards that conform to the standard for PCMCIA serial interfaces.
Renaming to "8250_cs" is obfuscatory and pointlessly breaks config
files for previous kernel versions.  It is second in foolishness only
to the genious who thought renaming "ide_cs" to "ide-cs" was a good
idea.

-- Dave

P.S. -- your email name ('???...') is a good way to target your email
to the spam bucket; I almost discarded it myself.
