Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUJaWLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUJaWLf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbUJaWLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:11:35 -0500
Received: from hal-5.inet.it ([213.92.5.24]:9108 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261491AbUJaWL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:11:28 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: k 2.6.9: ub module causes /dev/sda and /dev/sda1 not being created
Date: Sun, 31 Oct 2004 23:10:43 +0100
User-Agent: KMail/1.7.1
Cc: Paulo da Silva <psdasilva@esoterica.pt>, linux-kernel@vger.kernel.org
References: <mailman.1099103401.11097.linux-kernel2news@redhat.com> <20041030091522.6f2da605@lembas.zaitcev.lan>
In-Reply-To: <20041030091522.6f2da605@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410312310.43557.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 18:15, sabato 30 ottobre 2004, Pete Zaitcev ha scritto:
> On Sat, 30 Oct 2004 03:19:41 +0100, Paulo da Silva <psdasilva@esoterica.pt> 
wrote:
> > I had problems with my pen drive.
> > Module ub (autolodaded) recognized the pendrive. So /dev/sda
> > and /dev/sda1 didn't get created. After removing ub module
> > from kernel config I could mount the pen drive as /dev/sda1.
>
> This is intentional. The ub takes over certain functions of usb-storage
> when it is configured in. Is it a problem? If yes, why?

Maybe this is not a problem, but it's supposed that a /dev/uba1 is created, 
after /dev/uba, instead of sdaX? well, on my system uba is created but 
not /dev/uba1, and I've reported below a syslog excerpt for usb flash 
pendrive; after that is still possible to mknod a uba1 device, and access the 
pendrive, but after the pendrive is removed I get an oops and then usb layer 
stops to work.

Insertion:

(linux 2.6.10-rc1-mm1, but seen also in 2.6.9-mm1 and 2.6.9-rc4-mm1)
Oct 28 00:32:22 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Oct 28 00:32:22 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Oct 28 00:32:22 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Oct 28 00:32:22 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Oct 28 00:32:22 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Oct 28 00:32:22 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 4
Oct 28 00:32:22 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Oct 28 00:32:22 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Oct 28 00:32:22 kefk kernel: usb 5-3: ep0 maxpacket = 64
Oct 28 00:32:22 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Oct 28 00:32:22 kefk kernel: usb 5-3: default language 0x0409
Oct 28 00:32:22 kefk kernel: usb 5-3: Product: Mass storage
Oct 28 00:32:22 kefk kernel: usb 5-3: Manufacturer: USB
Oct 28 00:32:22 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Oct 28 00:32:22 kefk kernel: usb 5-3: hotplug
Oct 28 00:32:22 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Oct 28 00:32:22 kefk kernel: usb 5-3:1.0: hotplug
Oct 28 00:32:22 kefk kernel: ub: sizeof ub_scsi_cmd 64 ub_dev 964
Oct 28 00:32:22 kefk kernel: ub 5-3:1.0: usb_probe_interface
Oct 28 00:32:22 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 50 bsize 512
Oct 28 00:32:22 kefk kernel: uba: made changed
Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 1024000 bsize 512
Oct 28 00:32:22 kefk kernel: uba: device 4 capacity nsec 1024000 bsize 512
Oct 28 00:32:22 kefk kernel:  uba: uba1
Oct 28 00:32:22 kefk kernel:  uba: uba1
Oct 28 00:32:22 kefk kernel: kobject_register failed for uba1 (-17)
Oct 28 00:32:22 kefk kernel:  [<c01f1fd7>] kobject_register+0x51/0x5f
Oct 28 00:32:22 kefk kernel:  [<c0184720>] add_partition+0xbb/0xf0
Oct 28 00:32:22 kefk kernel:  [<c0184898>] register_disk+0xee/0x11d
Oct 28 00:32:22 kefk kernel:  [<c024ba2e>] add_disk+0x36/0x41
Oct 28 00:32:22 kefk kernel:  [<c024b9e4>] exact_match+0x0/0x7
Oct 28 00:32:22 kefk kernel:  [<c024b9eb>] exact_lock+0x0/0xd
Oct 28 00:32:22 kefk kernel:  [<f8b3ce70>] ub_probe+0x291/0x2f4 [ub]
Oct 28 00:32:22 kefk kernel:  [<c02981e6>] usb_probe_interface+0xb8/0xe1
Oct 28 00:32:22 kefk kernel:  [<c02435a8>] bus_match+0x32/0x6a
Oct 28 00:32:22 kefk kernel:  [<c02436d0>] driver_attach+0x46/0x85
Oct 28 00:32:22 kefk kernel:  [<c01f1fa8>] kobject_register+0x22/0x5f
Oct 28 00:32:22 kefk kernel:  [<c0243b34>] bus_add_driver+0x91/0xcb
Oct 28 00:32:22 kefk kernel:  [<c02982b8>] usb_register+0x49/0x9f
Oct 28 00:32:22 kefk kernel:  [<f89ad03f>] ub_init+0x3f/0x5f [ub]
Oct 28 00:32:22 kefk kernel:  [<c0131dfb>] sys_init_module+0x160/0x246
Oct 28 00:32:22 kefk kernel:  [<c0103d69>] sysenter_past_esp+0x52/0x71
Oct 28 00:32:22 kefk kernel: usbcore: registered new driver ub

Removal:

Oct 28 00:32:33 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Oct 28 00:32:33 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Oct 28 00:32:33 kefk kernel: usb 5-3: USB disconnect, address 4
Oct 28 00:32:33 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Oct 28 00:32:33 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Oct 28 00:32:33 kefk kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000050
Oct 28 00:32:33 kefk kernel:  printing eip:
Oct 28 00:32:33 kefk kernel: c0186373
Oct 28 00:32:33 kefk kernel: *pde = 00000000
Oct 28 00:32:33 kefk kernel: Oops: 0000 [#1]
Oct 28 00:32:33 kefk kernel: PREEMPT SMP
Oct 28 00:32:33 kefk kernel: Modules linked in: ub tun md5 ipv6 rfcomm l2cap 
bluetooth snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss 
snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer 
snd_page_alloc snd_util_mem snd_hwdep snd soundcore lp ipt_REJECT 
iptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev w83781d i2c_sensor 
i2c_isa i2c_i801 nvidia isofs zlib_inflate e1000 parport_pc ppa parport usblp 
ehci_hcd uhci_hcd genrtc
Oct 28 00:32:33 kefk kernel: CPU:    0
Oct 28 00:32:33 kefk kernel: EIP:    0060:[<c0186373>]    Tainted: P      VLI
Oct 28 00:32:33 kefk kernel: EFLAGS: 00010246   (2.6.10-rc1-mm1)
Oct 28 00:32:33 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0xef
Oct 28 00:32:33 kefk kernel: eax: f20a2688   ebx: f20a2688   ecx: c18ff480   
edx: c1000000
Oct 28 00:32:33 kefk kernel: esi: e65ee800   edi: 00000000   ebp: 00000246   
esp: c1bb0e20
Oct 28 00:32:33 kefk kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 00:32:33 kefk kernel: Process khubd (pid: 125, threadinfo=c1bb0000 
task=c198a530)
Oct 28 00:32:33 kefk kernel: Stack: 00000000 f20a2688 e65ee800 00000001 
00000246 c01f20e7 f20a2688 c01f20f7
Oct 28 00:32:33 kefk kernel:        e5f87480 c0184aa0 00000000 e65ee800 
00000000 00000246 f8b3cff1 ec9cea28
Oct 28 00:32:33 kefk kernel:        0000003c 00000003 e5f87394 f66fa02c 
e5f87480 e5f87380 f8b3f220 f79b4c00
Oct 28 00:32:33 kefk kernel: Call Trace:
Oct 28 00:32:33 kefk kernel:  [<c01f20e7>] kobject_del+0x14/0x1c
Oct 28 00:32:33 kefk kernel:  [<c01f20f7>] kobject_unregister+0x8/0x10
Oct 28 00:32:33 kefk kernel:  [<c0184aa0>] del_gendisk+0x1d/0xd5
Oct 28 00:32:33 kefk kernel:  [<f8b3cff1>] ub_disconnect+0x11e/0x171 [ub]
Oct 28 00:32:33 kefk kernel:  [<c029826d>] usb_unbind_interface+0x5e/0x60
Oct 28 00:32:33 kefk kernel:  [<c0243765>] device_release_driver+0x56/0x58
Oct 28 00:32:33 kefk kernel:  [<c024396b>] bus_remove_device+0x53/0x90
Oct 28 00:32:33 kefk kernel:  [<c0242a86>] device_del+0x54/0x91
Oct 28 00:32:33 kefk kernel:  [<c02a0007>] usb_disable_device+0xda/0x147
Oct 28 00:32:33 kefk kernel:  [<c029aa8a>] usb_disconnect+0xab/0x198
Oct 28 00:32:33 kefk kernel:  [<c029bfec>] hub_port_connect_change+0x371/0x4a4
Oct 28 00:32:33 kefk kernel:  [<c029c3f3>] hub_events+0x2d4/0x4ac
Oct 28 00:32:33 kefk kernel:  [<c029c600>] hub_thread+0x35/0x10e
Oct 28 00:32:33 kefk kernel:  [<c0115111>] finish_task_switch+0x3b/0x87
Oct 28 00:32:33 kefk kernel:  [<c012d9c1>] autoremove_wake_function+0x0/0x43
Oct 28 00:32:33 kefk kernel:  [<c0103c9a>] ret_from_fork+0x6/0x14
Oct 28 00:32:33 kefk kernel:  [<c012d9c1>] autoremove_wake_function+0x0/0x43
Oct 28 00:32:33 kefk kernel:  [<c029c5cb>] hub_thread+0x0/0x10e
Oct 28 00:32:33 kefk kernel:  [<c0102025>] kernel_thread_helper+0x5/0xb
Oct 28 00:32:33 kefk kernel: Code: aa 3e 32 c0 e9 4d ff ff ff e9 23 ff ff ff 
55 57 56 53 83 ec 04 8b 78 30 85 ff 74 0d 8b 07 85 c0 0f 84 ca 00 00 00 f0 ff 
0
7 85 ff <8b> 57 50 0f 84 b4 00 00 00 8b 47 10 8d 48 78 f0 ff 48 78 0f 88



-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
