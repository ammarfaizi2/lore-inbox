Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbTH3Xfu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbTH3Xfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:35:50 -0400
Received: from AMontsouris-108-1-16-60.w80-15.abo.wanadoo.fr ([80.15.145.60]:2688
	"EHLO paldrick.research.newtrade.nl") by vger.kernel.org with ESMTP
	id S262293AbTH3Xer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:34:47 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: Fredrik Noring <noring@nocrew.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab call trace
Date: Sun, 31 Aug 2003 01:36:01 +0200
User-Agent: KMail/1.5.1
References: <1062281812.3378.50.camel@h9n1fls20o980.bredband.comhem.se>
In-Reply-To: <1062281812.3378.50.camel@h9n1fls20o980.bredband.comhem.se>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       <linux-usb-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iTTU/XuDuVvUPrO"
Message-Id: <200308310136.02093.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_iTTU/XuDuVvUPrO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Does the attached patch help?

Alan, Johannes, did you have any further thoughts on this problem?
I'm still not sure what the best approach is.

Ciao,

Duncan.


On Sunday 31 August 2003 00:16, Fredrik Noring wrote:
> Hi,
>
> Bluetooth performance seems unreliable in 2.6.0-test4 with the Broadcom
> USB device (a5c/2001). Messages like these appear frequently in the log:
>
>      drivers/usb/host/uhci-hcd.c: d400: host controller process error.
> something bad happened
>      drivers/usb/host/uhci-hcd.c: d400: host controller halted. very bad
>
> Sometimes, messages like these also appear:
>
>      l2cap_recv_acldata: Frame is too short (len 1)
>      l2cap_recv_acldata: Unexpected continuation frame (len 124)
>
> After a while, the (hci0) interface crashes completely and becomes
> unusable. The hciconfig tool gives this error:
>
>      Can't read local name on hci0. Connection timed out(110)
>
> Detaching the device from the USB connector gives another crash and a
> "slab corruption", see call trace below.
>
> 	Fredrik
>
>
>
> Aug 30 21:19:53 h9n1fls20o980 kernel: drivers/usb/host/uhci-hcd.c: d400:
> host controller process error. something bad happened
> Aug 30 21:19:53 h9n1fls20o980 kernel: drivers/usb/host/uhci-hcd.c: d400:
> host controller halted. very bad
> Aug 30 21:20:25 h9n1fls20o980 last message repeated 33 times
> Aug 30 21:21:26 h9n1fls20o980 last message repeated 39 times
> Aug 30 21:22:27 h9n1fls20o980 last message repeated 85 times
> Aug 30 21:23:28 h9n1fls20o980 last message repeated 80 times
> Aug 30 21:24:10 h9n1fls20o980 last message repeated 41 times
> Aug 30 21:24:11 h9n1fls20o980 kernel: hci_cmd_task: hci0 command tx
> timeout
> Aug 30 21:24:11 h9n1fls20o980 kernel: drivers/usb/host/uhci-hcd.c: d400:
> host controller halted. very bad
> Aug 30 21:24:37 h9n1fls20o980 last message repeated 68 times
> Aug 30 21:24:37 h9n1fls20o980 kernel: usb 1-2: USB disconnect, address 4
> Aug 30 21:24:37 h9n1fls20o980 kernel: slab error in
> cache_free_debugcheck(): cache `size-512': double free, or memory before
> object was overwritten
> Aug 30 21:24:37 h9n1fls20o980 kernel: Call Trace:
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c013f046>] kfree+0x166/0x360
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e09836d9>]
> hci_usb_unlink_urbs+0x99/0x110 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e09836d9>]
> hci_usb_unlink_urbs+0x99/0x110 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e098378d>]
> hci_usb_close+0x3d/0x50 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e0984964>]
> hci_usb_disconnect+0x24/0x80 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088b168>]
> usb_unbind_interface+0x98/0xa0 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0201cd4>]
> device_release_driver+0x64/0x70
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0201e49>]
> bus_remove_device+0x79/0xc0
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0200d24>] device_del+0x74/0xa0
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0200d63>]
> device_unregister+0x13/0x30
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088bcdf>]
> usb_disconnect+0xef/0x120 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e378>]
> hub_port_connect_change+0x338/0x340 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088dbea>]
> hub_port_status+0x3a/0xb0 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e68a>]
> hub_events+0x30a/0x350 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e6fd>] hub_thread+0x2d/0xf0
> [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c010a99e>]
> ret_from_fork+0x6/0x14
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0119e60>]
> default_wake_function+0x0/0x30
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e6d0>] hub_thread+0x0/0xf0
> [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0108a85>]
> kernel_thread_helper+0x5/0x10
> Aug 30 21:24:37 h9n1fls20o980 kernel:
> Aug 30 21:24:37 h9n1fls20o980 kernel: slab error in
> cache_free_debugcheck(): cache `size-512': double free, or memory after
> object was overwritten
> Aug 30 21:24:37 h9n1fls20o980 kernel: Call Trace:
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c013f072>] kfree+0x192/0x360
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e09836d9>]
> hci_usb_unlink_urbs+0x99/0x110 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e09836d9>]
> hci_usb_unlink_urbs+0x99/0x110 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e098378d>]
> hci_usb_close+0x3d/0x50 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e0984964>]
> hci_usb_disconnect+0x24/0x80 [hci_usb]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088b168>]
> usb_unbind_interface+0x98/0xa0 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0201cd4>]
> device_release_driver+0x64/0x70
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0201e49>]
> bus_remove_device+0x79/0xc0
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0200d24>] device_del+0x74/0xa0
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0200d63>]
> device_unregister+0x13/0x30
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088bcdf>]
> usb_disconnect+0xef/0x120 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e378>]
> hub_port_connect_change+0x338/0x340 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088dbea>]
> hub_port_status+0x3a/0xb0 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e68a>]
> hub_events+0x30a/0x350 [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e6fd>] hub_thread+0x2d/0xf0
> [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c010a99e>]
> ret_from_fork+0x6/0x14
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0119e60>]
> default_wake_function+0x0/0x30
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<e088e6d0>] hub_thread+0x0/0xf0
> [usbcore]
> Aug 30 21:24:37 h9n1fls20o980 kernel:  [<c0108a85>]
> kernel_thread_helper+0x5/0x10
> Aug 30 21:24:37 h9n1fls20o980 kernel:
> Aug 30 21:24:37 h9n1fls20o980 kernel: ------------[ cut here
> ]------------
> Aug 30 21:24:37 h9n1fls20o980 kernel: kernel BUG at mm/slab.c:1659!
> Aug 30 21:24:37 h9n1fls20o980 kernel: invalid operand: 0000 [#1]
> Aug 30 21:24:37 h9n1fls20o980 kernel: CPU:    0
> Aug 30 21:24:37 h9n1fls20o980 kernel: EIP:    0060:[<c013f17d>]    Not
> tainted
> Aug 30 21:24:37 h9n1fls20o980 kernel: EFLAGS: 00010016
> Aug 30 21:24:37 h9n1fls20o980 kernel: EIP is at kfree+0x29d/0x360
> Aug 30 21:24:37 h9n1fls20o980 kernel: eax: d3e7c28c   ebx: 00010c00
> ecx: 0000020c   edx: 00000009
> Aug 30 21:24:37 h9n1fls20o980 kernel: esi: dfffb580   edi: d3e7c080
> ebp: d3e7c295   esp: dec29e50
> Aug 30 21:24:37 h9n1fls20o980 kernel: ds: 007b   es: 007b   ss: 0068
> Aug 30 21:24:37 h9n1fls20o980 kernel: Process khubd (pid: 78,
> threadinfo=dec28000 task=dec6ec80)
> Aug 30 21:24:37 h9n1fls20o980 kernel: Stack: c02bd20d dfffb580 c02cd6e0
> db903afc 00000208 e09836d9 dfff6190 00000286
> Aug 30 21:24:38 h9n1fls20o980 kernel:        db62f4d8 db62f4ec d485f4e4
> d485f4c4 e09836d9 d3e7c299 d485f4e4 00000000
> Aug 30 21:24:38 h9n1fls20o980 kernel:        d485f310 e0985e9c c17967d8
> e0985e20 e098378d d485f310 d485f310 e0984964
> Aug 30 21:24:38 h9n1fls20o980 kernel: Call Trace:
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e09836d9>]
> hci_usb_unlink_urbs+0x99/0x110 [hci_usb]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e09836d9>]
> hci_usb_unlink_urbs+0x99/0x110 [hci_usb]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e098378d>]
> hci_usb_close+0x3d/0x50 [hci_usb]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e0984964>]
> hci_usb_disconnect+0x24/0x80 [hci_usb]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088b168>]
> usb_unbind_interface+0x98/0xa0 [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c0201cd4>]
> device_release_driver+0x64/0x70
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c0201e49>]
> bus_remove_device+0x79/0xc0
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c0200d24>] device_del+0x74/0xa0
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c0200d63>]
> device_unregister+0x13/0x30
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088bcdf>]
> usb_disconnect+0xef/0x120 [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088e378>]
> hub_port_connect_change+0x338/0x340 [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088dbea>]
> hub_port_status+0x3a/0xb0 [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088e68a>]
> hub_events+0x30a/0x350 [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088e6fd>] hub_thread+0x2d/0xf0
> [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c010a99e>]
> ret_from_fork+0x6/0x14
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c0119e60>]
> default_wake_function+0x0/0x30
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<e088e6d0>] hub_thread+0x0/0xf0
> [usbcore]
> Aug 30 21:24:38 h9n1fls20o980 kernel:  [<c0108a85>]
> kernel_thread_helper+0x5/0x10
> Aug 30 21:24:38 h9n1fls20o980 kernel:
> Aug 30 21:24:38 h9n1fls20o980 kernel: Code: 0f 0b 7b 06 13 cb 2c c0 e9
> 26 ff ff ff 0f 0b 7a 06 13 cb 2c
> Aug 30 21:24:38 h9n1fls20o980 kernel:  <3>drivers/usb/host/uhci-hcd.c:
> d400: host controller halted. very bad
> Aug 30 21:24:38 h9n1fls20o980 kernel: drivers/usb/host/uhci-hcd.c: d400:
> host controller halted. very bad
> Aug 30 21:24:38 h9n1fls20o980 kernel: drivers/usb/host/uhci-hcd.c: d400:
> host controller halted. very bad
> Aug 30 21:25:14 h9n1fls20o980 kernel: hci_cmd_task: hci0 command tx
> timeout
> Aug 30 21:25:32 h9n1fls20o980 hcid[1025]: HCI dev 0 down
> Aug 30 21:25:32 h9n1fls20o980 hcid[1025]: Stoping security manager 0
> Aug 30 21:25:32 h9n1fls20o980 pppd[3458]: Hangup (SIGHUP)
> Aug 30 21:25:32 h9n1fls20o980 pppd[3458]: Modem hangup
> Aug 30 21:25:32 h9n1fls20o980 pppd[3458]: Connection terminated.
> Aug 30 21:25:32 h9n1fls20o980 pppd[3458]: Connect time 9.7 minutes.
> Aug 30 21:25:32 h9n1fls20o980 pppd[3458]: Sent 129231 bytes, received
> 904184 bytes.
> Aug 30 21:25:32 h9n1fls20o980 /etc/hotplug/net.agent: NET remove event
> not supported
> Aug 30 21:25:32 h9n1fls20o980 pppd[3458]: Exit.
> Aug 30 21:25:36 h9n1fls20o980 kernel: hci_usb_intr_rx_submit: hci0 intr
> rx submit failed urb cf7b2d20 err -19
> Aug 30 21:28:36 h9n1fls20o980 kernel: uhci-hcd 0000:00:09.0: remove,
> state 3
> Aug 30 21:28:36 h9n1fls20o980 kernel: usb usb1: USB disconnect, address
> 1
> Aug 30 21:56:57 h9n1fls20o980 kernel: Slab corruption: start=d3e7c49c,
> expend=d3e7c69b, problemat=d3e7c49d
> Aug 30 21:56:57 h9n1fls20o980 kernel: Last user:
> [<c0250ae3>](kfree_skbmem+0x13/0x30)
> Aug 30 21:56:57 h9n1fls20o980 kernel: Data: .D9 36 98 E0
> ***************************************************************************
>****************************************************************************
>****************************************************************************
>****************************************************************************
>****************************************************************************
>****************************************************************************
>***************************************************A5 Aug 30 21:56:57
> h9n1fls20o980 kernel: Next: 71 F0 2C .E3 0A 25 C0 A5 C2 0F 17 80 01 06 00
> 00 00 00 00 BC 00 A0 00 00 00 00 00 00 00 00 00
> Aug 30 21:56:57 h9n1fls20o980 kernel: slab error in check_poison_obj():
> cache `size-512': object was modified after freeing
> Aug 30 21:56:57 h9n1fls20o980 kernel: Call Trace:
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c013d398>]
> check_poison_obj+0x168/0x1b0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c013eba8>]
> __kmalloc+0x168/0x1d0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c02508e7>] alloc_skb+0x47/0xe0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c02508e7>] alloc_skb+0x47/0xe0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0250103>]
> sock_alloc_send_pskb+0xc3/0x1d0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c025023f>]
> sock_alloc_send_skb+0x2f/0x40
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c02ae232>]
> unix_stream_sendmsg+0x192/0x3b0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c01a4a56>]
> avc_has_perm+0x76/0x8c
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c024d18f>]
> sock_aio_write+0xef/0x100
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0153b2b>]
> do_sync_write+0x8b/0xc0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c01a58b9>]
> inode_has_perm+0x69/0xa0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0153c7d>]
> vfs_write+0x11d/0x150
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0153d62>] sys_write+0x42/0x70
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c010aa39>]
> sysenter_past_esp+0x52/0x71
> Aug 30 21:56:57 h9n1fls20o980 kernel:
> Aug 30 21:56:57 h9n1fls20o980 kernel: slab error in
> cache_alloc_debugcheck_after(): cache `size-512': memory before object
> was overwritten
> Aug 30 21:56:57 h9n1fls20o980 kernel: Call Trace:
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c013eb38>] __kmalloc+0xf8/0x1d0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c02508e7>] alloc_skb+0x47/0xe0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c02508e7>] alloc_skb+0x47/0xe0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0250103>]
> sock_alloc_send_pskb+0xc3/0x1d0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c025023f>]
> sock_alloc_send_skb+0x2f/0x40
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c02ae232>]
> unix_stream_sendmsg+0x192/0x3b0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c01a4a56>]
> avc_has_perm+0x76/0x8c
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c024d18f>]
> sock_aio_write+0xef/0x100
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0153b2b>]
> do_sync_write+0x8b/0xc0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c01a58b9>]
> inode_has_perm+0x69/0xa0
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0153c7d>]
> vfs_write+0x11d/0x150
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c0153d62>] sys_write+0x42/0x70
> Aug 30 21:56:57 h9n1fls20o980 kernel:  [<c010aa39>]
> sysenter_past_esp+0x52/0x71
> Aug 30 21:56:57 h9n1fls20o980 kernel:
> Aug 30 21:58:29 h9n1fls20o980 shutdown: shutting down for system reboot
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Boundary-00=_iTTU/XuDuVvUPrO
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="perror.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="perror.diff"

diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c	Fri Jul 18 13:22:32 2003
+++ b/drivers/usb/host/uhci-hcd.c	Fri Jul 18 13:22:32 2003
@@ -156,6 +156,7 @@
 	td->dev = dev;
 
 	INIT_LIST_HEAD(&td->list);
+	INIT_LIST_HEAD(&td->remove_list);
 	INIT_LIST_HEAD(&td->fl_list);
 
 	usb_get_dev(dev);
@@ -286,6 +287,8 @@
 {
 	if (!list_empty(&td->list))
 		dbg("td %p is still in list!", td);
+	if (!list_empty(&td->remove_list))
+		dbg("td %p still in remove_list!", td);
 	if (!list_empty(&td->fl_list))
 		dbg("td %p is still in fl_list!", td);
 
@@ -702,6 +705,7 @@
 {
 	struct list_head *head, *tmp;
 	struct urb_priv *urbp;
+	unsigned long flags;
 
 	urbp = (struct urb_priv *)urb->hcpriv;
 	if (!urbp)
@@ -713,6 +717,13 @@
 	if (!list_empty(&urbp->complete_list))
 		warn("uhci_destroy_urb_priv: urb %p still on uhci->complete_list", urb);
 
+	spin_lock_irqsave(&uhci->td_remove_list_lock, flags);
+
+	/* Check to see if the remove list is empty. Set the IOC bit */
+	/* to force an interrupt so we can remove the TD's*/
+	if (list_empty(&uhci->td_remove_list))
+		uhci_set_next_interrupt(uhci);
+
 	head = &urbp->td_list;
 	tmp = head->next;
 	while (tmp != head) {
@@ -722,9 +733,11 @@
 
 		uhci_remove_td_from_urb(td);
 		uhci_remove_td(uhci, td);
-		uhci_free_td(uhci, td);
+		list_add(&td->remove_list, &uhci->td_remove_list);
 	}
 
+	spin_unlock_irqrestore(&uhci->td_remove_list_lock, flags);
+
 	urb->hcpriv = NULL;
 	kmem_cache_free(uhci_up_cachep, urbp);
 }
@@ -1801,6 +1814,26 @@
 	spin_unlock_irqrestore(&uhci->qh_remove_list_lock, flags);
 }
 
