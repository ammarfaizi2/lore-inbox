Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263437AbREXJ3f>; Thu, 24 May 2001 05:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263438AbREXJ30>; Thu, 24 May 2001 05:29:26 -0400
Received: from enst.enst.fr ([137.194.2.16]:20867 "HELO enst.enst.fr")
	by vger.kernel.org with SMTP id <S263437AbREXJ3E>;
	Thu, 24 May 2001 05:29:04 -0400
Date: Thu, 24 May 2001 11:28:20 +0200
From: Fabrice Gautier <gautier@email.enst.fr>
To: linux-kernel@vger.kernel.org
Subject: PCI: Direct Access and STPC
Message-Id: <20010524112805.0A12.GAUTIER@email.enst.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that when building a kernel with CONFIG_PCI_DIRECT and not
CONFIG_PCI_BIOS, the kernel doesn't detect any PCI bus when runing on a
STPC embeded CPU.

The STPC include a PCI chipset but the configuration methods usednin the
kernel does not seems to match the STPC docs.

The STPC use 0xCF8 and 0xCFC registers to access PCI configuration space.
This seems to match the code of pci_conf1_read_config_byte but the
sanity_check fail pci_check_direct.

The fact is that the north bridge in the STPC have a class code of 0, 
so is not detected as a host bridge. For my own tests i've removed the 
sanity check and so i get the following result in /proc/pci:

PCI devices found:
  Bus  0, device  11, function  0:
    Non-VGA unclassified device: PCI device 100e:0564 (Weitek) (rev 0).
  Bus  0, device  12, function  0:
    ISA bridge: PCI device 100e:55cc (Weitek) (rev 0).
  Bus  0, device  12, function  1:
    IDE interface: PCI device 100e:55cc (Weitek) (rev 0).
      I/O at 0xfc00 [0xfc07].
      I/O at 0xfc20 [0xfc23].
      I/O at 0xfc40 [0xfc47].
      I/O at 0xfc60 [0xfc63].
      I/O at 0xfc80 [0xfc8f].

I've seen some fixup functions that seems to correct some IDs. I guess
in my case I would need one to correct the device CLASS for the north
bridge. Is that correct ?

Thanks. 

-- 
Fabrice Gautier <gautier@email.enstfr>

