Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132692AbQKWH4c>; Thu, 23 Nov 2000 02:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132690AbQKWH4W>; Thu, 23 Nov 2000 02:56:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4621 "EHLO havoc.gtf.org")
        by vger.kernel.org with ESMTP id <S132689AbQKWH4H>;
        Thu, 23 Nov 2000 02:56:07 -0500
Message-ID: <3A1CC66D.BC1EB6DB@mandrakesoft.com>
Date: Thu, 23 Nov 2000 02:25:33 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11
In-Reply-To: <882.974962819@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> [Adam J. Richter]
> > +static struct pci_device_id atp870u_pci_tbl[] __initdata = {
> > +{vendor: 0x1191, device: 0x8002, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> > +{vendor: 0x1191, device: 0x8010, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> 
> It would make it easier to read and safer to type if you used a macro
> to generate the fields.
> 
> #define PCITBL(v,d,sv,sd) \
>  { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##d, \
>    PCI_VENDOR_ID_##sv, PCI_DEVICE_ID_##sd }
> 
> #define PCITBL_END {0,0,0,0}
> 
> static struct pci_device_id foo_pci_tbl[] __initdata = {
>   PCITBL(INTEL, INTEL_82437VX, ANY, ANY),
>   PCITBL_END
> }

* your macro fails for the 'ANY' case, because the proper macro is
PCI_ANY_ID not PCI_{VENDOR,DEVICE}_ID_ANY.
* many drivers need to set the driver_data field

That said, the general idea presented above is quite good.  The PCITBL
macro will probably change on a per-driver basis... I don't think it
belongs in a common header.  For example, ethernet drivers might want to
have a macro that always checks for PCI-CLASS-ETHERNET under the hood,
while visibly looking like

PCITBL(INTEL, 82437VX, {a driver_data value}),
PCITBL(INTEL, 82987VX, {another driver_data value}),
PCITBL_END

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
