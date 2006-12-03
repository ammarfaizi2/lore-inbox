Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760095AbWLCU5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760095AbWLCU5B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 15:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760096AbWLCU5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 15:57:01 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:55997 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1760095AbWLCU5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 15:57:00 -0500
Message-ID: <45733A16.5010908@ccr.jussieu.fr>
Date: Sun, 03 Dec 2006 21:56:54 +0100
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
Organization: Universite Pierre & Marie Curie - Paris 6
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Bad PCI function mask in atiixp driver (was: Re: Linux 2.6.19)
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 23:06:57 -0500 Chuck Ebbert wrote:
>
>> In-Reply-To: <4571D9FE.2050107@xxxxxxxxx>
>>
>> On Sat, 02 Dec 2006 20:54:38 +0100, Matthijs wrote:
>>
>> > make modules gives me these warnings in modpost and then errors out:
>> > WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
>>
>> Message is from scripts/file2alias.c::do_pci_entry():
>>
>> if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
>> || (subclass_mask != 0 && subclass_mask != 0xFF)
>> || (interface_mask != 0 && interface_mask != 0xFF)) {
>> warn("Can't handle masks in %s:%04X\n",
>> filename, id->class_mask);
>> return 0;
>> }
>>
>> and it is complaining about this recent addition to atiixp.c:
>>
>> @@ -348,6 +368,7 @@ static struct pci_device_id atiixp_pci_t
>> { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
>> { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
>> { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
>> + { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID,
PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},
>> { 0, },
>> };
>> MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
>> --
>
>http://lkml.org/lkml/2006/11/01/199
>
>However, I'm still dubious.
>
>---
>~Randy

I made the same observation here when installing 2.6.19 :

root@bernard linux]# make modules
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  Building modules, stage 2.
  MODPOST 573 modules
WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
[root@bernard linux]#

Hardware is quite oldfashioned.
Is there any relashionship ?

00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host
bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP
bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:0d.0 Mass storage controller: Promise Technology, Inc. PDC20262
(FastTrak66/Ultra66) (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)

Bernard.
