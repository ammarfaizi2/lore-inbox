Return-Path: <linux-kernel-owner+w=401wt.eu-S1751363AbXAUTRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXAUTRz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbXAUTRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:17:55 -0500
Received: from [85.204.20.254] ([85.204.20.254]:55713 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751363AbXAUTRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:17:54 -0500
Subject: [BUG] eth0 appers many times in /proc/interrupts after resume
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: linux-kernel@vger.kernel.org
Cc: nigel@suspend2.net
In-Reply-To: <1168463852.3205.1.camel@nigel.suspend2.net>
References: <1167478664.8521.2.camel@localhost>
	 <1167479650.3337.18.camel@nigel.suspend2.net>
	 <1167480259.8855.3.camel@localhost>
	 <1167514357.2566.0.camel@nigel.suspend2.net>
	 <1167515552.30176.4.camel@localhost>
	 <1167517817.2566.13.camel@nigel.suspend2.net>
	 <1167518608.7177.0.camel@localhost>
	 <1167520557.2566.23.camel@nigel.suspend2.net>
	 <1167571281.7175.1.camel@localhost>
	 <1167599458.2662.8.camel@nigel.suspend2.net>
	 <1167605481.12328.0.camel@localhost>
	 <1167607994.2662.39.camel@nigel.suspend2.net>
	 <1167644970.7142.6.camel@localhost>
	 <1168317278.6948.9.camel@nigel.suspend2.net>
	 <1168448689.7430.1.camel@localhost>
	 <1168463852.3205.1.camel@nigel.suspend2.net>
Content-Type: text/plain
Organization: I-NEO
Date: Sun, 21 Jan 2007 21:17:41 +0200
Message-Id: <1169407062.1932.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It's the 10th resume and in /proc/interrupts eth0 appers 10 times.

ierdnac ~ # cat /proc/interrupts
           CPU0       CPU1
  0:   19690962      21390   IO-APIC-edge      timer
  1:      34666          0   IO-APIC-edge      i8042
  8:         12          0   IO-APIC-edge      rtc
  9:     189109          0   IO-APIC-fasteoi   acpi
 12:    2467502      62285   IO-APIC-edge      i8042
 14:         40          0   IO-APIC-edge      ide0
 17:    1156971      14168   IO-APIC-fasteoi   uhci_hcd:usb5,
i915@pci:0000:00:02.0
 18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
 19:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
 20:          1      26290   IO-APIC-fasteoi   ehci_hcd:usb1,
uhci_hcd:usb2
 21:     408192          0   IO-APIC-fasteoi   HDA Intel
 22:     249414       2543   IO-APIC-fasteoi   ohci1394, eth0, eth0,
eth0, eth0, eth0, eth0, eth0, eth0, eth0, eth0
223:     220668          0   PCI-MSI-edge      libata
NMI:          0          0
LOC:   19338002   19135738
ERR:          0
MIS:          0


ierdnac ~ # lsmod
Module                  Size  Used by
snd_seq                47120  0
snd_seq_device          6860  1 snd_seq
snd_hda_intel          16344  4
snd_hda_codec         157568  1 snd_hda_intel
snd_pcm                68100  3 snd_hda_intel,snd_hda_codec
snd_timer              18884  3 snd_seq,snd_pcm
snd                    38776  12
snd_seq,snd_seq_device,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
snd_page_alloc          7880  2 snd_hda_intel,snd_pcm
usb_storage            33156  0
ohci1394               32176  0
ieee1394               82964  1 ohci1394
e100                   31368  0
uhci_hcd               21516  0
ehci_hcd               27596  0
usbcore               100948  3 usb_storage,uhci_hcd,ehci_hcd


from dmesg:
Restarting tasks ... done.
Suspend2 debugging info:
- Suspend core   : 2.2.9.1
- Kernel Version : 2.6.20-rc4
- Compiler vers. : 4.1
- Attempt number : 10
- Parameters     : 0 81936 0 1 0 5
- Overall expected compression percentage: 0.
- Compressor is 'lzf'.
  Compressed 525217792 bytes into 449285477 (14 percent compression).
- SwapAllocator active.
  Swap available for image: 250982 pages.
- I/O speed: Write 43 MB/s, Read 44 MB/s.
- Extra pages    : -99 used/500.
Enabling non-boot CPUs ...
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c04bd000 soft=c04b5000

suspend2 maintainer:
"That is interesting! Unfortunately, I don't touch anything in that area.
Could I get you to send the message to the Linux kernel mailing list?

Regards,

Nigel"

ierdnac ~ # uname -a
Linux ierdnac 2.6.20-rc4 #0 SMP PREEMPT Wed Jan 10 18:34:14 EET 2007 i686 Genuine Intel(R) CPU           T2050  @ 1.60GHz GenuineIntel GNU/Linux




