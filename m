Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUFSUop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUFSUop (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUFSUop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:44:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58077 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264655AbUFSUol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:44:41 -0400
Message-ID: <40D4A5AB.9060105@pobox.com>
Date: Sat, 19 Jun 2004 16:44:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Alexander Hammer <mha@mha.dyndns.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Corruption and crashes with SIL3112A SATA chipset
References: <1087668387.1972.72.camel@idoru>
In-Reply-To: <1087668387.1972.72.camel@idoru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Alexander Hammer wrote:
> Hi,
> 
> I'm experiencing both data corruption and crashes when using an SATA
> controller with the SIL3112A chipset. The controller itself is a "Syba"
> PCI adapter with two SATA-150 connectors:
>  
> http://www.syba.com/us/en/product/43/02/03/index.html
> 
> Two 200GB Seagate disks are connected to the adapter, and I have tested
> it in two different machines, by trying to store 180GB of data on each
> drive. Here's a list of the combinations of kernels and drivers, that I
> have tried, and what the outcome was:


Does it help to add the Seagate disk model number to the blacklist in 
sata_sil.c?

/* TODO firmware versions should be added - eric */
struct sil_drivelist {
         const char * product;
         unsigned int quirk;
} sil_blacklist [] = {
         { "ST320012AS",         SIL_QUIRK_MOD15WRITE },
         { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
         { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
         { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
         { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
         { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
         { "ST340014ASL",        SIL_QUIRK_MOD15WRITE },
[...]

