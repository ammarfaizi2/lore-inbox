Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbSIXCRd>; Mon, 23 Sep 2002 22:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbSIXCRd>; Mon, 23 Sep 2002 22:17:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47366 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261531AbSIXCRc>;
	Mon, 23 Sep 2002 22:17:32 -0400
Message-ID: <3D8FCC53.3070809@pobox.com>
Date: Mon, 23 Sep 2002 22:22:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Kessler <kessler@us.ibm.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAID device
 driver
References: <3D8FC5BC.51A8FCCF@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Kessler wrote:
> Please see [PATCH-RFC] README 1st note.
> 
> Also note that this patch includes pci_problem.h, as does the eepro100.c
> device driver patch included in the 'README 1st' note.
>  
> Summary of this patch...
>  
>  drivers/scsi/ips.c
>     Device Driver for the IBM ServeRAID controller, with use of new 
>     macros replacing prink() for error conditions.
>  
>  include/linux/scsi_problem.h
>   -  scsi_host_detail() macro providing common information of interest
>      for scsi-class devices.    
>   -  scsi_host_problem and scsi_host_introduce macros   
> 
>  include/linux/pci_problem.h
> 
>   -  pci_detail() macro providing common information on a per class
>      basis when problems are being reported for devices of that class. 
>   -  pci_problem and pci_introduce macros

Bloat, bloat, and more bloat.  This API is not scalable at all, if we 
have to add a new header and new foo_problem() macros for every little 
subsystem in the kernel.

If you actually want to standardize some diagnostic messages, it is a 
huge mistake [as your scsi driver example shows] to continue to use 
random text strings followed by a typed attribute list.  If you really 
wanted to standardize logging, why continue to allow driver authors to 
printk driver-specific text strings in lieu of a standard string that 
applies to the same situation in N drivers.

I do encourage the clean-up of drivers logging and can see the utility 
of it, but you are really using a sledgehammer to drive in a carpet nail 
here...

	Jeff



