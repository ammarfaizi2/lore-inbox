Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVBKX00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVBKX00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVBKX00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:26:26 -0500
Received: from mailfe09.swip.net ([212.247.155.1]:49296 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262259AbVBKXYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:24:51 -0500
X-T2-Posting-ID: qbtQLYJOjB4bCHCkpZ9cyM8vUUrdS/3cLdfSShO5ydk=
Message-ID: <420D3EEF.20406@laposte.net>
Date: Sat, 12 Feb 2005 00:25:35 +0100
From: Barbara Post <b.post@laposte.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ohci_hcd, usb scanner and kernel 2.6.8.1 or 2.6.10 troubles
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am unable to use my USB Agfa Snapscan 1212_U scanner, with kernel
2.6.8.1 or 2.6.10 (both compiled by myself from www.kernel.org sources) 
and xsane 0.96-1 (Debian).

It worked with kernel 2.6.7.

When I use VMware, I'm able to use it though (in Windows), whatever
linux kernel I use.

When I start xsane, I get "error opening device
'snapscan:libusb:001:004': I/O error on device" or simply "no device
found" if I restart xsane after the first error message (or sometimes at 
first start).

Sometimes it gets further and when I try to acquire preview, I get "I/O
error" and the following in /var/log/syslog :

Feb 11 23:19:00 babs1 kernel: ohci_hcd 0000:00:02.2: urb c15e13e0 path
1.3 ep1in 82160000 cc 8 --> status -75

or this :

ohci_hcd 0000:00:02.2 urb c15e1460 path 1.3 ep1in 82160000 cc8 -->
status -75

Scanner is correctly found by sane-find-scanner. It seems that it
changes port every time.

Thank you very much for any hint. What could I do since my .config 
contains CONFIG_USB_DEBUG=y ? Enabling debugging for xscanimage doesn't 
help.


Barbara

-------------------------------------------------------------------
$ lsmod
Module                  Size  Used by
ohci_hcd               32584  0
sr_mod                 13860  0
sd_mod                 12368  0
radeon                129060  0
vmnet                  28124  2
vmmon                 153132  0
ipt_REJECT              5568  0
ipt_limit               1920  0
ipt_LOG                 6208  0
ipt_MASQUERADE          2688  0
ipt_state               1472  0
iptable_mangle          2176  0
iptable_nat            23368  1 ipt_MASQUERADE
ip_conntrack           40308  3 ipt_MASQUERADE,ipt_state,iptable_nat
iptable_filter          2944  0
ip_tables              16320  8
ipt_REJECT,ipt_limit,ipt_LOG,ipt_MASQUERADE,ipt_state,iptable_mangle,iptable_nat,iptable_filter
i2c_sis96x              4484  0
it87                   21156  0
i2c_sensor              2880  1 it87
i2c_isa                 1664  0
snd_pcm_oss            55716  0
snd_mixer_oss          18944  1 snd_pcm_oss
apm                    18092  0

Note : vmnet and vmmon are VMware modules, they never bothered. I have
the same error when vmware service is stopped and they are unloaded.

-------------------------------------------------------------------

Here are lenghty log files that may help.

---------------------------------------------------------------------

Powering on scanner (usb hub unplugged, unloading ohci-hid module first):

