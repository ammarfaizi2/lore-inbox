Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTGHCkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 22:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbTGHCkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 22:40:24 -0400
Received: from [211.101.246.248] ([211.101.246.248]:55428 "HELO
	capitalnet.com.cn") by vger.kernel.org with SMTP id S264864AbTGHCkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 22:40:14 -0400
Message-ID: <3F0AA354.3050507@exavio.com.cn>
Date: Tue, 08 Jul 2003 10:56:20 +0000
From: Peter Yao <peter@exavio.com.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Georg Nikodym <georgn@somanetworks.com>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: unsolicited response packet messages
References: <20030707115546.1758fbba.georgn@somanetworks.com>
In-Reply-To: <20030707115546.1758fbba.georgn@somanetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got that message on some ohci 1.1 card, it seems that the AsTxComplete
interrupt came after the RSPkt interrupt.
Each "np" message should be followed by a "timed-out packet" message.

I don't see such issue on ohci 1.0 card.

Georg Nikodym wrote:
> Upon booting my new 2.5.74 kernel (on a Dell I8000 with a large external
> 1394 disk) I get the output below (I left some of the non 1394 messages
> in there to provide a little context).
> 
> Eventually, these messages stop.  I manually mount the filesystems on
> this disk once the boot is complete (a hangover from the rescan/scsiadd
> on 2.4 kernels).
> 
> My kernel config is attached (in case anyone cares).
> 
> So, should I be concerned?
> 
> -g
> 
> ...
> PCI: Sharing IRQ 10 with 0000:02:0f.2
> ti113x: Routing card interrupts to PCI
> Yenta IRQ list 0000, PCI irq10
> Socket status: 30000006
> scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
> ieee1394: sbp2: Logged into SBP-2 device
> ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
>   Vendor: IC35L120  Model: AVVA07-0          Rev:     
>   Type:   Direct-Access                      ANSI SCSI revision: 06
> SCSI device sda: 241254720 512-byte hdwr sectors (123522 MB)
> sda: asking for cache data failed
> sda: assuming drive cache: write through
>  sda: sda1 sda2
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
> ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0001d2000003a4ec]
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc10160 ffc10000 00000000 6cef0404
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
> PCI: Found IRQ 10 for device 0000:00:1f.2
> PCI: Sharing IRQ 10 with 0000:02:0f.0
> PCI: Sharing IRQ 10 with 0000:02:0f.1
> PCI: Sharing IRQ 10 with 0000:02:0f.2
> PCI: Setting latency timer of device 0000:00:1f.2 to 64
> uhci-hcd 0000:00:1f.2: Intel Corp. 82801BA/BAM USB (Hub
> uhci-hcd 0000:00:1f.2: irq 10, io base 0000bce0
> Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
> uhci-hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
> hub 1-0:0: USB hub found
> hub 1-0:0: 2 ports detected
> Initializing USB Mass Storage driver...
> drivers/usb/core/usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> drivers/usb/core/usb.c: registered new driver hid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> synaptics reset failed
> synaptics reset failed
> synaptics reset failed
> Synaptics Touchpad, model: 1
>  Firware: 5.6
>  180 degree mounted touchpad
>  Sensor: 1
>  new absolute packet format
>  Touchpad has extended capability bits
>  -> multifinger detection
>  -> palm detection
> input: Synaptics Synaptics TouchPad on isa0060/serio1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
> request_module: failed /sbin/modprobe -- snd-card-0. error = -16
> PCI: Found IRQ 5 for device 0000:02:03.0
> maestro3: enabled hack for 'Dell Inspiron 8000'
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc10560 ffc10000 00000000 6cef0404
> hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
> hub 1-0:0: new USB device on port 2, assigned address 2
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc10960 ffc10000 00000000 6cef0404
> input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1f.2-2
> ALSA device list:
>   #0: ESS Maestro3 PCI at 0xdc00, irq 5
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP: routing cache hash table of 4096 buckets, 32Kbytes
> TCP: Hash tables configured (established 32768 bind 32768)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> BIOS EDD facility v0.09 2003-Jan-22, 1 devices found
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 136k freed
> ieee1394: ConfigROM quadlet transaction error for node 01:1023
> ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> ieee1394: sbp2: Reconnected to SBP-2 device
> ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc10d60 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc11160 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc11560 ffc10000 00000000 6cef0404
> ieee1394: ConfigROM quadlet transaction error for node 01:1023
> ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> Adding 1269124k swap on /dev/hda2.  Priority:-1 extents:1
> EXT3 FS on hda1, internal journal
> ieee1394: sbp2: Reconnected to SBP-2 device
> ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc11960 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc11d60 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc12160 ffc10000 00000000 6cef0404
> ieee1394: ConfigROM quadlet transaction error for node 01:1023
> ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> ieee1394: sbp2: Reconnected to SBP-2 device
> ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc12560 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc12960 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc12d60 ffc10000 00000000 6cef0404
> ieee1394: ConfigROM quadlet transaction error for node 01:1023
> ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> ieee1394: sbp2: Reconnected to SBP-2 device
> ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc13160 ffc10000 00000000 6cef0404
> Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc13560 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc13960 ffc10000 00000000 6cef0404
> ieee1394: ConfigROM quadlet transaction error for node 01:1023
> ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> ieee1394: sbp2: Reconnected to SBP-2 device
> ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc13d60 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc14160 ffc10000 00000000 6cef0404
> ieee1394: unsolicited response packet received - np
> ieee1394: contents: ffc14560 ffc10000 00000000 6cef0404
> ieee1394: ConfigROM quadlet transaction error for node 01:1023
> ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
> ...



