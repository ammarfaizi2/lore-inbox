Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272943AbRIMJWu>; Thu, 13 Sep 2001 05:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272946AbRIMJWn>; Thu, 13 Sep 2001 05:22:43 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:9965 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S272943AbRIMJW3>; Thu, 13 Sep 2001 05:22:29 -0400
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2731B@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Sebastian Heidl'" <heidl@zib.de>, linux-kernel@vger.kernel.org
Subject: RE: find struct pci_dev from struct net_device
Date: Thu, 13 Sep 2001 12:22:47 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take the value of dev->base_addr, mask it's lowest 4 bits, do a scan of all
PCI net devices and in each PCI device try to match to each of the 6 address
regs:

struct pci_dev* find_pci_device_by_baseddr(unsigned long base_addr)
{
      struct pci_dev *pcid = NULL;
      unsigned long reg;
      int i;

      base_addr &= ~(0x0000000F);

      while ((pcid = pci_find_class(PCI_CLASS_NETWORK_ETHERNET << 8, pcid)))
{
            for (i=0; i<6; i++) {
                  reg = pci_resource_start(pcid,i);
                  reg &= ~(0x0000000F);
                  if (reg == base_addr) {
                        return pcid;
                  }
            }
      }

      return NULL;
}
-----Original Message-----
From: Sebastian Heidl [mailto:heidl@zib.de]
Sent: Wednesday, September 12, 2001 3:53 PM
To: linux-kernel@vger.kernel.org
Subject: find struct pci_dev from struct net_device



Hi,

What's the easiest way to find a corresponding struct pci_dev from a
struct net_device ?  Especially, if the driver does not set
pci_dev.driver_data to it's net_device struct (such as the acenic
driver) ?

thanks,
_sh_

-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
