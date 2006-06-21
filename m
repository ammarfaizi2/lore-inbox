Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWFUUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWFUUui (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWFUUui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:50:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:21409 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932455AbWFUUuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:50:37 -0400
Date: Wed, 21 Jun 2006 13:47:25 -0700
From: Greg KH <gregkh@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       marcel@holtmann.org, maxk@qualcomm.com, Andrew Morton <akpm@osdl.org>,
       bluez-devel@lists.sourceforge.net
Subject: Re: 2.6.17-mm1: oops in Bluetooth stuff, usbdev_open
Message-ID: <20060621204725.GB30766@suse.de>
References: <4499ADEB.1000905@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4499ADEB.1000905@goop.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 01:36:59PM -0700, Jeremy Fitzhardinge wrote:
> I get this oops on boot, while the /etc/rc.d/init.d/bluetooth scripts 
> are running:
> 
> Bluetooth: Core ver 2.8
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 00000000
> printing eip:
> c027a5d5
> *pde = 00000000
> Oops: 0000 [#1]
> 4K_STACKS SMP
> last sysfs file: 
> /devices/pci0000:00/0000:00:1e.0/0000:15:00.1/fw-host0/000a27000401f4a2/000a2
> 7000401f4a2-0/version
> Modules linked in: bluetooth sunrpc ip_conntrack_netbios_ns ipt_REJECT 
> xt_state ip_conntrack n
> fnetlink xt_tcpudp iptable_filter ip_tables x_tables vfat fat dm_mirror 
> dm_mod video ibm_acpi
> button battery ac parport_pc lp parport nvram raw1394 video1394 
> snd_hda_intel snd_hda_codec sn
> d_seq_dummy mmc_block snd_seq_oss snd_seq_midi_event wlan_scan_sta snd_seq 
> snd_seq_device snd_
> pcm_oss snd_mixer_oss snd_pcm snd_timer sdhci sg ohci1394 ieee1394 ehci_hcd 
> snd mmc_core ath_p
> ci ath_rate_sample e1000 i2c_i801 soundcore snd_page_alloc wlan ath_hal 
> uhci_hcd piix pcspkr i
> 2c_core generic ext3 jbd ahci libata sd_mod scsi_mod
> CPU:    0
> EIP:    0060:[<c027a5d5>]    Tainted: P      VLI
> EFLAGS: 00210287   (2.6.17-mm1 #40)
> EIP is at usbdev_open+0xaf/0x1a3
> eax: 0bd00200   ebx: 00000000   ecx: fffffe78   edx: f757c388
> esi: f64d1b40   edi: f7fb9ac0   ebp: 00000200   esp: f75e3ed8
> ds: 007b   es: 007b   ss: 0068
> Process hid2hci (pid: 2140, ti=f75e3000 task=f70a65a0 task.ti=f75e3000)
> Stack: f7092b00 f7014bf0 00000000 c03d0e00 f7014bf0 f7092b00 c016d7eb 
> 00000200
>       f7092b00 f7014bf0 00000000 c016d6e7 c0164314 c20fe140 f750fe08 
>       f7092b00
>       00000002 f75e3f40 00000004 c0164472 f7092b00 00000000 00000001 
>       c01644b3
> Call Trace:
> [<c016d7eb>] chrdev_open+0x104/0x148
> [<c016d6e7>] chrdev_open+0x0/0x148
> [<c0164314>] __dentry_open+0xc7/0x1ab
> [<c0164472>] nameidata_to_filp+0x24/0x33
> [<c01644b3>] do_filp_open+0x32/0x39
> [<c0123eda>] current_fs_time+0x4f/0x59
> [<c0164243>] get_unused_fd+0xb9/0xc3
> [<c01644fc>] do_sys_open+0x42/0xbe
> [<c01645b1>] sys_open+0x1c/0x1e
> [<c030052d>] sysenter_past_esp+0x56/0x79
> [<c030007b>] __down_interruptible+0x63/0x12e
> Code: 00 00 8b 3d ac ba 4a c0 8b 8f 9c 00 00 00 81 e9 88 01 00 00 eb 15 89 
> e8 0d 00 00 d0 0b 3
> 9 81 94 01 00 00 74 85 8d 8b 78 fe ff ff <8b> 99 88 01 00 00 0f 18 03 90 8d 
> 91 88 01 00 00 8d
> 87 9c 00 00
> EIP: [<c027a5d5>] usbdev_open+0xaf/0x1a3 SS:ESP 0068:f75e3ed8
> <6>Bluetooth: L2CAP ver 2.8
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM ver 1.7
> Bluetooth: HIDP (Human Interface Emulation) ver 1.1
> 
> There's no bluetooth device actually visible on the USB bus at this point.

Can you duplicate this without the closed source kernel module loaded?

thanks,

greg k-h
