Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266346AbUFQBrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbUFQBrn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 21:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266356AbUFQBrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 21:47:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48583 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266346AbUFQBrj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 21:47:39 -0400
Message-ID: <40D0F824.8010108@pobox.com>
Date: Wed, 16 Jun 2004 21:47:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.7] new NVIDIA libata SATA driver
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B6@mail-sc-6-bk.nvidia.com>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF043984B6@mail-sc-6-bk.nvidia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Chew wrote:
>>From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> 
> 
>>If silicon isn't available yet, let's just remove those PCI 
>>IDs.  That way we can ensure that these are libata only, 
>>without two drivers sharing the same PCI ids.
> 
> 
> If that's the case, I'd rather the CK804 and MCP04 SATA device IDs be
> added to sata_nv, since we want distributions to support these SATA
> controllers when silicon does become available.

OK


>>>>Removing IDs from amd74xx.c is a bad idea,
>>>>it breaks boot on systems already using these IDs.
>>>
>>>I assume these systems will be able to boot using the libata 
>>>subsystem. Is that a bad assumption?
>>
>>They can, but consider a system that uses 2.6.7 (IDE driver) 
>>then boots into 2.6.8 (libata driver):  the drives move from 
>>/dev/hdX to /dev/sdX. That breaks stuff not using LABEL= in 
>>bootloader config and fstab.
> 
> 
> That's true.  I kinda chalk this up as an inevitable kernel upgrade
> issue (they'll be getting support for NVIDIA SATA under libata with
> eventual device hotplug support, at the cost of some system
> reconfiguration).  Is there a good solution?

None really, other than trying to make sure we only add new SATA 
hardware support under libata.

Most users with Red Hat or SuSE or whatever don't know enough other than 
"I booted the new Fedora 2.6.x kernel, and it panic'd when it tried to 
mount root filesystem"

Your patch represented the _ideal_, but unfortunately once added to the 
IDE driver, those PCI ids should not be removed in the middle of a 
stable kernel series.  If both drivers were /dev/sdX, or /dev/hdX, 
moving the PCI ids to another driver wouldn't be as big of a deal.


Overall... no worries.  I have to deal with this issue for a couple 
other chipsets, so I'll handle them all at the same time.

	Jeff

