Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132641AbQKWHas>; Thu, 23 Nov 2000 02:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132649AbQKWHaj>; Thu, 23 Nov 2000 02:30:39 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:52750 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S132641AbQKWHa0>;
        Thu, 23 Nov 2000 02:30:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): pci_device_id tables for drivers/scsi in 2.4.0-test11 
In-Reply-To: Your message of "Thu, 23 Nov 2000 00:02:07 MDT."
             <20001123000207.O2918@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 18:00:19 +1100
Message-ID: <882.974962819@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Adam J. Richter]
> +static struct pci_device_id atp870u_pci_tbl[] __initdata = {
> +{vendor: 0x1191, device: 0x8002, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},
> +{vendor: 0x1191, device: 0x8010, subvendor: PCI_ANY_ID, subdevice: PCI_ANY_ID},

It would make it easier to read and safer to type if you used a macro
to generate the fields.

#define PCITBL(v,d,sv,sd) \
 { PCI_VENDOR_ID_##v, PCI_DEVICE_ID_##d, \
   PCI_VENDOR_ID_##sv, PCI_DEVICE_ID_##sd }

#define PCITBL_END {0,0,0,0}

static struct pci_device_id foo_pci_tbl[] __initdata = {
  PCITBL(INTEL, INTEL_82437VX, ANY, ANY),
  PCITBL_END
}

Shorter is easier to read.  Using a prefix on the fields makes it much
harder for somebody to accidentally swap device and vendor codes.  If
they swap the parameters and type
  PCITBL(INTEL_82437VX, INTEL, ANY, ANY),
by mistake then they get compile errors, PCI_VENDOR_ID_INTEL_82437VX
and PCI_DEVICE_ID_INTEL are undefined.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
