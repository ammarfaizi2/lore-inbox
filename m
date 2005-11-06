Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVKFWGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVKFWGA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKFWGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:06:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58813 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932305AbVKFWF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:05:59 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <436E7DB3.1030103@s5r6.in-berlin.de>
Date: Sun, 06 Nov 2005 23:03:31 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: Thorsten Holtkaemper <openpub@web.de>
Subject: Oops in remove_wait_queue (Re: sbp2: sbp2util_node_write_no_wait
 failed)
References: <200511061751.12787.openpub@web.de> <436E4019.7000709@s5r6.in-berlin.de> <200511062007.13047.openpub@web.de>
In-Reply-To: <200511062007.13047.openpub@web.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.099) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thorsten Holtkaemper wrote:
>>>I am running kernel 2.6.13.4
...
> After powering off and on the FireWire haddisk
> the login failed with the same messages. Trying to reload the FireWire
> related modules resulted in an oops. As far as I can remember such kind of
> oops also happened at least once during module reload without your patch.
> 
> [...]
> ieee1394: Initialized config rom entry `ip1394'
> ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
> ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 209
> ohci1394: fw-host0: Unexpected PCI resource length of 1000!
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209]  MMIO=[dfff7000-dfff77ff]  Max Packet=[2048]
> eth1394: $Rev: 1264 $ Ben Collins <bcollins@debian.org>
> eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
> ieee1394: unsolicited response packet received - no tlabel match
> ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050770e501e1452]
> ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000010dc00592003]
> scsi8 : SCSI emulation for IEEE-1394 SBP-2 Devices
> Unable to handle kernel NULL pointer dereference at virtual address 00000003
>  printing eip:
> c012ec26
> *pde = 00000000
> Oops: 0002 [#1]
> Modules linked in: sbp2 ohci1394 eth1394 ieee1394 vfat fat udf isofs nfsd exportfs lockd nfs_acl sunrpc lp thermal fan button processor ac battery capability commoncap af_packet ipv6 ipt_MASQUERADE ipt_mark ip_nat_irc ip_nat_ftp iptable_mangle iptable_nat ipt_state ipt_REJECT ipt_limit ipt_LOG ip_conntrack_ftp ip_conntrack_irc ip_conntrack iptable_filter ip_tables parport_pc parport pcspkr rtc 8139cp ehci_hcd snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc i2c_sis96x i2c_core shpchp pci_hotplug sis_agp agpgart sd_mod tsdev mousedev joydev evdev usbhid usb_storage scsi_mod hisax_fcpcipnp hisax_isac hisax crc_ccitt isdn slhc ohci_hcd usbcore 8139too mii subfs ide_cd cdrom ext3 jbd mbcache ide_disk ide_generic via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200 rz1000 piix pdc202xx_old pdc202xx_new opti621 ns87415 it821x hpt366 hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3 aec62xx ide_
core unix
> CPU:    0
> EIP:    0060:[<c012ec26>]    Not tainted VLI
> EFLAGS: 00210096   (2.6.13.4)
> EIP is at remove_wait_queue+0x16/0x40
> eax: ffffffff   ebx: ffffc0f3   ecx: ffffffff   edx: ffffc0e7
> esi: 00200296   edi: c73e3000   ebp: 00000000   esp: cade5ecc
> ds: 007b   es: 007b   ss: 0068
> Process klipper (pid: 8204, threadinfo=cade4000 task=ca905020)
> Stack: ffffc0e3 c73e3008 c016aa9e 00000000 00000000 00000009 c016ae1f cade5f38
>        00000000 00000000 00000000 00000178 00000000 00000000 00000000 00000000
>        00000178 cade4000 c14e45cc c14e45c8 c14e45c4 c14e45d8 c14e45d4 c14e45d0
> Call Trace:
>  [<c016aa9e>] poll_freewait+0x2e/0x50
>  [<c016ae1f>] do_select+0x18f/0x2c0
>  [<c016aac0>] __pollwait+0x0/0xd0
>  [<c016b238>] sys_select+0x2a8/0x440
>  [<c0103009>] syscall_call+0x7/0xb
> Code: 04 89 0b 89 59 04 56 9d 8b 1c 24 8b 74 24 04 83 c4 08 c3 89 f6 83 ec 08 89 1c 24 89 74 24 04 9c 5e fa 8d 5a 0c 8b 42 0c 8b 4b 04 <89> 4804 89 01 c7 43 04 00 02 20 00 c7 42 0c 00 01 10 00 56 9d
>  <3>ieee1394: sbp2: Error logging into SBP-2 device - login failed
> sbp2: probe of 0050770e501e1452-0 failed with error -16
> scsi9 : SCSI emulation for IEEE-1394 SBP-2 Devices
> ieee1394: sbp2: Error logging into SBP-2 device - login failed
> sbp2: probe of 0050770e501e1452-0 failed with error -16
> [...]

What is the klipper process, and what did it poll there?

One thing about sbp2 which isn't optimal yet is that it creates a 
scsi_host before it logs in into the SBP-2 unit, instead of deferring 
host creation until after a successful login. Maybe the short lifetime 
of such a host reveals a vulnerability to race conditions somewhere.

(added linux-kernel to recipients)
-- 
Stefan Richter
-=====-=-=-= =-== --==-
http://arcgraph.de/sr/
