Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVAEA4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVAEA4U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVAEA4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:56:20 -0500
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:25613 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261811AbVAEA4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:56:05 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: linux-kernel@vger.kernel.org
Subject: b44 driver crashed,network utilities stuck 2.6.10
Date: Wed, 5 Jan 2005 01:55:59 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501050155.59596.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not sure if this says anythig to anyone but here is my
syslog from the latest resume cycle. The network is
only halfway usable after this. eth1 works, most
network-related commands (ifconfig with or
without any particular interface as argument) hang.

Pre-state:

Machine booted with a wireless pcmcia card.
Suspended
Card removed
Resumed
Used b44 for a day
Suspended
Resumed
WLAN card inserted before the resume scripts had completed

A smb drive was mounted during the latest suspend resume cycle.

-- robin

Jan  4 20:05:34 xine kernel: ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 26 Oct 2004
Jan  4 20:05:34 xine kernel: ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
Jan  4 20:05:34 xine kernel: ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
Jan  4 20:05:34 xine kernel: NVRM: ACPI: event: 1
Jan  4 20:05:34 xine kernel: NVRM: RmPowerManagement: 4
Jan  4 20:05:34 xine kernel: acpi-cpufreq: Transition failed
Jan  4 20:05:34 xine kernel: Restarting tasks... done
Jan  4 20:05:35 xine smartd[8514]: Device: /dev/hda, SMART Prefailure Attribute: 3 Spin_Up_Time changed from 161 to 157 
Jan  4 20:05:41 xine postfix:  succeeded
Jan  4 20:05:41 xine xinetd[397]: Exiting...
Jan  4 20:05:41 xine xinetd: xinetd avslutas succeeded
Jan  4 20:05:42 xine gpm: gpm avslutas succeeded
Jan  4 20:05:42 xine cardmgr[444]: exiting
Jan  4 20:05:44 xine irattach: got SIGTERM or SIGINT 
Jan  4 20:05:44 xine irattach: Stopping device irda0
# Things get logged out of order because "exiting" tasks.
# were killed before suspend.

Jan  4 20:05:44 xine irattach: exiting ... 
Jan  4 20:05:44 xine irda: irattach avslutas succeeded
Jan  4 20:05:46 xine alsa:  succeeded
Jan  4 20:05:47 xine alsa:  failed
Jan  4 20:05:51 xine kernel: PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
Jan  4 20:05:51 xine kernel: ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Jan  4 20:05:51 xine mysql-max:  succeeded
Jan  4 20:05:52 xine ntpd[545]: ntpd exiting on signal 15
Jan  4 20:05:52 xine ntpd_initres[568]: ntpd exiting on signal 15
Jan  4 20:05:52 xine ntpd: ntpd avslutas succeeded
Jan  4 20:05:52 xine bluetooth: hciattach avslutas failed
Jan  4 20:05:52 xine sdpd[581]: terminating...   
Jan  4 20:05:52 xine bluetooth: sdpd avslutas succeeded
Jan  4 20:05:53 xine hcid[569]: Exit.
Jan  4 20:05:53 xine bluetooth: hcid avslutas succeeded
Jan  4 20:05:53 xine dhclient-helper: Testing config file tap0
Jan  4 20:05:54 xine dhclient-helper: Testing config file eth1
Jan  4 20:05:54 xine dhclient-helper: Testing config file eth0
Jan  4 20:05:54 xine dhclient-helper: eth0 is up
# This is false, but the b44 is known to get the the line status wrong
# it also means ifconfig eth0 didn't hang here because that is what
# dhclient-helper (my script) uses.

