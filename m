Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUD2KAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUD2KAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 06:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264021AbUD2KAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 06:00:20 -0400
Received: from prosun.first.gmd.de ([194.95.168.2]:20222 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262175AbUD2KAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 06:00:03 -0400
Subject: Re: 2.6.6-rc3 still oops on unplugging usb bluetooth bcm203x dongle
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1083218706.3942.5.camel@localhost>
References: <1083218706.3942.5.camel@localhost>
Content-Type: text/plain
Message-Id: <1083232795.3313.5.camel@localhost>
Mime-Version: 1.0
Date: Thu, 29 Apr 2004 11:59:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 08:05, Soeren Sonnenburg wrote:
> Hi...

Maybe that additional information helps...

That is when I one by one rmmod:

history | grep rmmod
 5703  rmmod bcm203x 
 5704  rmmod firmware_class 
 5705  rmmod rfcomm
 5706  rmmod l2cap
 5707  rmmod bluetooth 
 5709  rmmod hci_usb 

that is the lsmod before I rmmod hci_usb

lsmod
Module                  Size  Used by
hci_usb                13824  0 
bluetooth              55932  1 hci_usb

oops occurs after the rmmod hci_usb. looks to me as if the bluetooth
module is not happy with that.

usbcore: deregistering driver hci_usb
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C02134B4 LR: F2064414 SP: C5C2DD70 REGS: c5c2dcc0 TRAP: 0600    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 6B6B6BB7, DSISR: 00000120
TASK = e1c54cf0[3957] 'rmmod' THREAD: c5c2c000Last syscall: 129 
GPR00: FFFF0001 C5C2DD70 E1C54CF0 EE5A4244 EDFCF1DC 00000000 C12F09FC 00000000 
GPR08: FFFFFFF7 C113B2FC 00000001 C0213480 22000222 10019FF0 00000000 100C0000 
GPR16: 00000000 00000000 10204108 102044A8 10203068 101D81E8 10001400 00000000 
GPR24: 10000000 00000000 00000000 6B6B6B6B 6B6B6BB7 C8D0561C EE5A4244 EE5A4118 
NIP [c02134b4] class_device_del+0x34/0x140
LR [f2064414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
Call trace:
 [f2064414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
 [f205f76c] hci_unregister_dev+0x18/0xb0 [bluetooth]
 [f204ed94] hci_usb_disconnect+0x48/0x90 [hci_usb]
 [c0277a24] usb_unbind_interface+0x88/0x8c
 [c02125a4] device_release_driver+0x84/0x88
 [c02125d4] driver_detach+0x2c/0x50
 [c02128d0] bus_remove_driver+0x50/0xa8
 [c0212cb8] driver_unregister+0x18/0x78
 [c0277b20] usb_deregister+0x38/0x50
 [f204edf4] hci_usb_exit+0x18/0x4cc [hci_usb]
 [c003501c] sys_delete_module+0x1a4/0x224
 [c0005d60] ret_from_syscall+0x0/0x44

> I still get:
> 
> usb 2-1: USB disconnect, address 3
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: C02134B4 LR: F205D414 SP: EFE87DD0 REGS: efe87d20 TRAP: 0600    Not tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 6B6B6BB7, DSISR: 00000120
> TASK = effa4030[5] 'khubd' THREAD: efe86000Last syscall: -1 
> GPR00: FFFF0001 EFE87DD0 EFFA4030 EE77C828 6B6B6B6B 00000000 EB8EE83C 00000000 
> GPR08: 00001388 EF0EE858 00010C00 C0213480 82008022 00000000 00000000 00000000 
> GPR16: 00000000 00000000 00000000 00000000 00000000 00220000 00230000 00000000 
> GPR24: 00000000 C0400000 00000001 6B6B6B6B 6B6B6BB7 EF07B8A0 EE77C828 EE77C6FC 
> NIP [c02134b4] class_device_del+0x34/0x140
> LR [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
> Call trace:
>  [f205d414] hci_unregister_sysfs+0x14/0x24 [bluetooth]
>  [f205876c] hci_unregister_dev+0x18/0xb0 [bluetooth]
>  [f204cd94] hci_usb_disconnect+0x48/0x90 [hci_usb]
>  [c0277a24] usb_unbind_interface+0x88/0x8c
>  [c02125a4] device_release_driver+0x84/0x88
>  [c0212744] bus_remove_device+0x74/0xd0
>  [c0211120] device_del+0xa8/0x114
>  [c02111a4] device_unregister+0x18/0x30
>  [c027e248] usb_disable_device+0x9c/0xd8
>  [c0278768] usb_disconnect+0x9c/0x134
>  [c027ab14] hub_port_connect_change+0x294/0x298
>  [c027adec] hub_events+0x2d4/0x354
>  [c027aea8] hub_thread+0x3c/0xf0
>  [c00090b0] kernel_thread+0x44/0x60
> 
> Sometimes it helps to hciconfig hci0 down the bluetooth dongle + stop
> all programs + rmmod them... However also the
> rmmod hci_usb rfcomm bluetooth firmware_class bcm203x l2cap
> 
> is very likely to cause the same oops...
> 
> Yes, this is on powerpc but quite a number of people have the same issue
> on x86 (with 2.6.5 at least... and thats around the time this oops on
> unplugging appeared).
> 
> Any ideas ?
> Soeren

