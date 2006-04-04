Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWDDCru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWDDCru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 22:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWDDCru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 22:47:50 -0400
Received: from rtr.ca ([64.26.128.89]:30597 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964963AbWDDCrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 22:47:49 -0400
Message-ID: <4431DE2B.1020306@rtr.ca>
Date: Mon, 03 Apr 2006 22:47:07 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060402 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
Cc: "Eric D. Mudama" <edmudama@gmail.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
References: <20060402155647.GB20270@localdomain> <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com> <20060403215729.GA17731@localdomain>
In-Reply-To: <20060403215729.GA17731@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni wrote:
>
>  * Normal boot
>  * insmod sata_mv
>  * all is okay, as expected
>  * rmmod sata_mv
>  * insmod sata_mv 
>  * all is bad, as expected
>  * kexec
>  * insmod sata_mv
>  * all is bad!
> 
> Conclusion: sata_mv's shutdown does something bad.

sata_mv seems to just use the default libata shutdown sequence,
so perhaps it's leaving the device in EDMA mode with interrupt
coalescing still on (from the BIOS), and interrupts are still
coming in or something..

I suppose it really ought to shut down the device before exiting,
and maybe the default of pci_disable_device() is not enough.. ?

Cheers

