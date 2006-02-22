Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWBVG3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWBVG3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 01:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWBVG3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 01:29:18 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:26595
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751341AbWBVG3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 01:29:17 -0500
Message-ID: <001401c63779$12e49aa0$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <billion.wu@areca.com.tw>, <alan@lxorguk.ukuu.org.uk>, <akpm@osdl.org>,
       <erich@areca.com.tw>, <arjan@infradead.org>, <oliver@neukum.org>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com> <20060220182045.GA1634@infradead.org>
Subject: Re: Areca RAID driver remaining items?
Date: Wed, 22 Feb 2006 14:27:32 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 22 Feb 2006 06:23:42.0046 (UTC) FILETIME=[8699AFE0:01C63778]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph Hellwig,

Thanks for your comment with "arcmsr".
I will follow your comment to redo this driver.
But I am confuse with your mention about some items.
Hope you can tell me more detail and let me realy know your comment.

  1- remove internal queueing:

      Does the "internal queueing" is mention with arcmsr of ccb_free_list ?

  2- fix hardware datastructures:

      Does the "fix hardware datastructures" is to fix struct ARCMSR_CDB?
      Is it illeagal in linux?

  3- remove odd ioctls:

      How about remove odd ioctl?

Best Regards
Erich Chen

----- Original Message ----- 
From: "Christoph Hellwig" <hch@infradead.org>
To: "Dax Kelson" <dax@gurulabs.com>
Cc: <linux-scsi@vger.kernel.org>; <linux-kernel@vger.kernel.org>; 
<billion.wu@areca.com.tw>; <alan@lxorguk.ukuu.org.uk>; <akpm@osdl.org>; 
<erich@areca.com.tw>; <arjan@infradead.org>; <oliver@neukum.org>
Sent: Tuesday, February 21, 2006 2:20 AM
Subject: Re: Areca RAID driver remaining items?


> On Mon, Feb 20, 2006 at 11:02:32AM -0700, Dax Kelson wrote:
>> This appears to be the most current version of the driver:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/broken-out/areca-raid-linux-scsi-driver.patch
>>
>> Is this the current TODO list?
>>
>> =================
>> Issues not yet patched:
>>
>> 13. uintNN_t int types:  use kernel types except for userspace
>> interfaces
>> 14. use kernel-doc
>> 18. Put arcmsr.txt in Documentation/scsi/, not in scsi/arcmsr/.
>> 19. Maybe use sysfs (/sys) instead of /proc.
>> 20. check stack usage, init/exit sections;
>
>
> - remove internal queueing
> - fix hardware datastructures
> - remove odd ioctls
> - remove useless forward prototypes
> - give types like ACB useful names
> - give variable useful names, especially follow kernel conventions,
>   e.g. a struct pci_dev is usually named pdev
> - kill ->proc_info method
> - use normal comment style even for comments not fitting into the
>   kernel-doc item above.  kill useless separator comments without
>   text
> - convert arcmsr_show_firmware_info to useful one value per
>   file attributes.  best follow the schemes used in aacraid or
>   lpfc
> - convert arcmsr_show_driver_state to useful one value per
>   file attributes.
> - remove never called release method in the host template
> - audit whether setting unchecked_isa_dma to false really makes
>   sense (I strongly doubt it)
> - remove shutdown notifier, add pci_driver ->shutdown method instead
> - remove CameCase PCI Ids.  The vendor Id should go into pci_ids.h,
>   the device ids either removed or spelled the normal linux way
> - arcmsr_do_interrupt should stop walking the global host list
>   and use the private data passed to request_irq
> - the global host list should go away completely
> - arcmsr_bios_param looks like duplicating the generic CAM version?
> - locking needs to be redone.  If the driver really needs more than
>   one per-host lock we'll want a very good explanation
> - arcmsr_device_probe needs to be rewritten to do goto-based
>   error unwinding.
> - msi should be a module options if at all, but defintitly not
>   a config options
> - arcmsr_scsi_host_template_init should go away.  the host template
>   must be initialized statically with no run-time writes to it
> - the hardware documentation should be split out of arcmsr.h
>   into a separate file (btw, thanks a lot to areca to provide such
>   detailed hardware informations, it's just the wrong format..)
> - remove the SCSISTAT_* defines, and use the generic ones from
>   <scsi/scsi.h> instead.  Dito for various other SAM defines.
> - the driver has just two files and should go directly into
>   drivers/scsi instead of a subdirectory 

