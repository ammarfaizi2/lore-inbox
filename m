Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRIHJG5>; Sat, 8 Sep 2001 05:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRIHJGr>; Sat, 8 Sep 2001 05:06:47 -0400
Received: from OL8-13.fibertel.com.ar ([24.232.13.8]:45813 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S268100AbRIHJGd>; Sat, 8 Sep 2001 05:06:33 -0400
Date: Sat, 8 Sep 2001 06:06:40 -0300 (ART)
From: Flavio Villanustre <flavio@geminis.myip.org>
X-X-Sender: <flavio@localhost.localdomain>
To: <alan.cox@linux.org>
cc: <linux-kernel@vger.kernel.org>
Subject: USB kernel Oops report
Message-ID: <Pine.LNX.4.33.0109080605560.1907-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

may be you're not the one to report this bug to... if that's the case 
please tell me who to address this email to.

With a stock kernel 2.4.9, with usbcore builtin (but with usb drivers 
modularized), I get this Oops when loading usb-uhci:

Sep  8 05:03:24 localhost kernel: hub.c: USB hub found
Sep  8 05:03:24 localhost kernel: hub.c: 2 ports detected
Sep  8 05:03:24 localhost kernel: usb-uhci.c: v1.251:USB Universal Host 
Controller Interface driver
Sep  8 05:03:24 localhost kernel: usb.c: USB disconnect on device 1
Sep  8 05:03:24 localhost kernel: usb.c: USB disconnect on device 2
Sep  8 05:03:24 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000000c
Sep  8 05:03:24 localhost kernel:  printing eip:
Sep  8 05:03:24 localhost kernel: c0217262
Sep  8 05:03:24 localhost kernel: *pde = 00000000
Sep  8 05:03:24 localhost kernel: Oops: 0000
Sep  8 05:03:24 localhost kernel: CPU:    0
Sep  8 05:03:24 localhost kernel: EIP:    0010:[call_policy+354/496]
Sep  8 05:03:24 localhost kernel: EIP:    0010:[<c0217262>]
Sep  8 05:03:24 localhost kernel: EFLAGS: 00010246
Sep  8 05:03:24 localhost kernel: eax: 00000000   ebx: c18adba8   ecx: 
00000000
  edx: c02b5d06
Sep  8 05:03:24 localhost kernel: esi: c18cbbe0   edi: df299200   ebp: 
c18adb60
  esp: df133ef4
Sep  8 05:03:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
Sep  8 05:03:24 localhost kernel: Process modprobe (pid: 264, 
stackpage=df133000)
Sep  8 05:03:24 localhost kernel: Stack: 00000007 c02d1b40 c02b5ce4 
00000000 00000025 df299240 df299338 00000002
Sep  8 05:03:24 localhost kernel:        df299200 c0218408 c02ad92c 
df299200 c021a07c ffffffff df5fc200 df5fc2f8
Sep  8 05:03:24 localhost kernel:        df9bb9c0 df5fc200 c02183f0 
df5fc2f8 00000018 0000000f c18add60 e0879a80
Sep  8 05:03:24 localhost kernel: Call Trace: [usb_disconnect+232/288] 
[hub_disconnect+28/96] [usb_disconnect+208/288] 
[ipchains:__insmod_ipchains_O/lib/modules/2.4.9/kernel/net/ipv4/netfi+-9600/96] 
[ipchains:__insmod_ipchains_O/lib/modules/2.4.9/kernel/net/ipv4/netfi+-13942/96]
Sep  8 05:03:24 localhost kernel: Call Trace: [<c0218408>] [<c021a07c>] 
[<c02183f0>] [<e0879a80>] [<e087898a>]
Sep  8 05:03:24 localhost kernel:    [pci_unregister_driver+47/80] 
[ipchains:__insmod_ipchains_O/lib/modules/2.4.9/kernel/net/ipv4/netfi+-12694/96] 
[ipchains:__insmod_ipchains_O/lib/modules/2.4.9/kernel/net/ipv4/netfi+-9600/96] 
[free_module+30/176] [sys_delete_module+265/480] [system_call+51/56]
Sep  8 05:03:24 localhost kernel:    [<c01f73af>] [<e0878e6a>] 
[<e0879a80>] [<c01157fe>] [<c0114ce9>] [<c0106ceb>]
Sep  8 05:03:24 localhost kernel:
Sep  8 05:03:24 localhost kernel: Code: 8b 40 0c 8b 50 04 89 5e 1c c7 04 
24 08 00 00 00 8b 87 d0 00
Sep  8 05:03:24 localhost kernel: usb.c: failed to set device 2 default 
configuration (error=-19)
Sep  8 05:03:24 localhost kernel: hub.c: get_port_status(1) failed (err = 
-19)
Sep  8 05:03:24 localhost last message repeated 4 times
Sep  8 05:03:24 localhost kernel: hub.c: Cannot enable port 1 of hub 1, 
disabling port
Sep  8 05:03:24 localhost kernel: hub.c: Maybe the USB cable is bad?
Sep  8 05:03:24 localhost kernel: hub.c: cannot disable port 1 of hub 1 
(err = -19)
Sep  8 05:03:24 localhost kernel: hub.c: get_port_status failed (err = 
-19)
Sep  8 05:03:24 localhost kernel: hub.c: get_hub_status failed

-------------------------------------

Of course if I compile usbcore as a module nothing of this happens and USB
works properly. OTOH, JE-uhci doesn't recognize my Saitek USB Cyborg
joystik yet, so I do need usb-uhci.

I know you could tell me that I should compile usbcore as a module an get
rid of the Oops but...

Thanks and regards,

Flavio.


