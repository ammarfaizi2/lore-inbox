Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVHER21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVHER21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbVHER2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:28:18 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:64530 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S263090AbVHER1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:27:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1123260373.4471.8.camel@dhcp-192-168-22-217.internal>
References: <1123234785.7889.7.camel@dhcp-192-168-22-217.internal> <Pine.LNX.4.63.0508051024100.559@excalibur.intercode> <1123260373.4471.8.camel@dhcp-192-168-22-217.internal>
X-OriginalArrivalTime: 05 Aug 2005 17:20:19.0559 (UTC) FILETIME=[F4515770:01C599E1]
Content-class: urn:content-classes:message
Subject: Re: preempt with selinux NULL pointer dereference
Date: Fri, 5 Aug 2005 13:19:40 -0400
Message-ID: <Pine.LNX.4.61.0508051313050.5927@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: preempt with selinux NULL pointer dereference
thread-index: AcWZ4fRYVi+XlIXZTkmR/lR6rbLhpg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Antoine Martin" <antoine@nagafix.co.uk>
Cc: "James Morris" <jmorris@namei.org>, <linux-kernel@vger.kernel.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Antoine Martin wrote:

>>> [ 4788.218951] Unable to handle kernel NULL pointer dereference at 0000000000000028 RIP:
>>> [ 4788.218959] <ffffffff80247381>{inode_has_perm+81}
>>> [ 4788.218971] PGD 2485f067 PUD 0
>>> [ 4788.218975] Oops: 0000 [1] PREEMPT
>>> [ 4788.218977] CPU 0
>>> [ 4788.218979] Modules linked in: parport_pc lp parport eeprom i2c_sensor i2c_viapro i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod hotkey container tsdev usbhid yenta_socket rsrc_nonstatic uhci_hcd ehci_hcd shpchp via_ircc irda crc_ccitt
>>> [ 4788.218995] Pid: 19002, comm: ssh Tainted: G   M  2.6.13-rc5
>>
>> Which of your modules is non-GPL and can you please remove them and see if
>> there's still a problem?
> Hmm. I occasionally use out-of-tree drivers (wlan cards mainly) so I
> thought these could be the culprit, but all the above are in the source
> tree (I keep the others out):
> lsmod | awk '{print $1".ko"}' | sed 's+_+-+g' | xargs -n 1
> find /lib/modules/2.6.13-rc5 -type f -name
> /lib/modules/2.6.13-rc5/kernel/drivers/char/lp.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/parport/parport.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/i2c/chips/eeprom.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/i2c/i2c-sensor.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/i2c/busses/i2c-viapro.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/i2c/i2c-dev.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/i2c/i2c-core.ko
> /lib/modules/2.6.13-rc5/kernel/net/bluetooth/rfcomm/rfcomm.ko
> /lib/modules/2.6.13-rc5/kernel/net/bluetooth/l2cap.ko
> /lib/modules/2.6.13-rc5/kernel/net/bluetooth/bluetooth.ko
> /lib/modules/2.6.13-rc5/kernel/net/sunrpc/sunrpc.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/md/dm-mod.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/acpi/hotkey.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/acpi/container.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/input/tsdev.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/usb/input/usbhid.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/usb/host/uhci-hcd.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/usb/host/ehci-hcd.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/pci/hotplug/shpchp.ko
> /lib/modules/2.6.13-rc5/kernel/drivers/net/irda/via-ircc.ko
> /lib/modules/2.6.13-rc5/kernel/net/irda/irda.ko
> /lib/modules/2.6.13-rc5/kernel/lib/crc-ccitt.ko
> (iptables ones omitted)
>
> Is there an *easy* way to figure out what is tainting my kernel?

Check dmesg.

> I removed all I could (whilst leaving the machine usable):
> # lsmod
> Module                  Size  Used by
> tsdev                   8832  0
> usbhid                 48992  0
> uhci_hcd               36000  0
> parport_pc             44080  0
> parport                42444  1 parport_pc
> i2c_sensor              3840  0
> i2c_core               25048  1 i2c_sensor
> l2cap                  29704  2
> bluetooth              56516  3 l2cap
> sunrpc                163688  1
> ipt_REJECT              6464  1
> ipt_state               2368  3
> ip_conntrack           49812  1 ipt_state
> iptable_filter          3584  1
> ip_tables              24000  3 ipt_REJECT,ipt_state,iptable_filter
> yenta_socket           25804  4
> rsrc_nonstatic         13376  1 yenta_socket
> irda                  210924  0
> crc_ccitt               2560  1 irda
>

You need to make sure the non-GPL module is not installed.
In other words it doesn't do any good to remove it later.
The kernel will still report "Tainted".

> tsdev                   8832  0
   ^^^^___ This doesen't seem to be a "standard" module. Maybe
it doesn't have a GPL compatible "license string".

`strings ../wherever/tsdev.ko` | grep GPL .....


> # cat /proc/sys/kernel/tainted
> 16
> Even figuring out the definition of the 'tainted' masks took a bit of
> googling.
>
> Thanks
> Antoine
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
