Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319160AbSIKPud>; Wed, 11 Sep 2002 11:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319164AbSIKPud>; Wed, 11 Sep 2002 11:50:33 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:57543 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S319160AbSIKPua>; Wed, 11 Sep 2002 11:50:30 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 11 Sep 2002 17:37:51 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Mares <mj@ucw.cz>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ignore pci devices?
Message-ID: <20020911153750.GA8649@bytesex.org>
References: <20020910134708.GA7836@bytesex.org> <20020910163023.GA3862@ucw.cz> <1031683362.1537.104.camel@irongate.swansea.linux.org.uk> <20020910184128.GA5627@ucw.cz> <1031688912.31787.129.camel@irongate.swansea.linux.org.uk> <20020911122048.GA6863@bytesex.org> <1031747880.2726.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031747880.2726.40.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 01:38:00PM +0100, Alan Cox wrote:
> 
> Up until 2.4.20pre6 they are broken in the PCI core. IDE found that one
> out.
> 
> The reserve module is an interesting approach though. I had been
> pondering doing a rename module for some similar purposes but completely
> missed that one.
> 
> BTW we have pci_request_resource stuff that would shrink your module a
> fair bit

guess you mean pci_assign_resource()?  Played with that one, now my
/proc/iomem file looks *ahem* intresting.  Is this the bug mentioned
above?

  Gerd

==============================[ cut here ]==============================
Script started on Wed Sep 11 17:33:33 2002
bogomips kraxel ~/kernel/bttv-0.7.97/driver# lspci -vs a.0
00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: TERRATEC Electronic GmbH: Unknown device 1135
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at ce000000 (32-bit, prefetchable) [size=4K]
	Capabilities: <available only to root>

bogomips kraxel ~/kernel/bttv-0.7.97/driver# insmod ./pci-reserve.o ignore=0a.0
bogomips kraxel ~/kernel/bttv-0.7.97/driver# dmesg | tail
lp0: using parport0 (polling).
nfs warning: mount version older than kernel
/dev/vmnet: open called by PID 1250 (vmnet-netifup)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 1267 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
vmnet8: no IPv6 routers present
reserve: ignore="0a.0"  ->  using device 00:0a.0
reserve: probe device 00:0a.0
reserve: ... ressource at 40000000 size 1000 [ok]
bogomips kraxel ~/kernel/bttv-0.7.97/driver# cat /proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cb7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffbfff : System RAM
  00100000-001ecc3c : Kernel code
  001ecc3d-0024aa5f : Kernel data
3fffc000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
cb800000-cb8003ff : Philips Semiconductors SAA7134
cc000000-cd6fffff : PCI Bus #01
  cc000000-cc7fffff : Matrox Graphics, Inc. MGA G200 AGP
  cc800000-cc803fff : Matrox Graphics, Inc. MGA G200 AGP
    cc800000-cc803fff : matroxfb MMIO
cd800000-cd800fff : Brooktree Corporation Bt878 Audio Capture
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
cb800000-cb8003ff : Philips Semiconductors SAA7134
cc000000-cd6fffff : PCI Bus #01
  cc000000-cc7fffff : Matrox Graphics, Inc. MGA G200 AGP
  cc800000-cc803fff : Matrox Graphics, Inc. MGA G200 AGP
    cc800000-cc803fff : matroxfb MMIO
cd800000-cd800fff : Brooktree Corporation Bt878 Audio Capture
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
cb800000-cb8003ff : Philips Semiconductors SAA7134
cc000000-cd6fffff : PCI Bus #01
  cc000000-cc7fffff : Matrox Graphics, Inc. MGA G200 AGP
  cc800000-cc803fff : Matrox Graphics, Inc. MGA G200 AGP
    cc800000-cc803fff : matroxfb MMIO
cd800000-cd800fff : Brooktree Corporation Bt878 Audio Capture
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
cb800000-cb8003ff : Philips Semiconductors SAA7134
cc000000-cd6fffff : PCI Bus #01
  cc000000-cc7fffff : Matrox Graphics, Inc. MGA G200 AGP
  cc800000-cc803fff : Matrox Graphics, Inc. MGA G200 AGP
    cc800000-cc803fff : matroxfb MMIO
