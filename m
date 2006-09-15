Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWIOWIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWIOWIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWIOWIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:08:05 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:662 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S932309AbWIOWIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:08:02 -0400
Date: Fri, 15 Sep 2006 18:07:47 -0400
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.18-rc5-mm1 USB BUG: atomic counter underflow
To: linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20060915220747.GA23572@pool-71-123-67-65.wma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having lots of USB problems, mainly failure to recognize,
and sometimes a hard krenel freeze. I'm using one active extension and
an external hub at the moment, though I've used a variety of setups.

My procsesor is an Athlon XP, and uname says: 2.6.18-rc5-mm1 #1
PREEMPT Wed Sep 6 13:46:26 EDT 2006 i686 unknown

While powering-cycling two devices simultaneously, I got the following
in dmesg. Since the system's still up, here it is for your reading
pleasure. I'll be happy to provide more information or experiment.

-Eric

--------------------------------------------------------------
[520695.301449] usb 2-4.4.1: USB disconnect, address 12
[520695.803888] usb 2-4.4.1: new high speed USB device using ehci_hcd and address 14
[520695.916563] usb 2-4.4.1: device descriptor read/all, error -71
[520696.003759] usb 2-4.4.1: new high speed USB device using ehci_hcd and address 15
[520696.122290] usb 2-4.4.2: USB disconnect, address 13
[520696.160162] usb 2-4.4.1: new device found, idVendor=0c0b, idProduct=b001
[520696.160170] usb 2-4.4.1: new device strings: Mfr=73, Product=77, SerialNumber=101
[520696.160174] usb 2-4.4.1: Product: USB 2.0 Storage Adaptor
[520696.160177] usb 2-4.4.1: Manufacturer: DMI
[520696.160180] usb 2-4.4.1: SerialNumber: 0B02014205299A98
[520696.268447] usb 2-4.4.1: configuration #2 chosen from 1 choice
[520696.291317] scsi11 : SCSI emulation for USB Mass Storage devices
[520696.307889] usb-storage: device found at 15
[520696.307894] usb-storage: waiting for device to settle before scanning
[520696.763543] usb 2-4.4.2: new high speed USB device using ehci_hcd and address 16
[520696.872051] usb 2-4.4.2: new device found, idVendor=04b4, idProduct=6830
[520696.872059] usb 2-4.4.2: new device strings: Mfr=56, Product=78, SerialNumber=100
[520696.872063] usb 2-4.4.2: Product: USB2.0 Storage Device
[520696.872066] usb 2-4.4.2: Manufacturer: Cypress Semiconductor
[520696.872069] usb 2-4.4.2: SerialNumber: DEF1073973FF
[520696.987428] usb 2-4.4.2: configuration #1 chosen from 1 choice
[520696.987845] scsi12 : SCSI emulation for USB Mass Storage devices
[520697.013028] usb-storage: device found at 16
[520697.013033] usb-storage: waiting for device to settle before scanning
[520702.009762] scsi 12:0:0:0: CD-ROM            _NEC     DVD_RW ND-3540A  1.01 PQ: 0 ANSI: 0
[520702.024233] sr0: scsi3-mmc drive: 40x/48x writer cd/rw xa/form2 cdda tray
[520702.043783] sr 12:0:0:0: Attached scsi CD-ROM sr0
[520702.081526] sr 12:0:0:0: Attached scsi generic sg0 type 5
[520702.082790] usb-storage: device scan complete
[520706.889684] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
[520717.207982] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
[520722.501044] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
[520728.093909] usb 2-4.4.1: reset high speed USB device using ehci_hcd and address 15
[520728.181851] usb 2-4.4.1: device descriptor read/64, error -71
[520728.409439] usb 2-4.4.1: device firmware changed
[520728.409593] scsi 11:0:0:0: scsi: Device offlined - not ready after error recovery
[520728.409932] usb 2-4.4.1: USB disconnect, address 15
[520728.412043] usb-storage: device scan complete
[520728.617566] usb 2-4.4.1: new high speed USB device using ehci_hcd and address 17
[520728.742596] usb 2-4.4.1: unable to read config index 0 descriptor/all
[520728.742605] usb 2-4.4.1: can't read configurations, error -71
[520800.449134] usb 2-4.4.1: USB disconnect, address 17
[520800.449147] BUG: atomic counter underflow at:
[520800.449362]  [<c0103b7c>] dump_trace+0x64/0x1a8
[520800.449394]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.449414]  [<c01042a1>] show_trace+0xd/0x10
[520800.449433]  [<c01042e8>] dump_stack+0x19/0x1b
[520800.449452]  [<c026a5ca>] kref_put+0x56/0x74
[520800.450284]  [<c03c5b9f>] klist_dec_and_del+0x10/0x12
[520800.451799]  [<c03c5c16>] klist_del+0x13/0x2b
[520800.453813]  [<c02ba723>] device_del+0x1d/0x15f
[520800.454930]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.455006]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.455032]  [<c0127266>] kthread+0xb0/0xde
[520800.455186]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.455209] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[520800.455212] 
[520800.455214] Leftover inexact backtrace:
[520800.455216] 
[520800.455218]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.455223]  [<c01042a1>] show_trace+0xd/0x10
[520800.455228]  [<c01042e8>] dump_stack+0x19/0x1b
[520800.455232]  [<c026a5ca>] kref_put+0x56/0x74
[520800.455239]  [<c03c5b9f>] klist_dec_and_del+0x10/0x12
[520800.455249]  [<c03c5c16>] klist_del+0x13/0x2b
[520800.455253]  [<c02ba723>] device_del+0x1d/0x15f
[520800.455261]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.455280]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.455298]  [<c0127266>] kthread+0xb0/0xde
[520800.455302]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.455307]  =======================
[520800.455332] BUG: atomic counter underflow at:
[520800.455490]  [<c0103b7c>] dump_trace+0x64/0x1a8
[520800.455509]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.455528]  [<c01042a1>] show_trace+0xd/0x10
[520800.455547]  [<c01042e8>] dump_stack+0x19/0x1b
[520800.455566]  [<c026a5ca>] kref_put+0x56/0x74
[520800.456391]  [<c03c5b9f>] klist_dec_and_del+0x10/0x12
[520800.457963]  [<c03c5d76>] klist_remove+0x17/0x39
[520800.459681]  [<c02bbbb8>] bus_remove_device+0x56/0x6c
[520800.460774]  [<c02ba837>] device_del+0x131/0x15f
[520800.461923]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.461991]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.462016]  [<c0127266>] kthread+0xb0/0xde
[520800.462171]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.462193] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[520800.462196] 
[520800.462198] Leftover inexact backtrace:
[520800.462200] 
[520800.462203]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.462208]  [<c01042a1>] show_trace+0xd/0x10
[520800.462212]  [<c01042e8>] dump_stack+0x19/0x1b
[520800.462216]  [<c026a5ca>] kref_put+0x56/0x74
[520800.462223]  [<c03c5b9f>] klist_dec_and_del+0x10/0x12
[520800.462234]  [<c03c5d76>] klist_remove+0x17/0x39
[520800.462239]  [<c02bbbb8>] bus_remove_device+0x56/0x6c
[520800.462248]  [<c02ba837>] device_del+0x131/0x15f
[520800.462253]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.462272]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.462289]  [<c0127266>] kthread+0xb0/0xde
[520800.462294]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.462298]  =======================
[520800.462316] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
[520800.462320]  printing eip:
[520800.462323] c03c67be
[520800.462325] *pde = 00000000
[520800.462329] Oops: 0002 [#1]
[520800.462331] 8K_STACKS PREEMPT 
[520800.462335] last sysfs file: /devices/pci0000:00/0000:00:10.3/usb2/product
[520800.462338] Modules linked in: ppp_synctty ppp_async crc_ccitt ppp_generic slhc eth1394 r128 softdog keyspan_pda usbserial capability commoncap sch_tbf raw1394 dv1394 ohci1394 ieee1394 snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd_i2c snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sg usbnet tsdev usb_storage usbhid ff_memless joydev ohci_hcd uhci_hcd ehci_hcd ipt_tos ipt_owner iptable_nat ipt_MASQUERADE ip_nat ip_conntrack nfnetlink ipt_TOS iptable_filter iptable_mangle ip_tables x_tables b44 de2104x tulip 8139too mii usbmouse usbcore psmouse via drm via_agp agpgart ide_scsi
[520800.462377] CPU:    0
[520800.462379] EIP:    0060:[<c03c67be>]    Not tainted VLI
[520800.462381] EFLAGS: 00010002   (2.6.18-rc5-mm1 #1) 
[520800.462386] EIP is at wait_for_completion+0x5d/0xeb
[520800.462390] eax: d76b80b4   ebx: d76b80b0   ecx: 00000000   edx: f7ac5ee0
[520800.462395] esi: d76b8058   edi: f7ac5ee8   ebp: f7ac5ef0   esp: f7ac5ed4
[520800.462399] ds: 007b   es: 007b   ss: 0068
[520800.462403] Process khubd (pid: 724, ti=f7ac4000 task=f7ad5550 task.ti=f7ac4000)
[520800.462406] Stack: 00000001 f7ad5550 c0113e41 d76b80b4 00000000 d76b80a0 d76b8000 f7ac5efc 
[520800.462414]        c03c5d94 d76b80c0 f7ac5f0c c02bbbb8 d76b80c0 d76b8058 f7ac5f24 c02ba837 
[520800.462422]        f6099458 d76b8058 00000010 d76b8000 f7ac5f3c f89b7f19 f6099664 00000101 
[520800.462430] Call Trace:
[520800.462499]  [<c03c5d94>] klist_remove+0x35/0x39
[520800.464168]  [<c02bbbb8>] bus_remove_device+0x56/0x6c
[520800.465257]  [<c02ba837>] device_del+0x131/0x15f
[520800.466337]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.466403]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.466429]  [<c0127266>] kthread+0xb0/0xde
[520800.466583]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.466603] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[520800.466608] 
[520800.466610] Leftover inexact backtrace:
[520800.466612] 
[520800.466614]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.466619]  [<c0103d6f>] show_stack_log_lvl+0x8a/0x95
[520800.466624]  [<c0103ecf>] show_registers+0x155/0x1e6
[520800.466628]  [<c010410b>] die+0x1ab/0x26d
[520800.466633]  [<c01120f9>] do_page_fault+0x429/0x4f6
[520800.466642]  [<c03c8031>] error_code+0x39/0x40
[520800.466648]  [<c03c5d94>] klist_remove+0x35/0x39
[520800.466657]  [<c02bbbb8>] bus_remove_device+0x56/0x6c
[520800.466667]  [<c02ba837>] device_del+0x131/0x15f
[520800.466671]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.466690]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.466708]  [<c0127266>] kthread+0xb0/0xde
[520800.466713]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.466717]  =======================
[520800.466719] Code: 8d 55 f0 ab ab ab ab ab 89 e0 25 00 e0 ff ff 8b 00 83 4d e4 01 c7 45 ec 41 3e 11 c0 89 45 e8 8d 43 04 8b 48 04 89 45 f0 89 50 04 <89> 11 89 4d f4 89 e0 25 00 e0 ff ff 8b 10 c7 02 02 00 00 00 fb 
[520800.466748] EIP: [<c03c67be>] wait_for_completion+0x5d/0xeb SS:ESP 0068:f7ac5ed4
[520800.466756]  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
[520800.466763] in_atomic():1, irqs_disabled():1
[520800.466902]  [<c0103b7c>] dump_trace+0x64/0x1a8
[520800.466921]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.466940]  [<c01042a1>] show_trace+0xd/0x10
[520800.466959]  [<c01042e8>] dump_stack+0x19/0x1b
[520800.466978]  [<c01133be>] __might_sleep+0x8d/0x95
[520800.467045]  [<c0129e5a>] down_read+0x15/0x1e
[520800.467163]  [<c0121fe8>] blocking_notifier_call_chain+0x11/0x2d
[520800.467262]  [<c0118254>] profile_task_exit+0x11/0x13
[520800.467340]  [<c0119810>] do_exit+0x1c/0x7e7
[520800.467417]  [<c01041c5>] die+0x265/0x26d
[520800.467437]  [<c01120f9>] do_page_fault+0x429/0x4f6
[520800.467500]  [<c03c8031>] error_code+0x39/0x40
[520800.467514] DWARF2 unwinder stuck at error_code+0x39/0x40
[520800.467517] 
[520800.467519] Leftover inexact backtrace:
[520800.467521] 
[520800.467523]  [<c0103cd2>] show_trace_log_lvl+0x12/0x25
[520800.467527]  [<c01042a1>] show_trace+0xd/0x10
[520800.467532]  [<c01042e8>] dump_stack+0x19/0x1b
[520800.467536]  [<c01133be>] __might_sleep+0x8d/0x95
[520800.467540]  [<c0129e5a>] down_read+0x15/0x1e
[520800.467545]  [<c0121fe8>] blocking_notifier_call_chain+0x11/0x2d
[520800.467551]  [<c0118254>] profile_task_exit+0x11/0x13
[520800.467555]  [<c0119810>] do_exit+0x1c/0x7e7
[520800.467560]  [<c01041c5>] die+0x265/0x26d
[520800.467564]  [<c01120f9>] do_page_fault+0x429/0x4f6
[520800.467570]  [<c03c8031>] error_code+0x39/0x40
[520800.467574]  [<c03c5d94>] klist_remove+0x35/0x39
[520800.467579]  [<c02bbbb8>] bus_remove_device+0x56/0x6c
[520800.467584]  [<c02ba837>] device_del+0x131/0x15f
[520800.467588]  [<f89b7f19>] usb_disconnect+0x9b/0xe1 [usbcore]
[520800.467608]  [<f89b8945>] hub_thread+0x35f/0x9be [usbcore]
[520800.467626]  [<c0127266>] kthread+0xb0/0xde
[520800.467630]  [<c010389f>] kernel_thread_helper+0x7/0x10
[520800.467634]  =======================
[520800.467640] note: khubd[724] exited with preempt_count 1
