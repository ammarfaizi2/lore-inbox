Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTE0AU2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTE0AU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:20:28 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5324
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262400AbTE0AU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:20:27 -0400
Subject: Re: [PATCH] xirc2ps_cs irq return fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
	 <3ED16351.7060904@pobox.com>
	 <Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 00:35:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-26 at 02:00, Zwane Mwaikambo wrote:
> My interpretation of it is the PCMCIA controller was triggering interrupts 
> on exit and the link handler for the card was still installed even after 
> the netdevice was down.

This is exactly what will happen all the time on PCMCIA devices. The
edge triggered interrupt will cause an IRQ to float around every remove
of the device on most hardware

The fix is basically correct, although the odd floating IRQ ought to be
cleaned up by the heuristics being fixed in the core IRQ disaster
detector

