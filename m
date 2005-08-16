Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVHPNwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVHPNwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbVHPNwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:52:47 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:3227 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S965235AbVHPNwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:52:46 -0400
Date: Tue, 16 Aug 2005 15:52:40 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc6-commit-2ba8... crash on firmware load
Message-ID: <20050816135240.GA20542@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  any idea what happened to the 'cat' uploading my firmware?  It seems
that sysfs's release() crashed because 'to_bin_attr(file->f_dentry)'
returned pointer to the released memory.  Unfortunately there seems
to be no changes in firmware loader in last week, so it is probably
some rare race or something like that.

  Neither firmware.agent nor firmware itself changed during last 6 months.
Host seems quite stable after oopses, and DVB-T hardware works as it
should...

  Host is Dual Opteron 246.
						Thanks,
							Petr Vandrovec

crc32c: Unknown symbol crc32c_le
Initializing IPsec netlink socket
ipcomp6: Unknown symbol xfrm6_tunnel_free_spi
ipcomp6: Unknown symbol xfrm6_tunnel_alloc_spi
ipcomp6: Unknown symbol xfrm6_tunnel_spi_lookup
NET: Registered protocol family 4
ioctl32(ipx_configure:9636): Unknown cmd fd(3) cmd(000089e1){00} arg(ffffce3b) on socket:[18402]
Process accounting paused
ioctl32(matroxset:10258): Unknown cmd fd(3) cmd(40046ef8){00} arg(ffffc9fc) on /dev/fb0
tda1004x: found firmware revision 0 -- invalid
tda1004x: waiting for firmware upload (dvb-fe-tda10045.fw)...
general protection fault: 0000 [1] PREEMPT SMP
CPU 0
Modules linked in: ipx p8022 psnap llc esp6 ah6 ipcomp esp4 ah4 xfrm_user wp512 tgr192 tea sha512 michael_mic md4 khazad cast6 cast5 arc4 anubis snd_pcm_oss nfsd exportfs lockd nfs_acl snd_pcm sunrpc snd_timer snd_page_alloc snd_mixer_oss snd binfmt_misc capability commoncap w83627hf_wdt ipv6 ide_cd floppy budget_ci tda1004x firmware_class budget_core dvb_core saa7146 ttpci_eeprom stv0299 i2c_amd756 hw_random i2c_amd8111 shpchp pci_hotplug deflate zlib_deflate zlib_inflate twofish serpent aes_x86_64 blowfish des sha256 sha1 crypto_null af_key eth1394 usblp usb_storage tg3 usbhid ohci1394 ieee1394 ohci_hcd usbcore i810_audio ac97_codec soundcore
Pid: 10363, comm: cat Not tainted 2.6.13-rc6-2ba8
RIP: 0010:[<ffffffff801c8c5f>] <ffffffff801c8c5f>{release+95}
RSP: 0000:ffff81006ede7e88  EFLAGS: 00010256
RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff80218290 RDI: 0000000000000001
RBP: ffff81003a2a7000 R08: 0000000000000000 R09: ffff81007cb6fb90
R10: 0000000000000001 R11: 0000000000000000 R12: ffff81006ed30af0
R13: ffff810040009d80 R14: ffff81006ecf7aa0 R15: ffff81006f120b50
FS:  00002aaaafbf1ba0(0000) GS:ffffffff8064d800(0000) knlGS:00000000556c76c0
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000055621604 CR3: 0000000000101000 CR4: 00000000000006e0
Process cat (pid: 10363, threadinfo ffff81006ede6000, task ffff81006ed6c820)
Stack: ffff81006ecf7aa0 ffff81006ecf7aa0 0000000000000008 ffffffff8018ab4b
       ffff810001e0a360 ffff81006ed30af0 ffff81007f796f08 0000000000000000
       0000000000000001 0000000000000001
Call Trace:<ffffffff8018ab4b>{__fput+187} <ffffffff801891be>{filp_close+110}
       <ffffffff8013aef3>{put_files_struct+115} <ffffffff8013bd79>{do_exit+505}
       <ffffffff8013c130>{sys_exit_group+0} <ffffffff80123b41>{ia32_sysret+0}


Code: ff 88 40 01 00 00 83 3b 02 75 0c 48 8b bb 50 03 00 00 e8 1a
RIP <ffffffff801c8c5f>{release+95} RSP <ffff81006ede7e88>
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():1

Call Trace:<ffffffff80135818>{__might_sleep+200} <ffffffff80139929>{profile_task_exit+41}
       <ffffffff8013bb9c>{do_exit+28} <ffffffff8010f715>{die+69}
       <ffffffff801100de>{do_general_protection+270} <ffffffff8010e7c9>{error_exit+0}
       <ffffffff80218290>{kobject_release+0} <ffffffff801c8c5f>{release+95}
       <ffffffff801c8c55>{release+85} <ffffffff8018ab4b>{__fput+187}
       <ffffffff801891be>{filp_close+110} <ffffffff8013aef3>{put_files_struct+115}
       <ffffffff8013bd79>{do_exit+505} <ffffffff8013c130>{sys_exit_group+0}
       <ffffffff80123b41>{ia32_sysret+0}
Fixing recursive fault but reboot is needed!
scheduling while atomic: cat/0x00000001/10363

Call Trace:<ffffffff8039593d>{schedule+125} <ffffffff80138fad>{printk+141}
       <ffffffff803977f1>{__down_read+49} <ffffffff80135818>{__might_sleep+200}
       <ffffffff8013bc71>{do_exit+241} <ffffffff8010f715>{die+69}
       <ffffffff801100de>{do_general_protection+270} <ffffffff8010e7c9>{error_exit+0}
       <ffffffff80218290>{kobject_release+0} <ffffffff801c8c5f>{release+95}
       <ffffffff801c8c55>{release+85} <ffffffff8018ab4b>{__fput+187}
       <ffffffff801891be>{filp_close+110} <ffffffff8013aef3>{put_files_struct+115}
       <ffffffff8013bd79>{do_exit+505} <ffffffff8013c130>{sys_exit_group+0}
       <ffffffff80123b41>{ia32_sysret+0}
tda1004x: firmware upload complete
tda1004x: found firmware revision 2c -- ok

