Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWBXCgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWBXCgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWBXCgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:36:37 -0500
Received: from 220-130-178-142.HINET-IP.hinet.net ([220.130.178.142]:22749
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751813AbWBXCgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:36:36 -0500
Message-ID: <005901c638eb$2811c100$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "\"Arjan van de Ven\"" <arjan@infradead.org>,
       "\"\"Christoph Hellwig\"\"" <hch@infradead.org>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <billion.wu@areca.com.tw>, <akpm@osdl.org>, <oliver@neukum.org>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com> <20060220182045.GA1634@infradead.org> <001401c63779$12e49aa0$b100a8c0@erich2003> <20060222145733.GC16269@infradead.org> <00dc01c63842$381f9a30$b100a8c0@erich2003> <1140683157.2972.6.camel@laptopd505.fenrus.org> <001901c6385e$9aee7d40$b100a8c0@erich2003> <1140695990.19361.8.camel@localhost.localdomain>
Subject: Re: Areca RAID driver remaining items?
Date: Fri, 24 Feb 2006 10:36:44 +0800
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
X-OriginalArrivalTime: 24 Feb 2006 02:32:33.0265 (UTC) FILETIME=[90FD2610:01C638EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan Cox,

This is good idea to make black list to prevent system hang up with MSI 
function.
But arcmsr need  to come up against none specific mainboards.
The case at my lab have same chipset but different maker.

Best Regards
Erich Chen

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "erich" <erich@areca.com.tw>
Cc: "Arjan van de Ven" <arjan@infradead.org>; ""Christoph Hellwig"" 
<hch@infradead.org>; <linux-scsi@vger.kernel.org>; 
<linux-kernel@vger.kernel.org>; <billion.wu@areca.com.tw>; <akpm@osdl.org>; 
<oliver@neukum.org>
Sent: Thursday, February 23, 2006 7:59 PM
Subject: Re: Areca RAID driver remaining items?


> On Iau, 2006-02-23 at 17:50 +0800, erich wrote:
>> But unfortunately I found some mainboards will hang up if I always enable
>> this function in my lab.
>> To avoid this issue, I do an option for this case.
>>
>> But  Christoph Hellwig give me comment with it.
>
>
> Another thing you can also do for many of these cases is to use either
> the PCI or DMI interfaces to identify the problem board and
> automatically set the option as well.
>
> There are two ways to do this. One is
>
> struct pci_dev *bridge_dev = pci_get_slot(pdev->bus, PCI_DEVFN(0,0));
> if(bridge_dev) {
> if(bridge_dev->subsystem_vendor == 0xXXXX &&
> bridge_dev->subsystem_device == 0xXXXX)
> /* Match by svid/sdid for problem boards */
>
> The other is like this
>
> #include <linux/dmi.h>
>
> struct dmi_system_id problem_dmi_table[] = {
> {
> .ident = "Broken Board Name 1",
> .matches = {
> DMI_MATCH(DMI_SYS_VENDOR, "EvilCorp");
> DMI_MATCH(DMI_PRODUCTNAME, "Wombat 1000");
> }
> }
> {
> ditto per board
> },
> { } /* End of list mark
> };
>
>
> And then
>
> if (dmi_system_check(problem_dmi_table))
> disable_msi..
>
>
> The DMI code matches on the DMI strings in the ROM BIOS (the ones dumped
> by 'dmidecode')
>
>
> An example driver using this interface is drivers/char/sonypi.c which
> uses it to make sure it *is* only run on a sony laptop.
>
> Alan
> 

