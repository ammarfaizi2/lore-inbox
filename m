Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265003AbTIEVzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTIEVw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:52:58 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:34527 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262854AbTIEVwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:52:36 -0400
Subject: Re: [OOPS] 2.4.22 / HPT372N
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marko Kreen <marko@l-t.ee>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030905145452.GA24201@l-t.ee>
References: <20030904190426.GA31977@l-t.ee>
	 <1062712012.22550.72.camel@dhcp23.swansea.linux.org.uk>
	 <20030905145452.GA24201@l-t.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062798689.689.43.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Fri, 05 Sep 2003 22:51:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-05 at 15:54, Marko Kreen wrote:
> > so your PCI bus is running at somewhere about 35Mhz and outside the
> > drivers safe threshold. 
> 
> Thats surprising, nobody has intentionally overclocked it.
> 
> Now we did some experimenting with it and no BIOS settings seem
> to affect the FREQ numbers. (Lower CPU/mem speed, 50/25 AGP/PCI speed.)
> The FREQ still stays fixed at 85.
> Any idea how to remove the overclocking?  Otherwise it seems
> like driver bug to me.

The hardware measures the PCI bus clock against its own sources and the
85 (0x55) is its timing measurement. The maximum range for the 33Mhz 
timings on the card is  < 0x55 so it decides your clock is outside the
safe range. HPT have never given us 40Mhz clock timings for the 372N or
as far as I can tell published them so we don't know how to drive it at
40Mhz just 33 and 66.

You could tweak the driver to accept 0x55 but either the card clock is
out or you are overclocking your IDE by doing that.

