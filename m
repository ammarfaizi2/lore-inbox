Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVGKF1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVGKF1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 01:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVGKF1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 01:27:30 -0400
Received: from li4-142.members.linode.com ([66.220.1.142]:36361 "EHLO
	li4-142.members.linode.com") by vger.kernel.org with ESMTP
	id S262243AbVGKF13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 01:27:29 -0400
Date: Mon, 11 Jul 2005 01:26:16 -0400
From: Michael B Allen <mba2000@ioplex.com>
To: linux-kernel@vger.kernel.org
Subject: Prism 2.5 MiniPCI Wireless Unstable
Message-Id: <20050711012616.4796a4a0.mba2000@ioplex.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My wireless is a little fragile. I have a Thinkpad T30 with a MiniPCI card:

02:02.0 Network controller: Intersil Corporation Prism 2.5 Wavelan chipset (rev 01)
        Subsystem: Intel Corp. Wireless 802.11b MiniPCI Adapter
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at f8000000 (32-bit, prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

If I run rsync it's guaranteed to get the kernel in a bad way. CPU goes to 100% doing what looks like an endless loop error handling. If I unload and load the orinoco, orinoco_pci, and hermes modules it restores normal behavior. But anything can trigger the problem. I just tried to print to a network printer and it triggered the problem. The first of many log messages follows:

Jul 11 00:03:07 quark kernel: eth1: Error -110 transmitting packet
Jul 11 00:03:07 quark kernel: eth1: Error -110 writing Tx descriptor to BAP
Jul 11 00:03:08 quark last message repeated 99 times
Jul 11 00:03:08 quark kernel: hermes @ MEM 0xe0856000: Timeout waiting for command completion.
Jul 11 00:03:08 quark kernel: eth1: Error -110 writing Tx descriptor to BAP
Jul 11 00:03:09 quark last message repeated 610 times
Jul 11 00:03:09 quark kernel: hermes @ MEM 0xe0856000: Error -16 issuing command.
Jul 11 00:03:09 quark kernel: eth1: Error -5 writing packet to BAP
Jul 11 00:03:09 quark kernel: hermes @ MEM 0xe0856000: Error -16 issuing command.
Jul 11 00:03:09 quark kernel: eth1: Error -16 transmitting packet
Jul 11 00:03:09 quark kernel: hermes @ MEM 0xe0856000: Error -16 issuing command.
Jul 11 00:03:09 quark kernel: eth1: Error -16 transmitting packet
Jul 11 00:03:09 quark kernel: hermes @ MEM 0xe0856000: Error -16 issuing command.
Jul 11 00:03:09 quark kernel: eth1: Error -16 transmitting packet

I tried changing irqs around a while back but I can't see any difference. Is there anything I can do about this? I had problems with 2.4 using the hostap driver too but it was stable enough to run my rsync backup. I'm systems programmer and I'm willing to patch & debug.

Thanks,
Mike

Linux quark.foo.net 2.6.11-1.35_FC3 #1 Mon Jun 13 00:52:08 EDT 2005 i686 i686 i386 GNU/Linux

autofs4                26181  1 
pcmcia                 26465  4 
dm_mod                 59221  0 
video                  15813  0 
ibm_acpi               15997  0 
button                  6609  0 
battery                 9285  0 
ac                      4805  0 
md5                     4161  1 
ipv6                  259201  8 
yenta_socket           21065  2 
rsrc_nonstatic         10433  1 yenta_socket
pcmcia_core            47993  3 pcmcia,yenta_socket,rsrc_nonstatic
uhci_hcd               33497  0 
hw_random               6101  0 
i2c_i801                8653  0 
i2c_core               21953  1 i2c_i801
snd_intel8x0m          18565  0 
snd_intel8x0           34049  0 
snd_ac97_codec         71097  2 snd_intel8x0m,snd_intel8x0
snd_pcm_oss            51953  0 
snd_mixer_oss          18241  1 snd_pcm_oss
snd_pcm                99657  4 snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              33093  1 snd_pcm
snd                    56741  7 snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10785  1 snd
snd_page_alloc          9669  3 snd_intel8x0m,snd_intel8x0,snd_pcm
orinoco_pci             8269  0 
orinoco                53837  1 orinoco_pci
hermes                  8513  2 orinoco_pci,orinoco
e100                   46401  0 
mii                     4929  1 e100
floppy                 64753  0 
ext3                  131145  1 
jbd                    82905  1 ext3