+static void uhci_free_pending_tds(struct uhci_hcd *uhci)
+{
+	struct list_head *tmp, *head;
+	unsigned long flags;
+
+	spin_lock_irqsave(&uhci->td_remove_list_lock, flags);
+	head = &uhci->td_remove_list;
+	tmp = head->next;
+	while (tmp != head) {
+		struct uhci_td *td = list_entry(tmp, struct uhci_td, remove_list);
+
+		tmp = tmp->next;
+
+		list_del_init(&td->remove_list);
+
+		uhci_free_td(uhci, td);
+	}
+	spin_unlock_irqrestore(&uhci->td_remove_list_lock, flags);
+}
+
 static void uhci_finish_urb(struct usb_hcd *hcd, struct urb *urb, struct pt_regs *regs)
 {
 	struct urb_priv *urbp = (struct urb_priv *)urb->hcpriv;
@@ -1899,6 +1932,8 @@
 
 	uhci_free_pending_qhs(uhci);
 
+	uhci_free_pending_tds(uhci);
+
 	uhci_remove_pending_qhs(uhci);
 
 	uhci_clear_next_interrupt(uhci);
@@ -2200,6 +2235,9 @@
 	spin_lock_init(&uhci->qh_remove_list_lock);
 	INIT_LIST_HEAD(&uhci->qh_remove_list);
 
+	spin_lock_init(&uhci->td_remove_list_lock);
+	INIT_LIST_HEAD(&uhci->td_remove_list);
+
 	spin_lock_init(&uhci->urb_remove_list_lock);
 	INIT_LIST_HEAD(&uhci->urb_remove_list);
 
@@ -2415,11 +2453,13 @@
 	 * to this bus since there are no more parents
 	 */
 	uhci_free_pending_qhs(uhci);
+	uhci_free_pending_tds(uhci);
 	uhci_remove_pending_qhs(uhci);
 
 	reset_hc(uhci);
 
 	uhci_free_pending_qhs(uhci);
+	uhci_free_pending_tds(uhci);
 
 	release_uhci(uhci);
 }
diff -Nru a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
--- a/drivers/usb/host/uhci-hcd.h	Fri Jul 18 13:22:32 2003
+++ b/drivers/usb/host/uhci-hcd.h	Fri Jul 18 13:22:32 2003
@@ -190,6 +190,7 @@
 	struct urb *urb;
 
 	struct list_head list;		/* P: urb->lock */
+	struct list_head remove_list;	/* P: uhci->td_remove_list_lock */
 
 	int frame;			/* for iso: what frame? */
 	struct list_head fl_list;	/* P: uhci->frame_list_lock */
@@ -349,6 +350,10 @@
 	/* List of QH's that are done, but waiting to be unlinked (race) */
 	spinlock_t qh_remove_list_lock;
 	struct list_head qh_remove_list;	/* P: uhci->qh_remove_list_lock */
+
+	/* List of TD's that are done, but waiting to be freed (race) */
+	spinlock_t td_remove_list_lock;
+	struct list_head td_remove_list;	/* P: uhci->td_remove_list_lock */
 
 	/* List of asynchronously unlinked URB's */
 	spinlock_t urb_remove_list_lock;




--Boundary-00=_iTTU/XuDuVvUPrO--
