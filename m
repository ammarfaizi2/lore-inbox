Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUHFOFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUHFOFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHFOFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:05:43 -0400
Received: from the-village.bc.nu ([81.2.110.252]:9409 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265973AbUHFOFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:05:36 -0400
Subject: Re: [PATCH] pirq_enable_irq cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: agrover <agrover@groveronline.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20040804181457.GA30739@groveronline.com>
References: <20040804181457.GA30739@groveronline.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091797385.16288.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 06 Aug 2004 14:03:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-04 at 19:14, agrover wrote:
> Hi, this should apply cleanly against mm2 or rc3.
> 
> This is a cleanup of pirq_enable_irq. I couldn't understand this function easily 
> so I cleaned it up.
> 
> - Hoisted Via quirk to top -- shouldn't break anything but who knows - can someone 
> with this chipset test?
> 
> - Hoisted legacy IDE check too.

This looks odd (its hard to read it in diff format in this case). The
IDE check is only meant to be done if we look for an IRQ and find none.
This tells us the device is only connected for legacy mode.

The VIA one is fairly simple. After the IRQ has been identified or
selected the VIA needs the "true" PCI IRQ number in the IRQ_LINE
register because internal V-Bus devices are routed via IRQ line not via
IRQ pin as the PCI spec says.

