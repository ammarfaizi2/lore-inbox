Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVBXAJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVBXAJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVBWXzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:55:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:50001 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261716AbVBWXq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:46:59 -0500
To: Alan Kilian <kilian@bobodyne.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
X-Message-Flag: Warning: May contain useful information
References: <1109190273.9116.307.camel@desk>
	<Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
	<1109197066.9116.319.camel@desk>
	<16925.2739.232237.418632@wombat.chubb.wattle.id.au>
	<1109201098.9116.330.camel@desk>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 23 Feb 2005 15:46:54 -0800
In-Reply-To: <1109201098.9116.330.camel@desk> (Alan Kilian's message of
 "Wed, 23 Feb 2005 17:24:58 -0600")
Message-ID: <52sm3malg1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Feb 2005 23:46:54.0910 (UTC) FILETIME=[F47DC5E0:01C51A01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Alan> I ask the card which interrupt line it was given at
    Alan> boot-time:

    Alan> 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &softp->interrupt_line);

    Alan> Then I request an IRQ:

    Alan> 	request_irq(softp->interrupt_line, sseintr, SA_INTERRUPT, "sse", softp);

Don't do that.  The kernel may need you to use a different interrupt
number than you read from the PCI config header.  Use dev->irq, as in

	request_irq(dev->irq, sseintr, SA_SHIRQ | SA_INTERRUPT, "sse", softp);

Also, make sure that you do pci_enable_device(dev) before you look at
dev->irq, since the field will not be initialized until you do that.

 - R.
