Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbTGVBvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270775AbTGVBvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:51:14 -0400
Received: from linux8.bluehill.com ([128.121.244.233]:6595 "EHLO
	mach8.bluehill.com") by vger.kernel.org with ESMTP id S267491AbTGVBuk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:50:40 -0400
Message-ID: <3F1C9BF8.1080008@inmotiontechnology.com>
Date: Mon, 21 Jul 2003 19:05:44 -0700
From: Larry LeBlanc <leblanc@inmotiontechnology.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI IRQ question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having some trouble with PCI IRQ's and I was hoping someone here 
could help. I'm running linux 2.4.20 on a Kontron Envoy mobile data 
server - basically a ruggedized PC meant for installation in the trunk 
of a car. To make a long story short, power management functions 
(shutdown -h/-r, UPS power state change notifications) cause the unit to 
hang. Extensive troubleshooting found that the problem was related to 
the pcmcia modules - if they aren't loaded, everything works fine, but 
as soon as they are loaded (even if subsequently unloaded) they cause 
the system to hang on any power management event. Unfortunately my 
application requires PCMCIA cards.

My first thought was that I had an IRQ conflict problem, and sure enough 
I notice from lspci -vv that my 2 CardBus slots are sharing IRQ's 9 and 
15 with the VGA controller (9) and multimedia audio controller (15). I 
have no idea whether or not this is the real cause of the problem, but I 
figured it would be a good idea to remove this apparent conflict. I have 
scoured the web and found numerous suggestions for diverting the CardBus 
controller to different IRQs:
  - excluding 9 and 15 in /etc/pcmcia/config.opts
  - defining an irq_list in PCIC_OPTS in /etc/sysconfig/pcmcia (where RH 
gets its initialization from)
  - masking out 9 and 15 by specifying pci=irqmask=0x7dff on the kernel 
boot line.

None of these steps has had any effect - I always get "Yenta IRQ list 
0c98 , PCI irq9/15" on initialization. How do I change these IRQ's? Is 
Linux reading these from the CardBus controller or is there some other 
configuration file I haven't found? Note: the manufacturer only supports 
Windows on this platform and says that by default the CardBus slots 
should use IRQs 10 and 11. I've also found references to "IRQ steering" 
in Windows, which apparently reroutes conflicting IRQs to clear 
locations. Perhaps when this box runs under Windows the IRQs get steered 
to 10 and 11?

If anyone can provide any insight into this, I would appreciate it 
greatly. Let me know what/if any details you need - I am by no means an 
expert in this area and didn't want to post reams of irrelevant 
information, but if there is something I'm missing let me know and I'll 
get it...

Thanks,

Larry



