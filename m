Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJVUGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJVUGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJVUE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:04:27 -0400
Received: from hal-5.inet.it ([213.92.5.24]:19166 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S266096AbUJVT71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:59:27 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1 usb oopses
Date: Fri, 22 Oct 2004 21:59:20 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YaWeB407y40G0HG"
Message-Id: <200410222159.20614.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_YaWeB407y40G0HG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Noticed in 2.6.9-rc4-mm1, still present in 2.6.9-mm1:
When a usb flash memory key is inserted, I get this report on syslog:

Oct 22 21:40:04 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Oct 22 21:40:04 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Oct 22 21:40:04 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Oct 22 21:40:04 kefk kernel: hub 5-0:1.0: port 3 not reset yet, waiting 50ms
Oct 22 21:40:04 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Oct 22 21:40:04 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Oct 22 21:40:04 kefk kernel: usb 5-3: new high speed USB device using address 
6
Oct 22 21:40:04 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Oct 22 21:40:04 kefk kernel: usb 5-3: default language 0x0409
Oct 22 21:40:04 kefk kernel: usb 5-3: Product: Mass storage
Oct 22 21:40:04 kefk kernel: usb 5-3: Manufacturer: USB
Oct 22 21:40:04 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Oct 22 21:40:04 kefk kernel: usb 5-3: hotplug
Oct 22 21:40:04 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Oct 22 21:40:04 kefk kernel: usb 5-3:1.0: hotplug
Oct 22 21:40:05 kefk kernel: ub: sizeof ub_scsi_cmd 64 ub_dev 964
Oct 22 21:40:05 kefk kernel: ub 5-3:1.0: usb_probe_interface
Oct 22 21:40:05 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
Oct 22 21:40:05 kefk kernel: uba: device 6 capacity nsec 50 bsize 512
Oct 22 21:40:05 kefk kernel: uba: made changed
Oct 22 21:40:05 kefk kernel: uba: device 6 capacity nsec 1024000 bsize 512
Oct 22 21:40:05 kefk kernel: uba: device 6 capacity nsec 1024000 bsize 512
Oct 22 21:40:05 kefk kernel:  uba: uba1
Oct 22 21:40:05 kefk kernel:  uba: uba1
Oct 22 21:40:05 kefk kernel: kobject_register failed for uba1 (-17)
Oct 22 21:40:05 kefk kernel:  [<c01f1f77>] kobject_register+0x51/0x5f
Oct 22 21:40:05 kefk kernel:  [<c018467c>] add_partition+0xbb/0xf0
Oct 22 21:40:05 kefk kernel:  [<c01847f4>] register_disk+0xee/0x11d
Oct 22 21:40:05 kefk kernel:  [<c024b8e6>] add_disk+0x36/0x41
Oct 22 21:40:05 kefk kernel:  [<c024b89c>] exact_match+0x0/0x7
Oct 22 21:40:05 kefk kernel:  [<c024b8a3>] exact_lock+0x0/0xd
Oct 22 21:40:05 kefk kernel:  [<f8c48e70>] ub_probe+0x291/0x2f4 [ub]
Oct 22 21:40:05 kefk kernel:  [<c0298f0e>] usb_probe_interface+0xb8/0xe1
Oct 22 21:40:05 kefk kernel:  [<c0243274>] bus_match+0x32/0x6a
Oct 22 21:40:05 kefk kernel:  [<c024339c>] driver_attach+0x46/0x85
Oct 22 21:40:05 kefk kernel:  [<c01f1f48>] kobject_register+0x22/0x5f
Oct 22 21:40:05 kefk kernel:  [<c0243800>] bus_add_driver+0x91/0xcb
Oct 22 21:40:05 kefk kernel:  [<c0298fe0>] usb_register+0x49/0x9f
Oct 22 21:40:05 kefk kernel:  [<f8c4d03f>] ub_init+0x3f/0x5f [ub]
Oct 22 21:40:05 kefk kernel:  [<c0131de7>] sys_init_module+0x160/0x246
Oct 22 21:40:05 kefk kernel:  [<c0103d71>] sysenter_past_esp+0x52/0x71
Oct 22 21:40:05 kefk kernel: usbcore: registered new driver ub

After that, uba appears as /dev/uba, but /dev/uba1 is missing. I can create by 
hand /dev/uba1 and access data on flash key, but if I umount and then remove 
the key I get this oops:


Oct 22 21:45:05 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Oct 22 21:45:05 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Oct 22 21:45:05 kefk kernel: usb 5-3: USB disconnect, address 6
Oct 22 21:45:05 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Oct 22 21:45:05 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Oct 22 21:45:05 kefk kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000050
Oct 22 21:45:05 kefk kernel:  printing eip:
Oct 22 21:45:05 kefk kernel: c01862cf
Oct 22 21:45:05 kefk kernel: *pde = 00000000
Oct 22 21:45:05 kefk kernel: Oops: 0000 [#1]
Oct 22 21:45:05 kefk kernel: PREEMPT SMP
Oct 22 21:45:05 kefk kernel: Modules linked in: nls_cp437 lp parport_pc ub 
hidp hci_usb snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul nvidia tun md5 ipv6 rfcomm l2cap bluetooth snd_seq_oss 
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi 
snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem 
snd_hwdep snd soundcore ipt_REJECT iptable_filter ip_tables loop nls_utf8 
ide_cd i2c_dev w83
781d i2c_sensor i2c_isa i2c_i801 isofs zlib_inflate e1000 ppa parport ehci_hcd 
usblp uhci_hcd genrtc
Oct 22 21:45:05 kefk kernel: CPU:    1
Oct 22 21:45:05 kefk kernel: EIP:    0060:[<c01862cf>]    Tainted: P      VLI
Oct 22 21:45:05 kefk kernel: EFLAGS: 00010246   (2.6.9-mm1)
Oct 22 21:45:05 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0xef
Oct 22 21:45:05 kefk kernel: eax: cf85c308   ebx: cf85c308   ecx: c18ff480   
edx: c1000000
Oct 22 21:45:05 kefk kernel: esi: edce7c00   edi: 00000000   ebp: 00000246   
esp: c1bace20
Oct 22 21:45:05 kefk kernel: ds: 007b   es: 007b   ss: 0068
Oct 22 21:45:05 kefk kernel: Process khubd (pid: 125, threadinfo=c1bac000 
task=c1baba40)
Oct 22 21:45:05 kefk kernel: Stack: 00000000 cf85c308 edce7c00 00000001 
00000246 c01f2087 cf85c308 c01f2097
Oct 22 21:45:05 kefk kernel:        cca37180 c01849fc 00000000 edce7c00 
00000000 00000246 f8c48ff1 dc3ac848
Oct 22 21:45:05 kefk kernel:        0000003c 00000003 cca37294 f74ff02c 
cca37180 cca37280 f8c4b220 c86ad000
Oct 22 21:45:05 kefk kernel: Call Trace:
Oct 22 21:45:05 kefk kernel:  [<c01f2087>] kobject_del+0x14/0x1c
Oct 22 21:45:05 kefk kernel:  [<c01f2097>] kobject_unregister+0x8/0x10
Oct 22 21:45:05 kefk kernel:  [<c01849fc>] del_gendisk+0x1d/0xd5
Oct 22 21:45:05 kefk kernel:  [<f8c48ff1>] ub_disconnect+0x11e/0x171 [ub]
Oct 22 21:45:05 kefk kernel:  [<c0298f95>] usb_unbind_interface+0x5e/0x60
Oct 22 21:45:05 kefk kernel:  [<c0243431>] device_release_driver+0x56/0x58
Oct 22 21:45:05 kefk kernel:  [<c0243637>] bus_remove_device+0x53/0x90
Oct 22 21:45:05 kefk kernel:  [<c0242752>] device_del+0x54/0x91
Oct 22 21:45:05 kefk kernel:  [<c02a0ac3>] usb_disable_device+0xda/0x147
Oct 22 21:45:05 kefk kernel:  [<c029b7ab>] usb_disconnect+0xab/0x198
Oct 22 21:45:05 kefk kernel:  [<c029ca61>] hub_port_connect_change+0x2ce/0x47b
Oct 22 21:45:05 kefk kernel:  [<c029cee2>] hub_events+0x2d4/0x4ac
Oct 22 21:45:05 kefk kernel:  [<c029d0ef>] hub_thread+0x35/0x10e
Oct 22 21:45:05 kefk kernel:  [<c0115155>] finish_task_switch+0x3b/0x87
Oct 22 21:45:05 kefk kernel:  [<c012d9ad>] autoremove_wake_function+0x0/0x43
Oct 22 21:45:05 kefk kernel:  [<c0103ca6>] ret_from_fork+0x6/0x14
Oct 22 21:45:05 kefk kernel:  [<c012d9ad>] autoremove_wake_function+0x0/0x43
Oct 22 21:45:05 kefk kernel:  [<c029d0ba>] hub_thread+0x0/0x10e
Oct 22 21:45:05 kefk kernel:  [<c0102025>] kernel_thread_helper+0x5/0xb
Oct 22 21:45:05 kefk kernel: Code: 02 4c 32 c0 e9 4d ff ff ff e9 23 ff ff ff 
55 57 56 53 83 ec 04 8b 78 30 85 ff 74 0d 8b 07 85 c0 0f 84 ca 00 00 00 f0 ff 
07 85 ff <8b> 57 50 0f 84 b4 00 00 00 8b 47 10 8d 48 78 f0 ff 48 78 0f 88


After this, usb stack is unable to detect other usb devices insertions.

system: P IV 2.8 HT, smp/t+preempt, i875p (abit ic7g) 1Gb ram.
flash key: usb 2.0 flash drive, 512 MB

I can provide more details/testing if needed, config.gz attached.



-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

--Boundary-00=_YaWeB407y40G0HG
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

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

--Boundary-00=_YaWeB407y40G0HG--
