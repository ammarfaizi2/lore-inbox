Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWCUMGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWCUMGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWCUMGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:06:38 -0500
Received: from picard.linux.it ([213.254.12.146]:28875 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1750736AbWCUMGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:06:37 -0500
Message-ID: <39320.217.33.203.18.1142942796.squirrel@picard.linux.it>
In-Reply-To: <200603211252.34797@zodiac.zodiac.dnsalias.org>
References: <200603211219.14115@zodiac.zodiac.dnsalias.org>
    <20060321033251.32ca71da.akpm@osdl.org>
    <200603211252.34797@zodiac.zodiac.dnsalias.org>
Date: Tue, 21 Mar 2006 13:06:36 +0100 (CET)
Subject: Re: Bug on unmounting in 2.6.16-rc6-mm2
From: "Mattia Dongili" <malattia@linux.it>
To: "Alexander Gran" <alex@zodiac.dnsalias.org>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs@namesys.com
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20060321130636_64226"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20060321130636_64226
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

On Tue, March 21, 2006 12:52 pm, Alexander Gran said:
> Am Dienstag, 21. März 2006 12:32 schrieb Andrew Morton:
[...]
>> > Sorry for the inconvenience, but I've got no OCR at hand ;)
>> Is it reproducible?
>
> Yep.

This is probably the same I get unmounting a reiser4 partition.
I got the oops through netconsole, attached to avoid line wrapping.

-- 
mattia
:wq!

------=_20060321130636_64226
Content-Type: text/plain; name="oops.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="oops.txt"

[17180020.572000] kernel BUG at fs/inode.c:1146!
[17180020.572000] invalid opcode: 0000 [#1]
[17180020.572000] PREEMPT
[17180020.572000] last sysfs file: /devices/system/cpu/cpu0/cpufreq/scaling_max_freq
[17180020.572000] Modules linked in: netconsole nfsd exportfs lockd sunrpc ipt_MASQUERADE iptable_nat ip_nat xt_tcpudp                       xt_state ip_conntrack iptable_filter ip_tables x_tables reiser4 xfs sd_mod rtc sony_acpi tun psmouse sonypi speedstep_i                      ch speedstep_lib freq_table evdev pcspkr usbhid cpufreq_ondemand cpufreq_powersave usb_storage scsi_mod pcmcia snd_inte                      l8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer e100 mii yenta_socket rsrc_nonstatic pcmci                      a_core snd soundcore snd_page_alloc intel_agp agpgart uhci_hcd usbcore hw_random i2c_i801
[17180020.572000] CPU:    0
[17180020.572000] EIP:    0060:[<c0178a84>]    Not tainted VLI
[17180020.572000] EFLAGS: 00010246   (2.6.16-rc6-mm2-2 #16)
[17180020.572000] EIP is at iput+0x74/0x80
[17180020.572000] eax: c03b1b00   ebx: c123f8c4   ecx: ceee6b30   edx: ceee6b30
[17180020.572000] esi: c123f860   edi: cf2e1000   ebp: cbbf5e1c   esp: cbbf5e10
[17180020.572000] ds: 007b   es: 007b   ss: 0068
[17180020.572000] Process umount (pid: 3496, threadinfo=cbbf5000 task=ce169a50)
[17180020.572000] Stack: <0>00000000 00000001 ceee6a4c cbbf5e30 c0165d70 c123f8c4 ceee6a4c ceee6b68
[17180020.572000]        cbbf5e44 c017935e ceee6a4c ceee6a4c cbbf5000 cbbf5e60 c0179b1a ceee6a4c
[17180020.572000]        00000001 d1484d22 ceee6a4c cf70d2a0 cbbf5e74 c0178a7e ceee6a4c c0446260
[17180020.572000] Call Trace:
[17180020.572000]  <c01039ad> show_stack_log_lvl+0xbd/0x100   <c0103b8b> show_registers+0x19b/0x230
[17180020.572000]  <c0103ece> die+0x11e/0x270   <c0104258> do_trap+0x98/0xe0
[17180020.572000]  <c0104571> do_invalid_op+0xa1/0xb0   <c0103293> error_code+0x4f/0x54
[17180020.572000]  <c0165d70> bd_forget+0x80/0x90   <c017935e> clear_inode+0x7e/0xc0
[17180020.572000]  <c0179b1a> generic_drop_inode+0x14a/0x1a0   <c0178a7e> iput+0x6e/0x80
[17180020.572000]  <d1452c2a> done_formatted_fake+0x5a/0x70 [reiser4]   <d145596a> reiser4_put_super+0x4a/0xe0 [reiser4                      ]
[17180020.572000]  <c0164292> generic_shutdown_super+0x92/0x190   <c01643b9> kill_block_super+0x29/0x50
[17180020.572000]  <c0164667> deactivate_super+0x67/0x90   <c017b980> mntput_no_expire+0x60/0xb0
[17180020.572000]  <c016bd7f> path_release_on_umount+0x1f/0x30   <c017c793> sys_umount+0x43/0x250
[17180020.572000]  <c017c9b7> sys_oldumount+0x17/0x20   <c0102fff> syscall_call+0x7/0xb
[17180020.572000] Code: 24 8b 83 90 00 00 00 ba d0 99 17 c0 8b 40 20 85 c0 74 0d 8b 50 18 b8 d0 99 17 c0 85 d2 0f 44 d0                       89 1c 24 ff d2 83 c4 08 5b 5d c3 <0f> 0b 7a 04 47 46 32 c0 eb a2 89 f6 55 89 e5 83 ec 08 8b 45 08
[17180020.572000]  BUG: warning at kernel/exit.c:847/do_exit()
[17180020.828000]  <c0103c63> show_trace+0x13/0x20   <c0103c8e> dump_stack+0x1e/0x20
[17180020.836000]  <c011cf81> do_exit+0x941/0x960   <c0104020> do_simd_coprocessor_error+0x0/0x1a0
[17180020.844000]  <c0104258> do_trap+0x98/0xe0   <c0104571> do_invalid_op+0xa1/0xb0
[17180020.848000]  <c0103293> error_code+0x4f/0x54   <c0165d70> bd_forget+0x80/0x90
[17180020.856000]  <c017935e> clear_inode+0x7e/0xc0   <c0179b1a> generic_drop_inode+0x14a/0x1a0
[17180020.864000]  <c0178a7e> iput+0x6e/0x80   <d1452c2a> done_formatted_fake+0x5a/0x70 [reiser4]
[17180020.872000]  <d145596a> reiser4_put_super+0x4a/0xe0 [reiser4]   <c0164292> generic_shutdown_super+0x92/0x190
[17180020.888000]  <c01643b9> kill_block_super+0x29/0x50   <c0164667> deactivate_super+0x67/0x90
[17180020.896000]  <c017b980> mntput_no_expire+0x60/0xb0   <c016bd7f> path_release_on_umount+0x1f/0x30
[17180020.912000]  <c017c793> sys_umount+0x43/0x250   <c017c9b7> sys_oldumount+0x17/0x20
[17180020.920000]  <c0102fff> syscall_call+0x7/0xb
[17180020.928000] ReiserFS: hda1: warning: clm-2100: nesting info a different FS
[17180020.936000] ReiserFS: hda1: warning: clm-2100: nesting info a different FS
------=_20060321130636_64226--


