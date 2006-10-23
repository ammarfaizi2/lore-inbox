Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWJWCkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWJWCkA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 22:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWJWCkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 22:40:00 -0400
Received: from webserve.ca ([69.90.47.180]:20189 "EHLO computersmith.org")
	by vger.kernel.org with ESMTP id S1751153AbWJWCj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 22:39:59 -0400
Message-ID: <453C2B5B.30207@wintersgift.com>
Date: Sun, 22 Oct 2006 19:39:23 -0700
From: teunis <teunis@wintersgift.com>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Luca Risolia <luca.risolia@studio.unibo.it>, linux-kernel@vger.kernel.org
Subject: Re: sn9c10x list corruption in 2.6.18.1
References: <20061022031145.GA24855@redhat.com> <200610221346.53038.luca.risolia@studio.unibo.it> <20061022181539.GD27152@redhat.com> <200610222322.46703.luca.risolia@studio.unibo.it>
In-Reply-To: <200610222322.46703.luca.risolia@studio.unibo.it>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Luca Risolia wrote:
> Alle 20:15, domenica 22 ottobre 2006, Dave Jones ha scritto:
>> But it only happens when the user unplugs the camera, and no other
>> webcam driver seems to be affected by this problem.
> 
> Simply unplugging the camera does not reproduce any problem here. This is
> the first time I see this bug.
> 
>> That's fairly conclusive to me that the driver is misbehaving.
> 
> I do not think this implication is correct, as not all the drivers are
> implemented the same way and run under the same kernel configurations.
> 
> The code in the driver seems to be okay to me.

Aha!
No idea if this helps, but here's the fault report:

usb 2-1: USB disconnect, address 7
PM: Removing info for No Bus:usbdev2.7_ep81
PM: Removing info for No Bus:usbdev2.7_ep82
PM: Removing info for No Bus:usbdev2.7_ep83
usb 2-1: Disconnecting SN9C10x PC Camera...
usb 2-1: V4L2 device /dev/video0 deregistered
PM: Removing info for usb:2-1:1.0
PM: Removing info for No Bus:usbdev2.7_ep00
PM: Removing info for usb:2-1
get_unused_fd: slot 30 not NULL!
BUG: unable to handle kernel paging request at virtual address 01401e76
 printing eip:
