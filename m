Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbUAQM52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 07:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUAQM51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 07:57:27 -0500
Received: from pengo.systems.pipex.net ([62.241.160.193]:57488 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S265881AbUAQM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 07:57:25 -0500
Date: Sat, 17 Jan 2004 13:00:34 +0000
From: James Stone <stone1@btinternet.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sound usb related kernel panic on reboot
Message-ID: <20040117130034.GA705@moon.base>
References: <20040116224446.GA758@moon.base>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040116224446.GA758@moon.base>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found the soultion to the problem. It was entirely unrelated to
the kernel- sorry!

I was running the kernel alsa modules but I had different versions of
the alsa tools and alsa lib installed. Although it _seemed_ to work, it
also led to the kernel panics on shutdown.

James


On Fri, Jan 16, 2004 at 10:44:46PM +0000, James Stone wrote:
> Please cc me with any replies.
> 
> I have been getting the already reported kernel panic on shutdown/reboot
> which seems to be related in some way to the modem_run userspace driver
> for the alcatel speedtouch modem. I have now noticed another one which
> is also related to USB in some way.. 
> 
> I have a midi keyboard (evolution MK-249C) attached via USB and when it
> is switched on, I get the kernel panic on shutdown. I can supply the
> full trace if required although it will require me writing it by hand as
> it does not seem to be recorded in any logs.
> 
> The output from /var/log/kernel is as follows:
> 
> Jan 16 19:17:18 moon kernel: agpgart: Putting AGP V2 device at 
> 0000:00:00.0 into 4x mode
> Jan 16 19:17:18 moon kernel: agpgart: Putting AGP V2 device at
> 0000:01:00.0 into 4x mode
> Jan 16 19:17:18 moon kernel: atkbd.c: Unknown key released (translated
> set 2, code 0x7a on isa0060/serio0).
> Jan 16 19:17:18 moon kernel: atkbd.c: Unknown key released (translated
> set 2, code 0x7a on isa0060/serio0).
> Jan 16 19:17:27 moon kernel: drivers/usb/core/usb.c: deregistering
> driver usb-storage
> Jan 16 19:17:27 moon kernel: drivers/usb/core/usb.c: deregistering
> driver visor
> Jan 16 19:17:27 moon kernel: drivers/usb/serial/usb-serial.c: USB
> Serial deregistering driver Handspring Visor / Palm OS
> Jan 16 19:17:27 moon kernel: drivers/usb/serial/usb-serial.c: USB
> Serial deregistering driver Sony Clie 3.5
> Jan 16 19:17:27 moon kernel: drivers/usb/core/usb.c: deregistering
> driver usbserial
> Jan 16 19:17:27 moon kernel: drivers/usb/core/usb.c: deregistering
> driver usblp
> Jan 16 19:17:27 moon kernel: uhci_hcd 0000:00:10.0: remove, state 1
> Jan 16 19:17:27 moon kernel: usb usb1: USB disconnect, address 1
> Jan 16 19:17:27 moon kernel: usb 1-2: USB disconnect, address 2
> Jan 16 19:17:27 moon kernel: uhci_hcd 0000:00:10.0: USB bus 1
> deregistered
> Jan 16 19:17:27 moon kernel: uhci_hcd 0000:00:10.1: remove, state 1
> Jan 16 19:17:27 moon kernel: usb usb2: USB disconnect, address 1
> Jan 16 19:17:27 moon kernel: usb 2-1: USB disconnect, address 2
> Jan 16 19:17:27 moon kernel: pci_pool_destroy 0000:00:10.1/uhci_td,
> ddb60000 busy
> Jan 16 19:17:27 moon kernel: pci_pool_destroy 0000:00:10.1/uhci_td,
> ddb5a000 busy
> Jan 16 19:17:27 moon kernel: uhci_hcd 0000:00:10.1: USB bus 2
> deregistered
> Jan 16 19:17:27 moon kernel: uhci_hcd 0000:00:10.2: remove, state 1
> Jan 16 19:17:27 moon kernel: usb usb3: USB disconnect, address 1
> Jan 16 19:17:27 moon kernel: uhci_hcd 0000:00:10.2: USB bus 3
> deregistered
> Jan 16 19:17:27 moon kernel: slab error in kmem_cache_destroy(): cache
> `uhci_urb_priv': Can't free all objects
> Jan 16 19:17:27 moon kernel: Call Trace:
> Jan 16 19:17:27 moon kernel:  [kmem_cache_destroy+152/288]
> kmem_cache_destroy+0x98/0x120
> Jan 16 19:17:27 moon kernel:  [_end+542256840/1069502828]
> uhci_hcd_cleanup+0x1c/0x5
> 9 [uhci_hcd]
> Jan 16 19:17:27 moon kernel:  [sys_delete_module+284/320]
> sys_delete_module+0x11c/0
> x140
> Jan 16 19:17:27 moon kernel:  [sys_munmap+68/112] sys_munmap+0x44/0x70
> Jan 16 19:17:27 moon kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jan 16 19:17:27 moon kernel: 
> Jan 16 19:17:27 moon kernel: uhci: not all urb_priv's were freed
> Jan 16 19:17:27 moon kernel: drivers/usb/core/usb.c: deregistering
> driver snd-usb-audio
> Jan 16 19:17:32 moon kernel: drivers/usb/core/usb.c: registered new
> driver snd-usb-audio
> Jan 16 19:17:33 moon kernel: drivers/usb/core/usb.c: deregistering
> driver snd-usb-audio
> Jan 16 19:17:35 moon kernel: Kernel logging (proc) stopped.
> Jan 16 19:17:35 moon kernel: Kernel log daemon terminating.
> 
> Regards,
> 
> James Stone
