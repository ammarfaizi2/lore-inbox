Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVFHJ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVFHJ3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 05:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVFHJ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 05:29:14 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:32441 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S262150AbVFHJ3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 05:29:06 -0400
Message-ID: <42A6BA59.3010207@a-wing.co.uk>
Date: Wed, 08 Jun 2005 10:28:57 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sis5513.c patch
References: <42A621BC.7040607@a-wing.co.uk>	 <58cb370e05060800276f3fc29c@mail.gmail.com>	 <42A6AB1B.8000800@a-wing.co.uk>	 <58cb370e05060801585b49020e@mail.gmail.com> <58cb370e05060802149b2f530@mail.gmail.com>
In-Reply-To: <58cb370e05060802149b2f530@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> [ Andrew, please remove this patch from -mm queue. ]
> 
> On 6/8/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
>>On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
>>
>>>Bartlomiej Zolnierkiewicz wrote:
>>>
>>>>On 6/8/05, Andrew Hutchings <info@a-wing.co.uk> wrote:
>>>>
>>>>
>>>>>Hi,
>>>>
>>>>
>>>>Hi,
>>>>
>>>
>>>Hi again,
>>>
>>>
>>>>>I'm not sure if a similar patch has been submitted or not, but here is a
>>>>>patch to get DMA working on ASUS K8S-MX with a SiS 760GX/SiS 965L
>>>>>chipset combo.
>>>>
>>>>
>>>>This patch is incorrect, it adds PCI ID of SiS IDE controller (this ID
>>>>is common for almost all SiS IDE controllers and is already present in
>>>>sis5513_pci_tbl[]) to the table of SiS Host PCI IDs.  As a result driver
>>>>will try to use ATA_133 on all _unknown_ IDE controllers.  You need
>>>>to add PCI ID of the Host chipset (lspci should reveal it) instead.
> 
> 
> Second look into sis5513.c and another problem turns out - patch breaks 
> support for IDE controllers integrated into 961 and 961B South Bridges
> (ATA_133 is used instead of ATA_100 and ATA133a).
> 
> For unknown Host Bridges driver checks for presence of 961/961B/962/963
> South Bridges by checking true device ID (please see sis5513.c for details) 
> and assigns 'chipset_family' accordingly (ATA_100/ATA_133a or ATA_133).
> 
> You have 965L South Bridge so probably it has newer true device ID 
> and  may also require different programming sequence.
> 

Ah, you see this is what happens when I enter the scary world of driver 
patching, I'll will stick to patching/developing apps in future I think ;)

> 
>>Could you please send full lspci -vvv output?
> 
> 
> and lspci -xxx
> 
> Bartlomiej
> 

I'm just installing another one of those boards now ready to go into our 
racks later today, I'll give you the output from that shortly.
-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 24: network packets travelling uphill (use a carrier pigeon)
