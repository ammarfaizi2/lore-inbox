Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129747AbRA3O7Z>; Tue, 30 Jan 2001 09:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRA3O7P>; Tue, 30 Jan 2001 09:59:15 -0500
Received: from web11005.mail.yahoo.com ([216.136.131.55]:30730 "HELO
	web11005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130966AbRA3O66>; Tue, 30 Jan 2001 09:58:58 -0500
Message-ID: <20010130145857.53462.qmail@web11005.mail.yahoo.com>
Date: Tue, 30 Jan 2001 06:58:57 -0800 (PST)
From: rakesh rakesh <majordomo_linux@yahoo.com>
Subject: Re: [PATCH] drivers/scsi/BusLogic.c: No resource probing before pci_enable_device (241p11)
To: Rasmus Andersen <rasmus@jaquet.dk>, lnz@dandelion.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi List,
What I can make out from the below statement is that
its better to first enable the device and then
allocate the resources for that.Since from the hot
pluggable point of view if the device is not enabled
,then it does not mean anything to allocate the
resources for it.It would be simply wasting the
resources which serves no good purpose.
If my understanding is incorrect or if there are few
more important  issues attached from the Hot-pluggable
point of view,then please let me know.

Thanks

--- Rasmus Andersen <rasmus@jaquet.dk> wrote:
> Hi.
> 
> The following patch makes drivers/scsi/BusLogic.c
> wait with probing
> pdev->irq and pdev->resource[] until we call
> pci_enable_device. This
> is recommended due to hot-plug considerations
> (according to Jeff Garzik).
> 
> It applies against ac12 and 241p11.
> 
> Comments?
> 
> 
> --- linux-ac12-clean/drivers/scsi/BusLogic.c	Sat Jan
> 27 21:16:24 2001
> +++ linux-ac12/drivers/scsi/BusLogic.c	Sat Jan 27
> 21:32:33 2001
> @@ -770,15 +770,19 @@
>        BusLogic_ModifyIOAddressRequest_T
> ModifyIOAddressRequest;
>        unsigned char Bus = PCI_Device->bus->number;
>        unsigned char Device = PCI_Device->devfn >>
> 3;
> -      unsigned int IRQ_Channel = PCI_Device->irq;
> -      unsigned long BaseAddress0 =
> pci_resource_start(PCI_Device, 0);
> -      unsigned long BaseAddress1 =
> pci_resource_start(PCI_Device, 1);
> -      BusLogic_IO_Address_T IO_Address =
> BaseAddress0;
> -      BusLogic_PCI_Address_T PCI_Address =
> BaseAddress1;
> +      unsigned int IRQ_Channel;
> +      unsigned long BaseAddress0;
> +      unsigned long BaseAddress1;
> +      BusLogic_IO_Address_T IO_Address;
> +      BusLogic_PCI_Address_T PCI_Address;
>  
>        if (pci_enable_device(PCI_Device))
>        	continue;
>        
> +      IRQ_Channel = PCI_Device->irq;
> +      IO_Address  = BaseAddress0 =
> pci_resource_start(PCI_Device, 0);
> +      PCI_Address = BaseAddress1 =
> pci_resource_start(PCI_Device, 1);
> +
>        if (pci_resource_flags(PCI_Device, 0) &
> IORESOURCE_MEM)
>  	{
>  	  BusLogic_Error("BusLogic: Base Address0 0x%X not
> I/O for "
> 
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)
> 
> "The obvious mathematical breakthrough would be
> development of an easy way
> to factor large prime numbers." 
>   -- Bill Gates, The Road Ahead, Viking Penguin
> (1995)
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org

--- Rasmus Andersen <rasmus@jaquet.dk> wrote:


__________________________________________________
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
