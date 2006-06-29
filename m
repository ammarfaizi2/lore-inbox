Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWF2P40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWF2P40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWF2P40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:56:26 -0400
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:61712 "EHLO
	smtp-vbr13.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750793AbWF2P4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:56:25 -0400
Message-ID: <44A3F820.30909@xs4all.nl>
Date: Thu, 29 Jun 2006 17:56:16 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Sergey Vlasov <vsu@altlinux.ru>, Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.17 on VIA SP8000 sata: via_sata timeout (cmd 0xef) (retry)
 FIXED!!
References: <44A2BF26.8090608@xs4all.nl> <20060629134141.221c59b3.vsu@altlinux.ru>
In-Reply-To: <20060629134141.221c59b3.vsu@altlinux.ru>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> On Wed, 28 Jun 2006 19:40:54 +0200 Udo van den Heuvel wrote:
> 
>> While 2.6.16.2 runs quite OK on my VIA SP8000 Epia system, 2.6.17 gives
>> (with the same config where possible) a sata problem on bootup, it gives
>> a via_sata timeout(cmd 0xef). (the letters were small to make the stuff
>> not scroll off the TV)
>> Immediately rebooting into 2.6.16.2 gives a nice clean bootup.
> 
> For some reason I suspect that VIA IRQ quirk again...
> 
> Can you try to revert these patches from 2.6.17:
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=a7b862f663d81858531dfccc0537bc9d8a2a4121
> 
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=75cf7456dd87335f574dcd53c4ae616a2ad71a11

I undid both patches manually and reinstated
DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);.
This made 2.6.17 boot again. Thanks VERY much for the tip!

My PCI stuff, if that is useful:

[root@recorder pci]# lspci
00:00.0 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.1 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.2 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.3 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.4 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:00.7 Host bridge: VIA Technologies, Inc. CN400/PM880 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80)
00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81)
00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
(rev 78)
00:14.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
01:00.0 VGA compatible controller: VIA Technologies, Inc. S3 Unichrome
Pro VGA Adapter (rev 02)
[root@recorder pci]# lspci -n
00:00.0 0600: 1106:0259
00:00.1 0600: 1106:1259
00:00.2 0600: 1106:2259
00:00.3 0600: 1106:3259
00:00.4 0600: 1106:4259
00:00.7 0600: 1106:7259
00:01.0 0604: 1106:b198
00:0d.0 0c00: 1106:3044 (rev 80)
00:0f.0 0101: 1106:3149 (rev 80)
00:0f.1 0101: 1106:0571 (rev 06)
00:10.0 0c03: 1106:3038 (rev 81)
00:10.1 0c03: 1106:3038 (rev 81)
00:10.2 0c03: 1106:3038 (rev 81)
00:10.3 0c03: 1106:3038 (rev 81)
00:10.4 0c03: 1106:3104 (rev 86)
00:11.0 0601: 1106:3227
00:11.5 0401: 1106:3059 (rev 60)
00:12.0 0200: 1106:3065 (rev 78)
00:14.0 0480: 1131:7146 (rev 01)
01:00.0 0300: 1106:3118 (rev 02)



