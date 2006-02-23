Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWBWJuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWBWJuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 04:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751684AbWBWJuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 04:50:40 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:42981
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751096AbWBWJuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 04:50:39 -0500
Message-ID: <001901c6385e$9aee7d40$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: "\"Christoph Hellwig\"" <hch@infradead.org>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <billion.wu@areca.com.tw>,
       <alan@lxorguk.ukuu.org.uk>, <akpm@osdl.org>, <oliver@neukum.org>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com> <20060220182045.GA1634@infradead.org> <001401c63779$12e49aa0$b100a8c0@erich2003> <20060222145733.GC16269@infradead.org> <00dc01c63842$381f9a30$b100a8c0@erich2003> <1140683157.2972.6.camel@laptopd505.fenrus.org>
Subject: Re: Areca RAID driver remaining items?
Date: Thu, 23 Feb 2006 17:50:37 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 23 Feb 2006 09:46:33.0796 (UTC) FILETIME=[07F11840:01C6385E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arjan van de Ven,

The following contex is coming from comment of Christoph Hellwig.

- msi should be a module options if at all, but defintitly not
   a config options

#ifdef CONFIG_SCSI_ARCMSR_MSI
 if (!pci_enable_msi(pci_device))
  pACB->acb_flags |= ACB_F_HAVE_MSI;
#endif

I make an option config for prevent some mainboards hang up if arcmsr enable 
msi function.
Areca RAID controller is bridged hardware.
There were a lots of mainboards had wrong IRQ routing table issue with it.
If somebody meet this issue and people can enable msi function to fix its 
hardware bug.
But unfortunately I found some mainboards will hang up if I always enable 
this function in my lab.
To avoid this issue, I do an option for this case.

But  Christoph Hellwig give me comment with it.

Best Regards
Erich Chen

----- Original Message ----- 
From: "Arjan van de Ven" <arjan@infradead.org>
To: "erich" <erich@areca.com.tw>
Cc: "Christoph Hellwig" <hch@infradead.org>; <linux-scsi@vger.kernel.org>; 
<linux-kernel@vger.kernel.org>; <billion.wu@areca.com.tw>; 
<alan@lxorguk.ukuu.org.uk>; <akpm@osdl.org>; <oliver@neukum.org>
Sent: Thursday, February 23, 2006 4:25 PM
Subject: Re: Areca RAID driver remaining items?


> On Thu, 2006-02-23 at 14:27 +0800, erich wrote:
>> Dear Christoph Hellwig,
>>
>> I have figure out your comments about "remove internal queueing" and 
>> "remove
>> odd ioctl".
>> But about "hardware datastructures", areca's firmware spec is need to get 
>> a
>> trunk of contingous memory space under 4G.
>> In 64bit platform arcmsr need to make sure all ccbs have same of
>> ccb_phyaddr_hi32 physical address.
>> If arcmsr use dma_pool_alloc do a separate dma mapping.
>> Is there any method to avoid ccbs pool cross 4G segment?
>
> the pci mapping layer prevents that already entirely; there is a LOT of
> hardware that cannot deal with segments crossing 4G boundaries, so much
> in fact that it's now generically disabled.
>
>
>> In some mainboard if I always enable msi function, it will cause system 
>> hang
>> up.
>> If it is not a config option, do you have any idea to avoid this issue?
>
> how about a module option (module_param)?
>
> 

