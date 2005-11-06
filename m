Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVKFXDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVKFXDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVKFXDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:03:11 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:15316 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751275AbVKFXDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:03:09 -0500
From: Thorsten Holtkaemper <openpub@web.de>
To: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Oops in remove_wait_queue (Re: sbp2: sbp2util_node_write_no_wait failed)
Date: Mon, 7 Nov 2005 00:03:03 +0100
User-Agent: KMail/1.7.2
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
References: <200511061751.12787.openpub@web.de> <200511062007.13047.openpub@web.de> <436E7DB3.1030103@s5r6.in-berlin.de>
In-Reply-To: <436E7DB3.1030103@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511070003.04066.openpub@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 November 2005 23:03, Stefan Richter wrote:
> Thorsten Holtkaemper wrote:
> >>>I am running kernel 2.6.13.4
>
> ...
>
> > After powering off and on the FireWire haddisk
> > the login failed with the same messages. Trying to reload the FireWire
> > related modules resulted in an oops. As far as I can remember such kind
> > of oops also happened at least once during module reload without your
> > patch.
> >
> > [...]
> > ieee1394: Initialized config rom entry `ip1394'
> > ohci1394: $Rev: 1299 $ Ben Collins <bcollins@debian.org>
> > ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 209
> > ohci1394: fw-host0: Unexpected PCI resource length of 1000!
> > ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[209] 
> > MMIO=[dfff7000-dfff77ff]  Max Packet=[2048] eth1394: $Rev: 1264 $ Ben
> > Collins <bcollins@debian.org>
> > eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> > sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
> > ieee1394: unsolicited response packet received - no tlabel match
> > ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050770e501e1452]
> > ieee1394: Host added: ID:BUS[0-01:1023]  GUID[000010dc00592003]
> > scsi8 : SCSI emulation for IEEE-1394 SBP-2 Devices
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000003 printing eip:
> > c012ec26
> > *pde = 00000000
> > Oops: 0002 [#1]
> > Modules linked in: sbp2 ohci1394 eth1394 ieee1394 vfat fat udf isofs nfsd
> > exportfs lockd nfs_acl sunrpc lp thermal fan button processor ac battery
> > capability commoncap af_packet ipv6 ipt_MASQUERADE ipt_mark ip_nat_irc
> > ip_nat_ftp iptable_mangle iptable_nat ipt_state ipt_REJECT ipt_limit
> > ipt_LOG ip_conntrack_ftp ip_conntrack_irc ip_conntrack iptable_filter
> > ip_tables parport_pc parport pcspkr rtc 8139cp ehci_hcd snd_intel8x0
> > snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
> > snd_page_alloc i2c_sis96x i2c_core shpchp pci_hotplug sis_agp agpgart
> > sd_mod tsdev mousedev joydev evdev usbhid usb_storage scsi_mod
> > hisax_fcpcipnp hisax_isac hisax crc_ccitt isdn slhc ohci_hcd usbcore
> > 8139too mii subfs ide_cd cdrom ext3 jbd mbcache ide_disk ide_generic
> > via82cxxx trm290 triflex slc90e66 sis5513 siimage serverworks sc1200
> > rz1000 piix pdc202xx_old pdc202xx_new opti621 ns87415 it821x hpt366
> > hpt34x generic cy82c693 cs5530 cs5520 cmd64x atiixp amd74xx alim15x3
> > aec62xx ide_
>
> core unix
>
> > CPU:    0
> > EIP:    0060:[<c012ec26>]    Not tainted VLI
> > EFLAGS: 00210096   (2.6.13.4)
> > EIP is at remove_wait_queue+0x16/0x40
> > eax: ffffffff   ebx: ffffc0f3   ecx: ffffffff   edx: ffffc0e7
> > esi: 00200296   edi: c73e3000   ebp: 00000000   esp: cade5ecc
> > ds: 007b   es: 007b   ss: 0068
> > Process klipper (pid: 8204, threadinfo=cade4000 task=ca905020)
> > Stack: ffffc0e3 c73e3008 c016aa9e 00000000 00000000 00000009 c016ae1f
> > cade5f38 00000000 00000000 00000000 00000178 00000000 00000000 00000000
> > 00000000 00000178 cade4000 c14e45cc c14e45c8 c14e45c4 c14e45d8 c14e45d4
> > c14e45d0 Call Trace:
> >  [<c016aa9e>] poll_freewait+0x2e/0x50
> >  [<c016ae1f>] do_select+0x18f/0x2c0
> >  [<c016aac0>] __pollwait+0x0/0xd0
> >  [<c016b238>] sys_select+0x2a8/0x440
> >  [<c0103009>] syscall_call+0x7/0xb
> > Code: 04 89 0b 89 59 04 56 9d 8b 1c 24 8b 74 24 04 83 c4 08 c3 89 f6 83
> > ec 08 89 1c 24 89 74 24 04 9c 5e fa 8d 5a 0c 8b 42 0c 8b 4b 04 <89> 4804
> > 89 01 c7 43 04 00 02 20 00 c7 42 0c 00 01 10 00 56 9d <3>ieee1394: sbp2:
> > Error logging into SBP-2 device - login failed sbp2: probe of
> > 0050770e501e1452-0 failed with error -16
> > scsi9 : SCSI emulation for IEEE-1394 SBP-2 Devices
> > ieee1394: sbp2: Error logging into SBP-2 device - login failed
> > sbp2: probe of 0050770e501e1452-0 failed with error -16
> > [...]
>
> What is the klipper process, and what did it poll there?

it is the KDE clipboard app. I do not have any clue how this is related to the 
reload of the FireWire modules (sbp2 eth1394 ohci1394 ieee1394).

Thorsten