Feb 11 23:55:53 babs1 kernel: ohci_hcd 0000:00:02.3: wakeup
Feb 11 23:55:53 babs1 kernel: hub 2-0:1.0: state 5 ports 3 chg fff8 evt 0002
Feb 11 23:55:53 babs1 kernel: ohci_hcd 0000:00:02.3: GetStatus
roothub.portstatus [0] = 0x00010101 CSC PPS CCS
Feb 11 23:55:53 babs1 kernel: hub 2-0:1.0: port 1, status 0101, change
0001, 12 Mb/s
Feb 11 23:55:53 babs1 kernel: hub 2-0:1.0: debounce: port 1: total 100ms
stable 100ms status 0x101
Feb 11 23:55:53 babs1 kernel: ohci_hcd 0000:00:02.3: GetStatus
roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
Feb 11 23:55:53 babs1 kernel: usb 2-1: new full speed USB device using
ohci_hcd and address 2
Feb 11 23:55:53 babs1 kernel: ohci_hcd 0000:00:02.3: GetStatus
roothub.portstatus [0] = 0x00100103 PRSC PPS PES CCS
Feb 11 23:55:53 babs1 kernel: usb 2-1: ep0 maxpacket = 8
Feb 11 23:55:53 babs1 kernel: usb 2-1: new device strings: Mfr=1,
Product=2, SerialNumber=0
Feb 11 23:55:53 babs1 kernel: usb 2-1: default language 0x0409
Feb 11 23:55:53 babs1 kernel: usb 2-1: Product: SNAPSCAN
Feb 11 23:55:53 babs1 kernel: usb 2-1: Manufacturer: AGFA
Feb 11 23:55:53 babs1 kernel: usb 2-1: hotplug
Feb 11 23:55:53 babs1 usb.agent[6641]:      libusbscanner: loaded
successfully
Feb 11 23:55:53 babs1 kernel: usb 2-1: adding 2-1:1.0 (config #1,
interface 0)
Feb 11 23:55:53 babs1 kernel: usb 2-1:1.0: hotplug

-----------------------------------------------------------------------

Powering on scanner (plugged on usb hub):

Feb 11 23:27:56 babs1 kernel: hub 1-1:1.0: state 5 ports 4 chg fff0 evt 0008
Feb 11 23:27:56 babs1 kernel: hub 1-1:1.0: port 3, status 0100, change
0001, 12Mb/s
Feb 11 23:27:56 babs1 kernel: usb 1-1.3: USB disconnect, address 3
Feb 11 23:27:56 babs1 kernel: usb 1-1.3: usb_disable_device nuking all URBs
Feb 11 23:27:56 babs1 kernel: usb 1-1.3: unregistering interface 1-1.3:1.0
Feb 11 23:27:56 babs1 kernel: usb 1-1.3:1.0: hotplug
Feb 11 23:27:56 babs1 kernel: usb 1-1.3: unregistering device
Feb 11 23:27:56 babs1 kernel: usb 1-1.3: hotplug
Feb 11 23:27:56 babs1 kernel: hub 1-1:1.0: debounce: port 3: total 100ms
stable100ms status 0x100
Feb 11 23:34:56 babs1 kernel: hub 1-1:1.0: state 5 ports 4 chg fff0 evt 0008
Feb 11 23:34:56 babs1 kernel: hub 1-1:1.0: port 3, status 0101, change
0001, 12Mb/s
Feb 11 23:34:56 babs1 kernel: hub 1-1:1.0: debounce: port 3: total 100ms
stable100ms status 0x101
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: new full speed USB device using
ohci_hcd and address 4
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: ep0 maxpacket = 8
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: new device strings: Mfr=1,
Product=2, SerialNumber=0
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: default language 0x0409
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: Product: SNAPSCAN
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: Manufacturer: AGFA
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: hotplug
Feb 11 23:34:56 babs1 kernel: usb 1-1.3: adding 1-1.3:1.0 (config #1,
interface0)
Feb 11 23:34:56 babs1 kernel: usb 1-1.3:1.0: hotplug
Feb 11 23:34:57 babs1 usb.agent[30255]:      libusbscanner: loaded
successfully

-----------------------------------------------------------------------

