Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVBXBTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVBXBTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVBXBTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:19:41 -0500
Received: from hyperion.affordablehost.com ([12.164.25.86]:5358 "EHLO
	hyperion.affordablehost.com") by vger.kernel.org with ESMTP
	id S261696AbVBXBTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:19:38 -0500
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
From: Alan Kilian <kilian@bobodyne.com>
To: Roland Dreier <roland@topspin.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <52sm3malg1.fsf@topspin.com>
References: <1109190273.9116.307.camel@desk>
	 <Pine.LNX.4.61.0502231538230.5623@chaos.analogic.com>
	 <1109197066.9116.319.camel@desk>
	 <16925.2739.232237.418632@wombat.chubb.wattle.id.au>
	 <1109201098.9116.330.camel@desk>  <52sm3malg1.fsf@topspin.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 19:23:41 -0600
Message-Id: <1109208221.9116.337.camel@desk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hyperion.affordablehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bobodyne.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 15:46 -0800, Roland Dreier wrote:
>     Alan> 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &softp->interrupt_line);
>     Alan> 	request_irq(softp->interrupt_line, sseintr, SA_INTERRUPT, "sse", softp);
> 
> Don't do that.  The kernel may need you to use a different interrupt
> number than you read from the PCI config header.  Use dev->irq, as in
> 
> 	request_irq(dev->irq, sseintr, SA_SHIRQ | SA_INTERRUPT, "sse", softp);

    Roland, 

	You are the best. Thank you so much for this information.

    	That was the ticket.

    	request_irq(dev->irq, sseintr, SA_SHIRQ | SA_INTERRUPT, 
	            "sse", softp);

    	It works on all machines now without adding "pci=noapci"

    	I'm running again!!!

                                     -Alan

-- 
- Alan Kilian <kilian(at)bobodyne.com>