c016af2f
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /class/net/eth0/carrier
Modules linked in: sn9c102 videodev v4l1_compat v4l2_common ipaq
usbserial iptable_filter ip_tables x_tables fglrx(P) vmnet(P) vmmon(P)
cpufreq_ondemand cpufreq_performance speedstep_centrino freq_table
rfcomm l2cap bluetooth ppdev lp button ac battery ipv6 sbp2 loop
snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd ipw2200 soundcore eth1394 ieee80211
i2c_i801 irda snd_page_alloc shpchp parport_pc parport ieee80211_crypt
i2c_core iTCO_wdt crc_ccitt serio_raw joydev tsdev pcspkr ext3 jbd
dm_mirror dm_snapshot dm_mod ide_generic ide_cd cdrom ide_disk ata_piix
libata scsi_mod generic uhci_hcd ehci_hcd piix ide_core tg3 ohci1394
ieee1394
CPU:    0
EIP:    0060:[<c016af2f>]    Tainted: P      VLI
EFLAGS: 00210202   (2.6.19-rc2-mm2 #1)
EIP is at fget+0x22/0x45
eax: d62c0000   ebx: fffffff7   ecx: 01401e62   edx: 00000001
esi: 00000000   edi: 00000001   ebp: 00000000   esp: c77fbf98
ds: 007b   es: 007b   ss: 0068
Process laptop_mode (pid: 1474, ti=c77fa000 task=d323e570 task.ti=c77fa000)
Stack: fffffff7 c0173eb9 00008441 00000001 00000000 b7f75ff4 c77fa000
c0103d32
       00000001 00000001 00000000 00000000 b7f75ff4 bff7b708 000000dd
0000007b
       0000007b c0100033 000000dd b7fe7410 00000073 00200246 bff7b6e4
0000007b
Call Trace:
 [<c0173eb9>] sys_fcntl64+0x1d/0x85
 [<c0103d32>] sysenter_past_esp+0x5f/0x85
 =======================
Code: 00 ef 3a c0 01 31 c0 5b c3 53 89 c2 65 a1 08 00 00 00 8b 80 54 04
00 00 31 c9 8b 40 04 3b 10 73 29 8b 40 04 8b 0c 90 85 c9 74 1f <8b> 51
14 85 d2 74 16 8d 5a 01 89 d0 90 0f b1 59 14 39 d0 74 04
EIP: [<c016af2f>] fget+0x22/0x45 SS:ESP 0068:c77fbf98
 <1>BUG: unable to handle kernel paging request at virtual address 4f3e3450
 printing eip:
c0168835
*pde = 00000000
Oops: 0000 [#2]
SMP
last sysfs file: /class/net/eth0/carrier
Modules linked in: sn9c102 videodev v4l1_compat v4l2_common ipaq
usbserial iptable_filter ip_tables x_tables fglrx(P) vmnet(P) vmmon(P)
cpufreq_ondemand cpufreq_performance speedstep_centrino freq_table
rfcomm l2cap bluetooth ppdev lp button ac battery ipv6 sbp2 loop
snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd ipw2200 soundcore eth1394 ieee80211
i2c_i801 irda snd_page_alloc shpchp parport_pc parport ieee80211_crypt
i2c_core iTCO_wdt crc_ccitt serio_raw joydev tsdev pcspkr ext3 jbd
dm_mirror dm_snapshot dm_mod ide_generic ide_cd cdrom ide_disk ata_piix
libata scsi_mod generic uhci_hcd ehci_hcd piix ide_core tg3 ohci1394
ieee1394
CPU:    0
EIP:    0060:[<c0168835>]    Tainted: P      VLI
EFLAGS: 00210282   (2.6.19-rc2-mm2 #1)
EIP is at filp_close+0xa/0x59
eax: 4f3e343c   ebx: 4f3e343c   ecx: 4f3e343c   edx: dbee9e00
esi: dbee9e00   edi: 00000000   ebp: cc3e8840   esp: c77fbe80
ds: 007b   es: 007b   ss: 0068
Process laptop_mode (pid: 1474, ti=c77fa000 task=d323e570 task.ti=c77fa000)
Stack: 00000000 dbee9e00 7fffffff 00000000 c012324e c988fe40 00000000
00000000
       dbee9e00 d323e570 00000001 0000000b c01242b6 c77fa000 0000000f
c77fbf98
       00000068 00200202 c01220f0 c0318f4b 00000000 c77fbf60 c77fbf98
00000068
Call Trace:
 [<c012324e>] put_files_struct+0x79/0xbf
 [<c01242b6>] do_exit+0x22f/0x769
 [<c01220f0>] printk+0x1b/0x1f
 [<c01051b4>] die+0x207/0x22c
 [<c02e6fe6>] do_page_fault+0x412/0x4ec
 [<c02e6bd4>] do_page_fault+0x0/0x4ec
 [<c02e590c>] error_code+0x7c/0x84
 [<c016af2f>] fget+0x22/0x45
 [<c0173eb9>] sys_fcntl64+0x1d/0x85
 [<c0103d32>] sysenter_past_esp+0x5f/0x85
 =======================
Code: 00 00 00 8b 41 04 01 d0 83 38 00 74 04 0f 0b eb fe 03 51 04 89 3a
c6 86 80 00 00 00 01 5b 5e 5f c3 57 56 89 d6 53 89 c3 83 ec 04 <8b> 40
14 85 c0 75 10 c7 04 24 c2 8f 30 c0 31 ff e8 8b 98 fb ff
EIP: [<c0168835>] filp_close+0xa/0x59 SS:ESP 0068:c77fbe80
 <1>Fixing recursive fault but reboot is needed!

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFPCtbbFT/SAfwLKMRAkgfAJ9DiU0jWpzVkaVqvblAUsx04koDqACgl/Ju
ApA93IN5EwNJTgzrAc25ObI=
=vXgZ
-----END PGP SIGNATURE-----
