Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264657AbSKSIiq>; Tue, 19 Nov 2002 03:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSKSIiq>; Tue, 19 Nov 2002 03:38:46 -0500
Received: from 66-74-193-248.san.rr.com ([66.74.193.248]:56960 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S264657AbSKSIip>;
	Tue, 19 Nov 2002 03:38:45 -0500
Date: Tue, 19 Nov 2002 00:45:47 -0800 (PST)
From: rmack@mackman.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BUG] Orinoco Lock Up
Message-ID: <Pine.LNX.4.44.0211190032190.3885-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was sleapilly typing away from my laptop when my wireless LAN connection
hung.  The other end, a dual P3 system using a generic ISA->PCMCIA adapter
and an Orinoco Silver v6.06 card had gone crazy.  I don't know if the
whole system was locked up or not but removing the Orinoco card and
re-inserting fixed the wireless LAN.

I pulled the card after 75 seconds, so perhaps some sort of watchdog 
might have jumped in and reset it later.  Still though, 60,000 messages in 
75 seconds seems a little overkill.  I can't imagine the rest of the 
machine would have remained very responsive.

Lemme know if you need any more info.

Thanks, Ryan

/var/log/messages:
Nov 19 00:02:58 mackman kernel: eth1: Error -110 writing Tx descriptor to BAP
Nov 19 00:03:29 mackman last message repeated 24103 times
Nov 19 00:04:15 mackman last message repeated 36795 times
Nov 19 00:04:15 mackman kernel: eth1: Error -16 shutting down Hermes chipset

/proc/version:
Linux version 2.4.19 (rmack@mackman.net) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #3 SMP Mon Nov 18 14:53:21 PST 2002

lsmod:
Module                  Size  Used by    Not tainted
orinoco_cs              5928   1
orinoco                38488   0 [orinoco_cs]
hermes                  8356   0 [orinoco_cs orinoco]
ds                      8840   2 [orinoco_cs]
i82365                 18244   2
isa-pnp                41380   0 [i82365]
pcmcia_core            59840   0 [orinoco_cs ds i82365]
floppy                 57468   0 (autoclean)
3c59x                  30416   1
af_packet              16936   1 (autoclean)
ipt_LOG                 4248   1 (autoclean)
ipt_state               1048   1 (autoclean)
ipt_MASQUERADE          2296   1 (autoclean)
iptable_nat            20856   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           23228   2 (autoclean) [ipt_state ipt_MASQUERADE iptable_nat]
iptable_filter          2412   1 (autoclean)
ip_tables              15608   7 [ipt_LOG ipt_state ipt_MASQUERADE iptable_nat iptable_filter]
raid1                  16492   1 (autoclean)
ide-disk               14048   2 (autoclean)
ide-probe-mod          11264   0 (autoclean)
ide-mod               103796   2 (autoclean) [ide-disk ide-probe-mod]
md                     68128   2 [raid1]
mousedev                5688   1
keybdev                 2944   0 (unused)
hid                    16264   0 (unused)
input                   6176   0 [mousedev keybdev hid]
uhci                   30672   0 (unused)
usbcore                79520   1 [hid uhci]
rtc                     9180   0 (autoclean)

/proc/isapnp:
Card 1 'VIA3018:VIA PCMCIA CARD' PnP version 1.0
  Logical device 0 'PNP0e00:Unknown'
    Supported registers 0x2
    Compatible device PNP0e00
    Device is active
    Active port 0x3e0
    Resources 0
      Priority preferred
      Port 0x3e0-0x3e3, align 0x1, size 0x2, 16-bit address decoding