Jan  4 20:05:54 xine dhclient-helper: Writing new resolv.conf
Jan  4 20:05:54 xine dhclient: DHCPDISCOVER on eth1 to 255.255.255.255 port 67 interval 8
Jan  4 20:05:54 xine dhclient: DHCPOFFER from 10.3.3.129
Jan  4 20:05:54 xine dhclient: DHCPREQUEST on eth1 to 255.255.255.255 port 67
Jan  4 20:05:54 xine dhclient: DHCPACK from 10.3.3.129
Jan  4 20:05:56 xine openvpn:  succeeded
Jan  4 20:05:56 xine netplugd: netplugd avslutas failed
Jan  4 20:05:56 xine kernel: Unable to handle kernel paging request at virtual address 74636130
Jan  4 20:05:56 xine kernel:  printing eip:
Jan  4 20:05:56 xine kernel: c018a7df
Jan  4 20:05:56 xine kernel: *pde = 00000000
Jan  4 20:05:56 xine kernel: Oops: 0000 [#1]
Jan  4 20:05:56 xine kernel: PREEMPT 
Jan  4 20:05:56 xine kernel: Modules linked in: nls_cp437 nls_iso8859_1 smbfs b44 mii prism54 firmware_class speedstep_lib irtty_sir sir_dev rfcomm l2cap bluetooth snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore af_packet pcmcia yenta_socket pcmcia_core ide_cd cdrom loop acpi_cpufreq nvidia intel_agp evdev agpgart pcspkr ircomm_tty ircomm irda crc_ccitt tun dm_mod ehci_hcd uhci_hcd usbcore video thermal processor fan button battery ac xfs
Jan  4 20:05:56 xine kernel: CPU:    0
Jan  4 20:05:56 xine kernel: EIP:    0060:[remove_proc_entry+39/360]    Tainted: P      VLI
Jan  4 20:05:56 xine kernel: EIP:    0060:[<c018a7df>]    Tainted: P      VLI
Jan  4 20:05:56 xine kernel: EFLAGS: 00010246   (2.6.10) 
Jan  4 20:05:56 xine kernel: EIP is at remove_proc_entry+0x27/0x168
Jan  4 20:05:56 xine kernel: eax: 00000000   ebx: da346ba0   ecx: ffffffff   edx: dff4e400
Jan  4 20:05:56 xine kernel: esi: c036e000   edi: 74636130   ebp: cc3afe18   esp: cc3afdf8
Jan  4 20:05:56 xine kernel: ds: 007b   es: 007b   ss: 0068
Jan  4 20:05:56 xine kernel: Process modprobe (pid: 22573, threadinfo=cc3ae000 task=d370e020)
Jan  4 20:05:56 xine kernel: Stack: 00000002 dd914800 00000000 cc3afe18 74636130 da346ba0 c036e000 de6c4180 
Jan  4 20:05:56 xine kernel:        cc3afe40 c013751f 74636130 dff4e400 cc3ae000 00000202 0000000b cc3ae000 
Jan  4 20:05:56 xine kernel:        dce0e220 dce0e000 cc3afe5c e0bbb055 0000000b dce0e000 dce0e000 dce0e000 
Jan  4 20:05:56 xine kernel: Call Trace:
Jan  4 20:05:56 xine kernel:  [show_stack+128/150] show_stack+0x80/0x96
Jan  4 20:05:56 xine kernel:  [<c0103c47>] show_stack+0x80/0x96
Jan  4 20:05:56 xine kernel:  [show_registers+346/465] show_registers+0x15a/0x1d1
Jan  4 20:05:56 xine kernel:  [<c0103dd7>] show_registers+0x15a/0x1d1
Jan  4 20:05:56 xine kernel:  [die+245/390] die+0xf5/0x186
Jan  4 20:05:56 xine kernel:  [<c0103fe6>] die+0xf5/0x186
Jan  4 20:05:56 xine kernel:  [do_page_fault+1126/1702] do_page_fault+0x466/0x6a6
Jan  4 20:05:56 xine kernel:  [<c011461d>] do_page_fault+0x466/0x6a6
Jan  4 20:05:56 xine kernel:  [error_code+43/48] error_code+0x2b/0x30
Jan  4 20:05:56 xine kernel:  [<c01038cf>] error_code+0x2b/0x30
Jan  4 20:05:56 xine kernel:  [free_irq+152/249] free_irq+0x98/0xf9
Jan  4 20:05:56 xine kernel:  [<c013751f>] free_irq+0x98/0xf9
Jan  4 20:05:56 xine kernel:  [pg0+545054805/1069618176] b44_close+0x77/0x9f [b44]
Jan  4 20:05:56 xine kernel:  [<e0bbb055>] b44_close+0x77/0x9f [b44]
Jan  4 20:05:56 xine kernel:  [dev_close+155/157] dev_close+0x9b/0x9d
Jan  4 20:05:56 xine kernel:  [<c025dd04>] dev_close+0x9b/0x9d
Jan  4 20:05:56 xine kernel:  [unregister_netdevice+482/659] unregister_netdevice+0x1e2/0x293
Jan  4 20:05:56 xine kernel:  [<c0260287>] unregister_netdevice+0x1e2/0x293
Jan  4 20:05:56 xine kernel:  [unregister_netdev+23/35] unregister_netdev+0x17/0x23
Jan  4 20:05:56 xine kernel:  [<c022f3d8>] unregister_netdev+0x17/0x23
Jan  4 20:05:56 xine kernel:  [pg0+545058032/1069618176] b44_remove_one+0x2d/0x6a [b44]
Jan  4 20:05:56 xine kernel:  [<e0bbbcf0>] b44_remove_one+0x2d/0x6a [b44]
Jan  4 20:05:56 xine kernel:  [pci_device_remove+56/58] pci_device_remove+0x38/0x3a
Jan  4 20:05:56 xine kernel:  [<c01c794c>] pci_device_remove+0x38/0x3a
Jan  4 20:05:56 xine kernel:  [device_release_driver+123/125] device_release_driver+0x7b/0x7d
Jan  4 20:05:56 xine kernel:  [<c021e19d>] device_release_driver+0x7b/0x7d
Jan  4 20:05:56 xine kernel:  [driver_detach+32/47] driver_detach+0x20/0x2f
Jan  4 20:05:56 xine kernel:  [<c021e1bf>] driver_detach+0x20/0x2f
Jan  4 20:05:56 xine kernel:  [bus_remove_driver+74/135] bus_remove_driver+0x4a/0x87
Jan  4 20:05:56 xine kernel:  [<c021e60e>] bus_remove_driver+0x4a/0x87
Jan  4 20:05:56 xine kernel:  [driver_unregister+18/34] driver_unregister+0x12/0x22
Jan  4 20:05:56 xine kernel:  [<c021eb53>] driver_unregister+0x12/0x22
Jan  4 20:05:56 xine kernel:  [pci_unregister_driver+21/34] pci_unregister_driver+0x15/0x22
Jan  4 20:05:56 xine kernel:  [<c01c7b6a>] pci_unregister_driver+0x15/0x22
Jan  4 20:05:56 xine kernel:  [pg0+545058526/1069618176] b44_cleanup+0x12/0x14 [b44]
Jan  4 20:05:56 xine kernel:  [<e0bbbede>] b44_cleanup+0x12/0x14 [b44]
Jan  4 20:05:56 xine kernel:  [sys_delete_module+329/365] sys_delete_module+0x149/0x16d
Jan  4 20:05:56 xine kernel:  [<c012f1f5>] sys_delete_module+0x149/0x16d
Jan  4 20:05:56 xine kernel:  [sysenter_past_esp+82/117] sysenter_past_esp+0x52/0x75
Jan  4 20:05:56 xine kernel:  [<c0102e41>] sysenter_past_esp+0x52/0x75
Jan  4 20:05:56 xine kernel: Code: fb ff eb e2 55 89 e5 83 ec 20 8b 55 0c 89 7d fc 8b 7d 08 85 d2 89 5d f4 89 75 f8 89 7d f0 0f 84 ad 00 00 00 31 c0 b9 ff ff ff ff <f2> ae f7 d1 49 8b 42 34 89 ce 8d 5a 34 85 c0 0f 84 84 00 00 00 
END OF TRACE
