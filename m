Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVCUGlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVCUGlM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 01:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVCUGlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 01:41:12 -0500
Received: from mailgate1.mysql.com ([213.115.162.47]:31150 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261585AbVCUGlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 01:41:01 -0500
Message-ID: <423E6C72.4050306@mysql.com>
Date: Mon, 21 Mar 2005 07:40:50 +0100
From: Jonas Oreland <jonas.oreland@mysql.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ron Gage <ron@rongage.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Major problem with PCMCIA/Yenta system
References: <200503201853.48201.ron@rongage.org>
In-Reply-To: <200503201853.48201.ron@rongage.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently had a similar problem, but with a netgear-wg511t
However, a kind gentleman called daniel.ritz@gmx.ch supplied with me a patch that
solved the problem.

Not sure if it will work with your card, but you can always try.

You should find it on this list, 
  thread topic is "yenta_socket "nobody cared - Disabling IRQ #4""

/Jonas


Ron Gage wrote:
> Greetings:
> 
> I have been trying to get a recently acquired Cardbus based USB 2.0 card 
> working under 2.6 for the past weekend.  It's not going well.
> 
> Everytime I plug the card into the computer, the entire PCMCIA system just 
> dies, taking my network connectivity with it.  I have to do a power off reset 
> to recover.
> 
> The cardbus card is based on the ALI USB chipset.  This shows up as both an 
> EHCI and an OHCI device under 2.6.11.5.  My laptop, an older HP Pavilion 
> N5150 has a UHCI based chipset:
> 
> 00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 
> 03)
> 00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 
> 03)
> 00:04.0 CardBus bridge: Texas Instruments PCI1420
> 00:04.1 CardBus bridge: Texas Instruments PCI1420
> 00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
> 00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
> 00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
> 00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
> 00:08.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
> 01:01.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 11)
> 02:00.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 
> (rev 41)
> 
> 
> My ethernet card is a generic cardbus device.
> 
> When I insert the new USB 2.0 card, the kernel reports that it's killing off 
> IRQ 11.  Here is the actual dump from dmesg:
> 
> Mar 20 18:38:13 port2 kernel: irq 11: nobody cared!
> Mar 20 18:38:13 port2 kernel:  [<c013089a>] __report_bad_irq+0x2a/0xa0
> Mar 20 18:38:13 port2 kernel:  [<c01303a0>] handle_IRQ_event+0x30/0x70
> Mar 20 18:38:13 port2 kernel:  [<c01309a0>] note_interrupt+0x70/0xb0
> Mar 20 18:38:13 port2 kernel:  [<c01304c1>] __do_IRQ+0xe1/0xf0
> Mar 20 18:38:13 port2 kernel:  [<c0104a69>] do_IRQ+0x19/0x30
> Mar 20 18:38:13 port2 kernel:  [<c0103182>] common_interrupt+0x1a/0x20
> Mar 20 18:38:13 port2 kernel:  [<c011b2be>] __do_softirq+0x2e/0xa0
> Mar 20 18:38:13 port2 kernel:  [<c011b356>] do_softirq+0x26/0x30
> Mar 20 18:38:13 port2 kernel:  [<c0104a6e>] do_IRQ+0x1e/0x30
> Mar 20 18:38:13 port2 kernel:  [<c0103182>] common_interrupt+0x1a/0x20
> Mar 20 18:38:13 port2 kernel:  [<c025e229>] acpi_processor_idle+0x238/0x288
> Mar 20 18:38:13 port2 kernel:  [<c0101030>] default_idle+0x0/0x30
> Mar 20 18:38:13 port2 kernel:  [<c01010ec>] cpu_idle+0x4c/0x60
> Mar 20 18:38:13 port2 kernel:  [<c04547ac>] start_kernel+0x13c/0x160
> Mar 20 18:38:13 port2 kernel:  [<c0454340>] unknown_bootoption+0x0/0x200
> Mar 20 18:38:13 port2 kernel: handlers:
> Mar 20 18:38:13 port2 kernel: [<e085a8e0>] (yenta_interrupt+0x0/0x40 
> [yenta_socket])
> Mar 20 18:38:13 port2 kernel: [<e085a8e0>] (yenta_interrupt+0x0/0x40 
> [yenta_socket])
> Mar 20 18:38:13 port2 kernel: [<c02baa70>] (tulip_interrupt+0x0/0x9c0)
> Mar 20 18:38:13 port2 kernel: Disabling IRQ #11
> Mar 20 18:38:14 port2 kernel: PCI: Enabling device 0000:06:00.0 (0000 -> 0002)
> Mar 20 18:38:14 port2 kernel: PCI: Enabling device 0000:06:00.3 (0000 -> 0002)
> Mar 20 18:38:16 port2 kernel: ohci_hcd 0000:06:00.0: Unlink after no-IRQ?  
> Controller is probably using the wrong IRQ.
> 
> Again, when the USB card in inserted, the entire PCMCIA system shuts down and 
> remains unusuable until powered off.
> 
> Kernel is stock 2.6.11.5.  I also tried with 2.6.11, 2.6.10, 2.6.9 and 2.6.7 - 
> same result.  Distribution is Slackware 9.1 - gcc is 3.2.3
> 
> HELP!!!
> 
> 


-- 
Jonas Oreland, Software Engineer
MySQL AB, www.mysql.com
