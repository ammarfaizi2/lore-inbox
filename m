Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbUJ3Ntz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbUJ3Ntz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUJ3Ntz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:49:55 -0400
Received: from CPE-203-51-26-106.nsw.bigpond.net.au ([203.51.26.106]:39921
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261178AbUJ3Ntu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:49:50 -0400
Message-ID: <41839BFC.1070302@eyal.emu.id.au>
Date: Sat, 30 Oct 2004 23:49:48 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc1 bttv oops in btcx_riscmem_free
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Watching on Mythtv, I stopped watching on the client. at this point
the picture froze. Looking in dmesg I see this oops. The machine
quicly becomes unusable ('ps aux' hangs).

I then applied the v4l patches off the list. Still the same problem.

Unable to handle kernel paging request at virtual address 85525fe9
  printing eip:
c010b567
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: nls_iso8859_1 smbfs tsdev psmouse mt352 sp887x v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 i2c_sensor eth1394 ohci_hcd ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bt878 bttv tuner video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_hcd usbcore shpchp pciehp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc parport 8250_pnp 8250 serial_core evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[<c010b567>]    Not tainted VLI
EFLAGS: 00210282   (2.6.10-rc1-d1)
EIP is at dma_free_coherent+0x30/0x67
eax: 00000000   ebx: e3f9e000   ecx: e3f9e000   edx: 00000001
esi: 85525fe9   edi: eae38438   ebp: d86ec8ac   esp: e0c2fedc
ds: 007b   es: 007b   ss: 0068
Process mythbackend (pid: 15225, threadinfo=e0c2f000 task=f3290a20)
Stack: e7f36b80 eae38380 f8f9d03d e7f36bc4 00001f18 e3f9e000 23f9e000 eae383a4
        d8931e80 f9091bdd e7f36b80 eae38438 00000000 00000000 f5034ca0 d86ec8ac
        f9020ba9 d8931e80 eae38380 00000000 c180f400 e6d09e94 e6d09e94 e6d09ebc
Call Trace:
  [<f8f9d03d>] btcx_riscmem_free+0x3d/0x84 [btcx_risc]
  [<f9091bdd>] bttv_dma_free+0x74/0x9f [bttv]
  [<f9020ba9>] videobuf_vm_close+0x97/0xc9 [video_buf]
  [<c014b593>] remove_vm_struct+0x91/0x93
  [<c014cd7f>] unmap_vma_list+0x1c/0x28
  [<c014d145>] do_munmap+0x14d/0x19e
  [<c014d1e7>] sys_munmap+0x51/0x76
  [<c010508b>] syscall_call+0x7/0xb
Code: 44 24 0c 8b 54 24 10 8b 5c 24 14 85 c0 74 06 8b b0 b8 00 00 00 8d 42 ff ba ff ff ff ff c1 e8 0b 83 c2 01 d1 e8 75 f9 85 f6 74 13 <8b> 0e 39 cb 72 0d 8b 46 08 c1 e0 0c 8d 04 08 39 c3 72 09 89 d8

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