Restarting hotplug with scanner on a standalone USB port (no usb hub):

Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: remove, state 1
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub graceful
disconnect
Feb 11 23:48:23 babs1 kernel: usb usb1: USB disconnect, address 1
Feb 11 23:48:23 babs1 kernel: usb usb1: usb_disable_device nuking all URBs
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: shutdown urb
d775be60 pipe 4040818
0 ep1in-intr
Feb 11 23:48:23 babs1 kernel: usb usb1: unregistering interface 1-0:1.0
Feb 11 23:48:23 babs1 kernel: usb 1-0:1.0: hotplug
Feb 11 23:48:23 babs1 kernel: usb usb1: unregistering device
Feb 11 23:48:23 babs1 kernel: usb usb1: hotplug
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: stop suspend
controller (state 0x8
5)
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI controller state
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: control 0x6c3 RWE
RWC HCFS=suspend
  CBSR=3
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: cmdstatus 0x00000 SOC=0
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: intrstatus 0x00000000
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: intrenable
0x8000000a MIE RD WDH
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: hcca frame #0269
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.status
00008000 DRWE
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[0] 0x00000100
PPS
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.2: USB bus 1 deregistered
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: remove, state 1
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub graceful
disconnect
Feb 11 23:48:23 babs1 kernel: usb usb2: USB disconnect, address 1
Feb 11 23:48:23 babs1 kernel: usb 2-1: USB disconnect, address 2
Feb 11 23:48:23 babs1 kernel: usb 2-1: usb_disable_device nuking all URBs
Feb 11 23:48:23 babs1 kernel: usb 2-1: unregistering interface 2-1:1.0
Feb 11 23:48:23 babs1 kernel: usb 2-1:1.0: hotplug
Feb 11 23:48:23 babs1 kernel: usb 2-1: unregistering device
Feb 11 23:48:23 babs1 kernel: usb 2-1: hotplug
Feb 11 23:48:23 babs1 kernel: usb usb2: usb_disable_device nuking all URBs
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: shutdown urb
d775bce0 pipe 4040818
0 ep1in-intr
Feb 11 23:48:23 babs1 kernel: usb usb2: unregistering interface 2-0:1.0
Feb 11 23:48:23 babs1 kernel: usb 2-0:1.0: hotplug
Feb 11 23:48:23 babs1 kernel: usb usb2: unregistering device
Feb 11 23:48:23 babs1 kernel: usb usb2: hotplug
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: stop operational
controller (state
  0x85)
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI controller state
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: control 0x283 RWC
HCFS=operational
  CBSR=3
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: cmdstatus 0x00000 SOC=0
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: intrstatus
0x00000004 SF
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: intrenable
0x8000000a MIE RD WDH
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: ed_controlhead 1a36a000
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: hcca frame #6bdf
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.status
00008000 DRWE
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[0] 0x00000103
PPS PES CCS
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:48:23 babs1 kernel: ohci_hcd 0000:00:02.3: USB bus 2 deregistered
Feb 11 23:48:24 babs1 pci.agent[3426]:      i2c-sis96x: already loaded
Feb 11 23:48:24 babs1 kernel: ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host
Controller (OHC
I) Driver (PCI)
Feb 11 23:48:24 babs1 kernel: ohci_hcd: block sizes: ed 64 td 64
Feb 11 23:48:24 babs1 kernel: PCI: Found IRQ 11 for device 0000:00:02.2
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: Silicon Integrated
Systems [SiS] U
SB 1.0 Controller
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: irq 11, pci mem
0xcfffe000
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: new USB bus
registered, assigned b
us number 1
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: resetting from
state 'reset', cont
rol = 0x200
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: enabling initreset
quirk
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI controller state
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: control 0x283 RWC
HCFS=operational
  CBSR=3
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: cmdstatus 0x00000 SOC=0
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: intrstatus
0x00000004 SF
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: intrenable
0x8000000a MIE RD WDH
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: hcca frame #0003
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.status
00008000 DRWE
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[0] 0x00000100
PPS
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: supports USB remote
wakeup
eb 11 23:48:24 babs1 kernel: usb usb1: new device strings: Mfr=3,
Product=2, SerialNum
ber=1
Feb 11 23:48:24 babs1 kernel: usb usb1: default language 0x0409
Feb 11 23:48:24 babs1 kernel: usb usb1: Product: Silicon Integrated
Systems [SiS] USB 1
.0 Controller
Feb 11 23:48:24 babs1 kernel: usb usb1: Manufacturer: Linux 2.6.10 ohci_hcd
Feb 11 23:48:24 babs1 kernel: usb usb1: SerialNumber: 0000:00:02.2
Feb 11 23:48:24 babs1 kernel: usb usb1: hotplug
Feb 11 23:48:24 babs1 kernel: usb usb1: adding 1-0:1.0 (config #1,
interface 0)
Feb 11 23:48:24 babs1 kernel: usb 1-0:1.0: hotplug
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: usb_probe_interface
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: usb_probe_interface - got id
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: USB hub found
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: 3 ports detected
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: standalone hub
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: no power switching (usb 1.0)
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: global over-current protection
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: power on to power good time: 2ms
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: local power source is good
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: no over-current condition exists
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: state 5 ports 3 chg ffff evt ffff
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: port 1, status 0100, change
0000, 12 Mb/s
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: port 2, status 0100, change
0000, 12 Mb/s
Feb 11 23:48:24 babs1 kernel: hub 1-0:1.0: port 3, status 0100, change
0000, 12 Mb/s
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.2: created debug files
Feb 11 23:48:24 babs1 kernel: PCI: Found IRQ 5 for device 0000:00:02.3
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: Silicon Integrated
Systems [SiS] U
SB 1.0 Controller (#2)
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: irq 5, pci mem
0xcffff000
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: new USB bus
registered, assigned b
us number 2
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: resetting from
state 'reset', cont
rol = 0x200
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI controller state
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: control 0x283 RWC
HCFS=operational
  CBSR=3
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: cmdstatus 0x00000 SOC=0
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: intrstatus
0x00000044 RHSC SF
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: intrenable
0x8000000a MIE RD WDH
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: hcca frame #0003
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.status
00008000 DRWE
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[0] 0x00010101
CSC PPS CCS
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:48:24 babs1 kernel: ohci_hcd 0000:00:02.3: supports USB remote
wakeup
Feb 11 23:48:24 babs1 kernel: usb usb2: new device strings: Mfr=3,
Product=2, SerialNum
ber=1
Feb 11 23:48:24 babs1 kernel: usb usb2: default language 0x0409
Feb 11 23:48:24 babs1 kernel: usb usb2: Product: Silicon Integrated
Systems [SiS] USB 1
.0 Controller (#2)
Feb 11 23:48:24 babs1 kernel: usb usb2: Manufacturer: Linux 2.6.10 ohci_hcd
Feb 11 23:48:24 babs1 kernel: usb usb2: SerialNumber: 0000:00:02.3
Feb 11 23:48:24 babs1 kernel: usb usb2: hotplug
Feb 11 23:48:24 babs1 kernel: usb usb2: adding 2-0:1.0 (config #1,
interface 0)
Feb 11 23:48:24 babs1 kernel: usb 2-0:1.0: hotplug
Feb 11 23:48:25 babs1 kernel: ohci_hcd 0000:00:02.2: suspend root hub
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: usb_probe_interface
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: usb_probe_interface - got id
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: USB hub found
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: 3 ports detected
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: standalone hub
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: no power switching (usb 1.0)
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: global over-current protection
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: power on to power good time: 2ms
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: local power source is good
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: no over-current condition exists
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: state 5 ports 3 chg ffff evt ffff
Feb 11 23:48:25 babs1 kernel: ohci_hcd 0000:00:02.3: GetStatus
roothub.portstatus [0] =
  0x00010101 CSC PPS CCS
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: port 1, status 0101, change
0001, 12 Mb/s
Feb 11 23:48:25 babs1 kernel: ohci_hcd 0000:00:02.3: created debug files
Feb 11 23:48:25 babs1 pci.agent[3455]:      ohci-hcd: loaded successfully
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: debounce: port 1: total 100ms
stable 100ms s
tatus 0x101
Feb 11 23:48:25 babs1 pci.agent[3572]:      ohci-hcd: already loaded
Feb 11 23:48:25 babs1 kernel: ohci_hcd 0000:00:02.3: GetStatus
roothub.portstatus [0] =
  0x00100103 PRSC PPS PES CCS
Feb 11 23:48:25 babs1 kernel: usb 2-1: new full speed USB device using
ohci_hcd and add
ress 2
Feb 11 23:48:25 babs1 kernel: ohci_hcd 0000:00:02.3: GetStatus
roothub.portstatus [0] =
  0x00100103 PRSC PPS PES CCS
Feb 11 23:48:25 babs1 kernel: usb 2-1: ep0 maxpacket = 8
Feb 11 23:48:25 babs1 kernel: usb 2-1: new device strings: Mfr=1,
Product=2, SerialNumb
er=0
Feb 11 23:48:25 babs1 kernel: usb 2-1: default language 0x0409
Feb 11 23:48:25 babs1 kernel: usb 2-1: Product: SNAPSCAN
Feb 11 23:48:25 babs1 kernel: usb 2-1: Manufacturer: AGFA
Feb 11 23:48:25 babs1 kernel: usb 2-1: hotplug
Feb 11 23:48:25 babs1 kernel: usb 2-1: adding 2-1:1.0 (config #1,
interface 0)
Feb 11 23:48:25 babs1 kernel: usb 2-1:1.0: hotplug
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: port 2, status 0100, change
0000, 12 Mb/s
Feb 11 23:48:25 babs1 kernel: hub 2-0:1.0: port 3, status 0100, change
0000, 12 Mb/s
Feb 11 23:48:25 babs1 usb.agent[3644]:      libusbscanner: loaded
successfully

-----------------------------------------------------------------------
Restarting hotplug (/etc/init.d/hotplug restart), scanner plugged on usb
hub:

Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: remove, state 1
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub graceful
disconnect
Feb 11 23:41:13 babs1 kernel: usb usb1: USB disconnect, address 1
Feb 11 23:41:13 babs1 kernel: usb 1-1: USB disconnect, address 2
Feb 11 23:41:13 babs1 kernel: usb 1-1: usb_disable_device nuking all URBs
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: shutdown urb
d775b460 pipe
40408280 ep1in-intr
Feb 11 23:41:13 babs1 kernel: usb 1-1: unregistering interface 1-1:1.0
Feb 11 23:41:13 babs1 kernel: usb 1-1:1.0: hotplug
Feb 11 23:41:13 babs1 kernel: usb 1-1: unregistering device
Feb 11 23:41:13 babs1 kernel: usb 1-1: hotplug
Feb 11 23:41:13 babs1 kernel: usb usb1: usb_disable_device nuking all URBs
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: shutdown urb
d775bce0 pipe 4040818
0 ep1in-intr
Feb 11 23:41:13 babs1 kernel: usb usb1: unregistering interface 1-0:1.0
Feb 11 23:41:13 babs1 kernel: usb 1-0:1.0: hotplug
Feb 11 23:41:13 babs1 kernel: usb usb1: unregistering device
Feb 11 23:41:13 babs1 kernel: usb usb1: hotplug
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: stop operational
controller (state
  0x85)
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI controller state
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: control 0x283 RWC
HCFS=operational
  CBSR=3
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: cmdstatus 0x00000 SOC=0
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: intrstatus
0x00000024 FNO SF
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: intrenable
0x8000000a MIE RD WDH
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: ed_controlhead 140a4000
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: hcca frame #1930
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.status
00008000 DRWE
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[0] 0x00000103
PPS PES CCS
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: USB bus 1 deregistered
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: remove, state 1
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub graceful
disconnect
Feb 11 23:41:13 babs1 kernel: usb usb2: USB disconnect, address 1
Feb 11 23:41:13 babs1 kernel: usb usb2: usb_disable_device nuking all URBs
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: shutdown urb
d775be60 pipe 4040818
0 ep1in-intr
Feb 11 23:41:13 babs1 kernel: usb usb2: unregistering interface 2-0:1.0
Feb 11 23:41:13 babs1 kernel: usb 2-0:1.0: hotplug
Feb 11 23:41:13 babs1 kernel: usb usb2: unregistering device
Feb 11 23:41:13 babs1 kernel: usb usb2: hotplug
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: stop suspend
controller (state 0x8
5)
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI controller state
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: control 0x6c3 RWE
RWC HCFS=suspend
  CBSR=3
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: cmdstatus 0x00000 SOC=0
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: intrstatus 0x00000000
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: intrenable
0x8000000a MIE RD WDH
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: hcca frame #0273
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.status
00008000 DRWE
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[0] 0x00000100
PPS
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.3: USB bus 2 deregistered
Feb 11 23:41:13 babs1 pci.agent[32766]:      i2c-sis96x: already loaded
Feb 11 23:41:13 babs1 kernel: ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host
Controller (OHC
I) Driver (PCI)
Feb 11 23:41:13 babs1 kernel: ohci_hcd: block sizes: ed 64 td 64
Feb 11 23:41:13 babs1 kernel: PCI: Found IRQ 11 for device 0000:00:02.2
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: Silicon Integrated
Systems [SiS] U
SB 1.0 Controller
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: irq 11, pci mem
0xcfffe000
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: new USB bus
registered, assigned b
us number 1
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: resetting from
state 'reset', cont
rol = 0x200
Feb 11 23:41:13 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI controller state
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: control 0x283 RWC
HCFS=operational
  CBSR=3
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: cmdstatus 0x00000 SOC=0
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: intrstatus
0x00000044 RHSC SF
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: intrenable
0x8000000a MIE RD WDH
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: hcca frame #0003
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.status
00008000 DRWE
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[0] 0x00010101
CSC PPS CCS
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: supports USB remote
wakeup
Feb 11 23:41:14 babs1 kernel: usb usb1: new device strings: Mfr=3,
Product=2, SerialNum
ber=1
Feb 11 23:41:14 babs1 kernel: usb usb1: default language 0x0409
Feb 11 23:41:14 babs1 kernel: usb usb1: Product: Silicon Integrated
Systems [SiS] USB 1
.0 Controller
Feb 11 23:41:14 babs1 kernel: usb usb1: Manufacturer: Linux 2.6.10 ohci_hcd
Feb 11 23:41:14 babs1 kernel: usb usb1: SerialNumber: 0000:00:02.2
Feb 11 23:41:14 babs1 kernel: usb usb1: hotplug
Feb 11 23:41:14 babs1 kernel: usb 1-0:1.0: hotplug
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: usb_probe_interface
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: usb_probe_interface - got id
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: USB hub found
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: 3 ports detected
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: standalone hub
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: no power switching (usb 1.0)
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: global over-current protection
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: power on to power good time: 2ms
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: local power source is good
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: no over-current condition exists
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: state 5 ports 3 chg ffff evt ffff
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: GetStatus
roothub.portstatus [0] =
  0x00010101 CSC PPS CCS
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: port 1, status 0101, change
0001, 12 Mb/s
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: created debug files
Feb 11 23:41:14 babs1 kernel: PCI: Found IRQ 5 for device 0000:00:02.3
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: Silicon Integrated
Systems [SiS] U
SB 1.0 Controller (#2)
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: irq 5, pci mem
0xcffff000
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: new USB bus
registered, assigned b
us number 2
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: resetting from
state 'reset', cont
rol = 0x200
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: enabling initreset
quirk
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI controller state
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: OHCI 1.0, with
legacy support regi
sters
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: control 0x283 RWC
HCFS=operational
  CBSR=3
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: cmdstatus 0x00000 SOC=0
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: intrstatus
0x00000004 SF
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: intrenable
0x8000000a MIE RD WDH
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: hcca frame #0003
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.a 01000203
POTPGT=1 NPS ND
P=3
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.b 00000000
PPCM=0000 DR=00
00
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.status
00008000 DRWE
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[0] 0x00000100
PPS
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[1] 0x00000100
PPS
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: roothub.portstatus
[2] 0x00000100
PPS
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: supports USB remote
wakeup
Feb 11 23:41:14 babs1 kernel: usb usb2: new device strings: Mfr=3,
Product=2, SerialNum
ber=1
Feb 11 23:41:14 babs1 kernel: usb usb2: default language 0x0409
Feb 11 23:41:14 babs1 kernel: usb usb2: Product: Silicon Integrated
Systems [SiS] USB 1
.0 Controller (#2)
Feb 11 23:41:14 babs1 kernel: usb usb2: Manufacturer: Linux 2.6.10 ohci_hcd
Feb 11 23:41:14 babs1 kernel: usb usb2: SerialNumber: 0000:00:02.3
Feb 11 23:41:14 babs1 kernel: usb usb2: hotplug
Feb 11 23:41:14 babs1 kernel: hub 1-0:1.0: debounce: port 1: total 100ms
stable 100ms s
tatus 0x101
Feb 11 23:41:14 babs1 kernel: usb usb2: adding 2-0:1.0 (config #1,
interface 0)
Feb 11 23:41:14 babs1 kernel: usb 2-0:1.0: hotplug
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: usb_probe_interface
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: usb_probe_interface - got id
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: USB hub found
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: 3 ports detected
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: standalone hub
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: no power switching (usb 1.0)
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: global over-current protection
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: power on to power good time: 2ms
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: local power source is good
Feb 11 23:41:14 babs1 kernel: hub 2-0:1.0: no over-current condition exists
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.3: created debug files
Feb 11 23:41:14 babs1 pci.agent[326]:      ohci-hcd: loaded successfully
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: GetStatus
roothub.portstatus [0] =
  0x00100103 PRSC PPS PES CCS
Feb 11 23:41:14 babs1 kernel: usb 1-1: new full speed USB device using
ohci_hcd and add
ress 2
Feb 11 23:41:14 babs1 kernel: ohci_hcd 0000:00:02.2: GetStatus
roothub.portstatus [0] =
  0x00100103 PRSC PPS PES CCS
Feb 11 23:41:14 babs1 pci.agent[437]:      ohci-hcd: already loaded
Feb 11 23:41:14 babs1 kernel: usb 1-1: new device strings: Mfr=0,
Product=0, SerialNumb
er=0
Feb 11 23:41:14 babs1 kernel: usb 1-1: hotplug
Feb 11 23:41:15 babs1 kernel: usb 1-1: adding 1-1:1.0 (config #1,
interface 0)
Feb 11 23:41:15 babs1 kernel: usb 1-1:1.0: hotplug
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: usb_probe_interface
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: usb_probe_interface - got id
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: USB hub found
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: 4 ports detected
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: standalone hub
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: individual port power switching
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: individual port over-current
protection
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: power on to power good time:
100ms
Feb 11 23:41:15 babs1 kernel: ohci_hcd 0000:00:02.3: suspend root hub
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: local power source is lost
(inactive)
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: enabling power on all ports
Feb 11 23:41:15 babs1 kernel: hub 1-0:1.0: port 2, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 1-0:1.0: port 3, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 1-0:1.0: state 5 ports 3 chg fff8 evt 0002
Feb 11 23:41:15 babs1 kernel: hub 2-0:1.0: state 5 ports 3 chg ffff evt ffff
Feb 11 23:41:15 babs1 kernel: hub 2-0:1.0: port 1, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 2-0:1.0: port 2, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 2-0:1.0: port 3, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: state 5 ports 4 chg ffff evt ffff
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: port 1, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: port 2, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: port 3, status 0101, change
0001, 12 Mb/s
Feb 11 23:41:15 babs1 pci.rc[32704]:      ignoring pci display device on
01:00.0
Feb 11 23:41:15 babs1 kernel: hub 1-1:1.0: debounce: port 3: total 100ms
stable 100ms s
tatus 0x101
Feb 11 23:41:15 babs1 kernel: usb 1-1.3: new full speed USB device using
ohci_hcd and a
ddress 3
Feb 11 23:41:15 babs1 kernel: ohci_hcd 0000:00:02.2: urb c402a0e0 path
1.3 ep0in 5ec200
00 cc 5 --> status -110
Feb 11 23:41:15 babs1 kernel: usb 1-1.3: device descriptor read/64,
error -110
Feb 11 23:41:15 babs1 kernel: ohci_hcd 0000:00:02.2: urb c402a0e0 path
1.3 ep0in 5ec200
00 cc 5 --> status -110
Feb 11 23:41:15 babs1 kernel: usb 1-1.3: device descriptor read/64,
error -110
Feb 11 23:41:15 babs1 kernel: usb 1-1.3: new full speed USB device using
ohci_hcd and a
ddress 4
Feb 11 23:41:15 babs1 kernel: ohci_hcd 0000:00:02.2: urb c402a0e0 path
1.3 ep0in 5ec200
00 cc 5 --> status -110
Feb 11 23:41:15 babs1 kernel: usb 1-1.3: device descriptor read/64,
error -110
Feb 11 23:41:15 babs1 kernel: ohci_hcd 0000:00:02.2: urb c402a0e0 path
1.3 ep0in 5ec200
00 cc 5 --> status -110
Feb 11 23:41:15 babs1 kernel: usb 1-1.3: device descriptor read/64,
error -110
Feb 11 23:41:16 babs1 kernel: hub 1-1:1.0: port 4, status 0100, change
0000, 12 Mb/s
Feb 11 23:41:16 babs1 kernel: hub 1-1:1.0: state 5 ports 4 chg fff0 evt 0008






