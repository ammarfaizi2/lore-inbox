Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbUKFHQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbUKFHQW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 02:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbUKFHQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 02:16:22 -0500
Received: from main.gmane.org ([80.91.229.2]:34704 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261327AbUKFHQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 02:16:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.6.10-rc1-mm3
Date: Sat, 6 Nov 2004 07:16:12 +0000 (UTC)
Message-ID: <slrncoouhs.v5k.psavo@varg.dyndns.org>
References: <20041105001328.3ba97e08.akpm@osdl.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm3/

On 2xSMP

Ran tvtime, exited it (seemingly) OK, but shell didn't return. No
reaction to ^C, however ^Z brought shell back. Killed tvtime and bash
reported that it was terminated. Load went to 1. Did a 'ps aux', which
'hanged' after displaying most of process list. So I straced another
one, which hanged at read() of /proc/<pid>/cmdline (<pid> was of
supposedly dead tvtime). Also, these didn't react to ^C nor ^Z.
kill -9 -1 <pidofdeadtvtime> hanged machine solid.

Found that dump in log later. I know it's not Oops, what is it?

This could be an older issue, I had a 2.6.9-mm1 which suddenly put
load to 1 and never went down from that (it did reboot cleanly into 
2.6.10-rc1-mm3).

- -
Nov  6 00:49:27 tienel kernel: c010a4a9
Nov  6 00:49:27 tienel kernel: PREEMPT SMP
Nov  6 00:49:27 tienel kernel: Modules linked in: mga sd_mod sg sr_mod ide_cd cdrom binfmt_misc ipv6 snd_bt87x tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev ub e100 ohci_hcd evdev nls_iso8859_1 nls_cp437 vfat fat joydev usbhid usb_storage usbcore scsi_mod amd_k7_agp agpgart snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc gameport w83781d i2c_sensor i2c_amd756 i2c_core eepro100 mii
Nov  6 00:49:27 tienel kernel: CPU:    0
Nov  6 00:49:27 tienel kernel: EIP:    0060:[dma_free_coherent+41/96] Tainted: P      VLI
Nov  6 00:49:27 tienel kernel: EFLAGS: 00210202   (2.6.10-rc1-mm3)
Nov  6 00:49:27 tienel kernel: EIP is at dma_free_coherent+0x29/0x60
Nov  6 00:49:27 tienel kernel: eax: 00000000   ebx: e3bb8000   ecx: e3bb8000   edx: 00000000
Nov  6 00:49:27 tienel kernel: esi: 00000001   edi: e28e911c   ebp: f38974c0   esp: cf43ff14
Nov  6 00:49:27 tienel kernel: ds: 007b   es: 007b   ss: 0068
Nov  6 00:49:27 tienel kernel: Process tvtime (pid: 13513, threadinfo=cf43e000 task=cf736a60)
Nov  6 00:49:27 tienel kernel: Stack: 00000000 e3bb8000 f89c5037 23bb8000 f89fa61e e28e9084 e28e9060 f3897100
Nov  6 00:49:27 tienel kernel:        c4fdc17c f8a2fe45 00000000 f77ce8a0 c4fdc17c f89fbb8b c18073c0 ecbf1820
Nov  6 00:49:27 tienel kernel:        c4fdc17c c72b8d04 c72b8ce8 c72b8ce8 c72b8d14 f7870880 c014d88f 00000000
Nov  6 00:49:27 tienel kernel: Call Trace:
Nov  6 00:49:27 tienel kernel:  [pg0+945811511/1069777920] btcx_riscmem_free+0x37/0x80 [btcx_risc]
Nov  6 00:49:27 tienel kernel:  [pg0+946030110/1069777920] videobuf_dma_pci_unmap+0x2e/0x80 [video_buf]
Nov  6 00:49:27 tienel kernel:  [pg0+946249285/1069777920] bttv_dma_free+0x55/0x80 [bttv]
Nov  6 00:49:27 tienel kernel:  [pg0+946035595/1069777920] videobuf_vm_close+0x8b/0xc0 [video_buf]
Nov  6 00:49:27 tienel kernel:  [remove_vm_struct+127/144] remove_vm_struct+0x7f/0x90
Nov  6 00:49:27 tienel kernel:  [unmap_vma_list+14/32] unmap_vma_list+0xe/0x20
Nov  6 00:49:27 tienel kernel:  [do_munmap+269/320] do_munmap+0x10d/0x140
Nov  6 00:49:27 tienel kernel:  [sys_munmap+65/112] sys_munmap+0x41/0x70
Nov  6 00:49:27 tienel kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
Nov  6 00:49:27 tienel kernel: Code: 00 00 56 31 f6 85 c0 53 89 cb 74 06 8b b0 b8 00 00 00 8d 42 ff ba ff ff ff ff c1 e8 0b 90 8d 74 26 00 4 2 d1 e8 75 fb 85 f6 74 13 <8b> 0e 39 cb 72 0d 8b 46 08 c1 e0 0c 8d 04 08 39 c3 72 09 89 d8
- -


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>
Vivake -- Virtuaalinen valokuvauskerho <http://members.lycos.co.uk/vivake/>

