Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162315AbWKPXf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162315AbWKPXf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 18:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162320AbWKPXf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 18:35:59 -0500
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:45022 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1162315AbWKPXf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 18:35:58 -0500
Message-ID: <455CF5EA.8030303@trollprod.org>
Date: Fri, 17 Nov 2006 00:36:10 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061115)
MIME-Version: 1.0
To: "Lu, Yinghai" <yinghai.lu@amd.com>
CC: Linus Torvalds <torvalds@osdl.org>, Mws <mws@twisted-brains.org>,
       Jeff Garzik <jeff@garzik.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <5986589C150B2F49A46483AC44C7BCA4907208@ssvlexmb2.amd.com>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907208@ssvlexmb2.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lu, Yinghai wrote:
> Add pci_intx to diable intx could make MSI work with pci.
> 
> Olivier, Please test it attached patch with latest git ... I hardcode to
> make enable_msi=1.
> 
> YH
> 

The kernel boots only with pci=routeirq, no IRQ get disabled but the 
sound driver does not work.


http://olivn.trollprod.org/19-rc6/19-rc6-yinghai1-routeirq.dmesg
http://olivn.trollprod.org/19-rc6/19-rc6-yinghai1-routeirq.irq



In order to get reproductible result, I halt the system and remove the 
power cord for 30 seconds.But once, I just reboot and get that strange 
result

IRQ 22 is disabled but snd_hda_intel seems to get a MSI interrupt! (It 
cannot be reproduced)

http://olivn.trollprod.org/19-rc5-git7-patch1.dmesg

           CPU0       CPU1
   0:        614    1107801   IO-APIC-edge      timer
   1:          2        361   IO-APIC-edge      i8042
   6:          0          5   IO-APIC-edge      floppy
   8:          0          0   IO-APIC-edge      rtc
   9:          0          0   IO-APIC-fasteoi   acpi
  12:          0        163   IO-APIC-edge      i8042
  14:         10      11446   IO-APIC-edge      ide0
  16:          0          3   IO-APIC-fasteoi   libata, ohci1394
  17:          4          8   IO-APIC-fasteoi   bttv0
  20:          2         22   IO-APIC-fasteoi   ehci_hcd:usb2
  21:          0          4   IO-APIC-fasteoi   libata, ohci_hcd:usb1
  22:         15      99985   IO-APIC-fasteoi   libata
  23:         30       7639   IO-APIC-fasteoi   libata
307:        156     443303   PCI-MSI-edge      eth1
308:          0        311   PCI-MSI-edge      eth1
309:          0        401   PCI-MSI-edge      eth1
310:        156     443333   PCI-MSI-edge      eth0
311:          0          0   PCI-MSI-edge      eth0
312:          0          0   PCI-MSI-edge      eth0
313:          0          1   PCI-MSI-edge      HDA Intel
NMI:         65         47
LOC:    1108404    1108429
ERR:          0




Olivier

