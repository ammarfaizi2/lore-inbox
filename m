Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTEKSGp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTEKSGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:06:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64660
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261825AbTEKSGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:06:44 -0400
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>
In-Reply-To: <3EBE8768.4000007@pobox.com>
References: <200305111647.32113.daniel.ritz@gmx.ch>
	 <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
	 <3EBE8768.4000007@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052673649.29921.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 18:20:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 18:24, Jeff Garzik wrote:
> If netif_device_present() returns false, we think the hardware has 
> disappeared.  So that implies a bug in calling netif_device_detach() no 
> a bug in the irq handler return value.

Not really. The IRQ can be outstanding from the hardware unplug,
especially on PCMCIA. Its an edge triggered IRQ so the unplug is very
likely to latch an IRQ for delivery as the connector unplugs.

>   If pcmcia hardware disappears on you, you _really_ don't want to be 
> bitbanging its ports.

Its quite safe to do so. What we must do is ensure we don't reallocate
the ports until they are truely freed. The current PCMCIA seems to get
that right, (the current PCI locking for cardbus and hotplug is still
terminally broken of course)

Alan

