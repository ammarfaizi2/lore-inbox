Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267283AbSK3Smj>; Sat, 30 Nov 2002 13:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbSK3Smj>; Sat, 30 Nov 2002 13:42:39 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:46596 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S267283AbSK3Smi> convert rfc822-to-8bit;
	Sat, 30 Nov 2002 13:42:38 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.50] more uninitialized timers
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 30 Nov 2002 17:21:08 +0100
Message-ID: <87isyfjaff.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nov 30 17:06:31 gswi1164 kernel: Linux Kernel Card Services 3.1.22
Nov 30 17:06:31 gswi1164 kernel:   options:  [pci] [cardbus] [pm]
Nov 30 17:06:31 gswi1164 kernel: pci_link-0484 [19] acpi_pci_link_get_irq : Link disabled
Nov 30 17:06:31 gswi1164 kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
Nov 30 17:06:31 gswi1164 kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:02.0
Nov 30 17:06:31 gswi1164 kernel: ACPI: No IRQ known for interrupt pin A of device 00:02.0 - using IRQ 255
Nov 30 17:06:31 gswi1164 kernel: Module yenta_socket cannot be unloaded due to unsafe usage in drivers/pcmcia/yenta.c:940
Nov 30 17:06:31 gswi1164 kernel: Uninitialised timer!
Nov 30 17:06:31 gswi1164 kernel: This is just a warning.  Your computer is OK
Nov 30 17:06:31 gswi1164 kernel: function=0xc6a90e40, data=0xc6a92160
Nov 30 17:06:31 gswi1164 kernel: Call Trace: [check_timer_failed+64/76]  [add_timer+59/288]  [worker_thread+489/716]  [worker_thread+0/716]  [default_wake_function+0/52]  [default_wake_function+0/52]  [kernel_thread_helper+5/12]
Nov 30 17:06:31 gswi1164 kernel: Yenta IRQ list 04b8, PCI irq0
Nov 30 17:06:31 gswi1164 kernel: pci_link-0484 [19] acpi_pci_link_get_irq : Link disabled
Nov 30 17:06:31 gswi1164 kernel:  pci_irq-0256 [18] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
Nov 30 17:06:31 gswi1164 kernel:  pci_irq-0295 [18] acpi_pci_irq_derive   : Unable to derive IRQ for device 00:02.1
Nov 30 17:06:31 gswi1164 kernel: ACPI: No IRQ known for interrupt pin B of device 00:02.1 - using IRQ 255
Nov 30 17:06:31 gswi1164 kernel: Socket status: 30000010
Nov 30 17:06:31 gswi1164 kernel: Uninitialised timer!
Nov 30 17:06:31 gswi1164 kernel: This is just a warning.  Your computer is OK
Nov 30 17:06:31 gswi1164 kernel: function=0xc6a90e40, data=0xc6a92218
Nov 30 17:06:31 gswi1164 kernel: Call Trace: [check_timer_failed+64/76]  [<c6a90e40>]  [<c6a92218>]  [<c6a92290>]  [add_timer+59/288]  [<c6a92290>]  [<c6a92218>]  [<c6a91057>]  [<c6a92290>]  [<c6a92218>]  [worker_thread+489/716]  [<c6a92218>]  [worker_thread+0/716]  [<c6a92218>]  [<c6a90fd0>]  [default_wake_function+0/52]  [default_wake_function+0/52]  [kernel_thread_helper+5/12]
Nov 30 17:06:31 gswi1164 kernel: Yenta IRQ list 04b0, PCI irq0

The second one comes when loading PCMCIA modules, but ksymoops gives
no definite hints.

Trace; c011deb0 <check_timer_failed+40/4c>
Trace; c6a90e40 <END_OF_CODE+6699060/????>
Trace; c6a92218 <END_OF_CODE+669a438/????>
Trace; c6a92290 <END_OF_CODE+669a4b0/????>
Trace; c011def7 <add_timer+3b/120>
Trace; c6a92290 <END_OF_CODE+669a4b0/????>
Trace; c6a92218 <END_OF_CODE+669a438/????>
Trace; c6a91057 <END_OF_CODE+6699277/????>
Trace; c6a92290 <END_OF_CODE+669a4b0/????>
Trace; c6a92218 <END_OF_CODE+669a438/????>
Trace; c0123961 <worker_thread+1e9/2cc>
Trace; c6a92218 <END_OF_CODE+669a438/????>
Trace; c0123778 <worker_thread+0/2cc>
Trace; c6a92218 <END_OF_CODE+669a438/????>
Trace; c6a90fd0 <END_OF_CODE+66991f0/????>
Trace; c0115610 <default_wake_function+0/34>
Trace; c0115610 <default_wake_function+0/34>
Trace; c0106e6d <kernel_thread_helper+5/c>

The following modules are loaded:

root@gswi1164:~# lsmod
Module                  Size  Used by
pcnet_cs               10942  1 [unsafe]
8390                    6149  1 pcnet_cs
ds                      6173  2 pcnet_cs
yenta_socket           10067  1 [unsafe]
pcmcia_core            37051  3 pcnet_cs ds yenta_socket
uhci_hcd               22625  0
rxrpc                  51542  0
usbnet                 14528  0
usbcore                76323  4 uhci_hcd usbnet
ircomm_tty             28005  0
ircomm                 11396  1 ircomm_tty
irda                  134582  3 ircomm_tty ircomm [unsafe]
vfat                    9174  0
fat                    32835  1 vfat

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
