Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbRDXWCz>; Tue, 24 Apr 2001 18:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132468AbRDXWCq>; Tue, 24 Apr 2001 18:02:46 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12768 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S132313AbRDXWC3>; Tue, 24 Apr 2001 18:02:29 -0400
Date: Tue, 24 Apr 2001 15:59:50 -0600
Message-Id: <200104242159.f3OLxoB07000@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matt_Domsch@Dell.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, dougg@torque.net,
        jgarzik@mandrakesoft.com
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
In-Reply-To: <CDF99E351003D311A8B0009027457F140810E286@ausxmrr501.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch writes:
> Thanks everyone for your input again.  I've made the changes suggested, and
> would appreciate this being applied to Linus' and Alan's trees.  This is
> necessary for solving the "what disk does BIOS think is my boot disk"
> problem on IA-64, and I hope to extend it to IA-32 when BIOSs permit.
> 
> Jeff Garzik recommended the IOCTL return pci_dev::slot_name, so now it does,
> and this simplifies the ioctl greatly.
> Doug Gilbert recommended wrapping things in #ifdef's, so I created a new
> CONFIG_SCSI_PCI_INFO define.

As I said to Matt privately, I think adding this kind of ioctl is
ugly. We have enough ioctl's as it is. All Matt is trying to do is to
access drives via location, so exposing location-based device nodes
via devfs is IMNSHO cleaner.

The plan I have (which I hope to get started on soon, now that I'm
back from travels), is to change /dev/scsi/host# from a directory into
a symbolic link to a directory called: /dev/bus/pci0/slot1/function0.
Thus, to access a partition via location, one would use the path:
/dev/bus/pci0/slot1/function0/bus0/target1/lun2/part3.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
