Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161431AbWKOUxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161431AbWKOUxV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030994AbWKOUxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:53:21 -0500
Received: from outmx023.isp.belgacom.be ([195.238.4.204]:61323 "EHLO
	outmx023.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1030995AbWKOUxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 15:53:20 -0500
Message-ID: <455B7E3F.6040403@trollprod.org>
Date: Wed, 15 Nov 2006 21:53:19 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061115)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mws <mws@twisted-brains.org>, Jeff Garzik <jeff@garzik.org>,
       Krzysztof Halasa <khc@pm.waw.pl>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, tiwai@suse.de, yinghai.lu@amd.com
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <455B688F.8070007@garzik.org> <Pine.LNX.4.64.0611151127560.3349@woody.osdl.org> <200611152059.53845.mws@twisted-brains.org> <Pine.LNX.4.64.0611151210380.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611151210380.3349@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 15 Nov 2006, Mws wrote:
>> after some small discussions on alsa-user ml i recognised this
>> thread today. 
>> i thought my problem could also exist on this msi stuff.
>> i disabled msi in kernel config, reboot, and, after starting x & kde
>> i got immediately a freeze.
>> last and maybe important last try has been to
>> enable msi support _but_ boot kernel with cmdline pci=nomsi
>> this finally did work out. i got a working sound environment again.

Usually, the shared IRQ is disabled but it has happened that the system 
boots without disabling the IRQ. In that case, the sound is distorted 
and the distortion increase when I use the device that shares the IRQ.
(see the boot messages: 
http://olivn.trollprod.org/irq_not_disabled_sound_distortion.dmesg )


I can boot the system with pci=nomsi without any problem.


Yinghai Lu who send me some patches to trace irq assignment
said:
"Then it is not caused by transition from MSI to IOAPIC.
Weird,
MSI is enabled, but chip still send int to ioapic.
YH"



Olivier

> 
> I expect that you have the exact same issue as Olivier: the "hang" is 
> probably because you started using the sound device (beeping on the 
> console is handled by the old built-in speaker, but in X a single beep 
> tends to be due to sound device drivers), and because of sound irq 
> misrouting you had some other device (like your harddisk) that got their 
> irq disabled due to the "nobody cared" issue.
> 
>> i find it a bit abnormal that the disabling msi in kernel config behaviour
>> is different from kernel cmdline pci=nomsi option.
> 
> Now, that does actually worry me. It _should_ have worked with CONFIG_MSI 
> disabled. I wonder if some of the MSI workarounds actually broke the HDA 
> driver subtly.
> 
> Anyway, it would be a good idea to test the current -git tree if you can, 
> both with CONFIG_MSI and without (and _without_ any "pci=nomsi" kernel 
> command line). It should hopefully work, exactly because the HDA driver 
> now shouldn't even try to do any MSI stuff by default.
> 
> Knock wood.
> 
> 		Linus