cd800000-cd800fff : Brooktree Corporation Bt878 Audio Capture
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
cb800000-cb8003ff : Philips Semiconductors SAA7134
cc000000-cd6fffff : PCI Bus #01
  cc000000-cc7fffff : Matrox Graphics, Inc. MGA G200 AGP
  cc800000-cc803fff : Matrox Graphics, Inc. MGA G200 AGP
    cc800000-cc803fff : matroxfb MMIO
cd800000-cd800fff : Brooktree Corporation Bt878 Audio Capture
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
cb800000-cb8003ff : Philips Semiconductors SAA7134
cc000000-cd6fffff : PCI Bus #01
  cc000000-cc7fffff : Matrox Graphics, Inc. MGA G200 AGP
  cc800000-cc803fff : Matrox Graphics, Inc. MGA G200 AGP
    cc800000-cc803fff : matroxfb MMIO
cd800000-cd800fff : Brooktree Corporation Bt878 Audio Capture
40000000-40000fff : Brooktree Corporation Bt878 Video Capture
ca000000-ca0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c810
ca800000-ca8003ff : Philips Semiconductors SAA7134 (#2)
cb000000-cb0000ff : Lite-On Communications Inc LNE100TX
  cb000000-cb0000ff : tulip
bogomips kraxel ~/kernel/bttv-0.7.97/driver# 

Script done on Wed Sep 11 17:34:56 2002
==============================[ cut here ]==============================
/*
 * pci-reserve.c -- reserve pci device resources to make device \
 *                  drivers *not* touch the card
 *
 * (c) 2002 Gerd Knorr <kraxel@bytesex.org>
 *
 */
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/kernel.h>

MODULE_DESCRIPTION("reserve pci device resources to make device drivers *not* touch the card");
MODULE_AUTHOR("Gerd Knorr");
MODULE_LICENSE("GPL");

static char *ignore = "none";
static int bus = -1, slot = -1,function = -1;
MODULE_PARM(ignore,"s");

#ifndef MODULE
static int __init setup(char *str) { ignore = str; return 0; }
__setup("pci-reserve.ignore=", setup);
#endif

static int __devinit probe(struct pci_dev *dev,
			   const struct pci_device_id *id)
{
	int i,rc;

	if (bus      != dev->bus->number     ||
	    slot     != PCI_SLOT(dev->devfn) ||
	    function != PCI_FUNC(dev->devfn))
		return -EBUSY;

	printk("reserve: probe device %02x:%02x.%x\n",
	       dev->bus->number,PCI_SLOT(dev->devfn),PCI_FUNC(dev->devfn));
	for (i = 0;; i++) {
		if (0 == pci_resource_start(dev,i))
			break;
		rc = pci_assign_resource(dev,i);
		printk("reserve: ... ressource at %lx size %lx [%s]\n",
		       pci_resource_start(dev,i),
		       pci_resource_len(dev,i),
		       rc ? "failed" : "ok");
		if (rc)
			return -EBUSY;
	}
	return 0;
}

static struct pci_device_id pci_tbl[] __devinitdata = {
        {
		.vendor    = PCI_ANY_ID,
		.device    = PCI_ANY_ID,
		.subvendor = PCI_ANY_ID,
		.subdevice = PCI_ANY_ID,
	},
	{ /* end of list */}
};

MODULE_DEVICE_TABLE(pci, pci_tbl);

static struct pci_driver pci_driver = {
        .name      = "reserve",
        .id_table  = pci_tbl,
        .probe     = probe,
};

static int parse(char *id, int *b, int *s, int *f)
{
	if (3 == sscanf(id,"%x:%x.%x",b,s,f)) {
		/* nothing */;
	} else if (2 == sscanf(id,"%x.%x",s,f)) {
		*b = 0;
	} else if (2 == sscanf(id,"%x:%x",b,s)) {
		*f= 0;
	} else if (1 == sscanf(id,"%x",s)) {
		*b = 0; *f= 0;
	} else {
		printk("reserve: can't parse \"%s\"\n",id);
		return -1;
	}
	return 0;
}

static int do_init(void)
{
	if (parse(ignore,&bus,&slot,&function) < 0)
		return -EINVAL;
	printk("reserve: ignore=\"%s\"  ->  using device %02x:%02x.%x\n",
	       ignore,bus,slot,function);
	return pci_module_init(&pci_driver);
}

static void do_fini(void)
{
	pci_unregister_driver(&pci_driver);
}

module_init(do_init);
module_exit(do_fini);

/*
 * Local variables:
 * c-basic-offset: 8
 * End:
 */
