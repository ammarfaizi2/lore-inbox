Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUFCPnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUFCPnZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264108AbUFCPnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:43:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48109 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264836AbUFCPmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:42:00 -0400
Message-ID: <40BF46BB.1080909@pobox.com>
Date: Thu, 03 Jun 2004 11:41:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] CRIS architecture update
References: <200406031419.i53EJgVI027812@hera.kernel.org>
In-Reply-To: <200406031419.i53EJgVI027812@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1726.1.144, 2004/06/01 08:52:29-07:00, akpm@osdl.org
> 
> 	[PATCH] CRIS architecture update
> 	
> 	From: "Mikael Starvik" <mikael.starvik@axis.com>
> 	
> 	- Lots of fixes from 2.4.
> 	
> 	- Updated for 2.6.6.
> 	
> 	- Added IDE driver
> 	
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Who reviewed the ethernet driver?
Who reviewed the IDE driver?
Has Bart seen this new driver?
Why was this committed without first being run by the subsystem maintainers?

In ethernet, the MII phy probe is wrong (don't need at id 0 first), it 
should be using linux/mii.h bits rather than inventing its own, 
del_timer versus del_timer_sync is questionable, the newly-added full 
duplex handling seems to be incorrect (ref drivers/net/mii.c and drivers 
that use mii_if->full_duplex), and cosmetic issues I won't bother to 
mention.

In IDE, it uses virt_to_page() when building the scatter/gather list -- 
something that IMO should not have been allowed in -mm much less 
mainline -- and other yuckiness.  In the same function, it's 
questionable whether or not it breaks with lba48.  etrax_dma_intr 
doesn't appear to check for some DMA engine conditions that code 
comments elsewhere in the driver indicate _do_ occur.  The 
ATAPI-specific e100_start_dma code doesn't look like it will work with 
all current ATAPI drivers (ide-{cdrom,floppy,tape,scsi,...}.c).

I'm happy that the CRIS people resurfaced, too, but that's no reason to 
just shove an unreviewed patch into mainline.

	Jeff


