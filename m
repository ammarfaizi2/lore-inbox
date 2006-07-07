Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWGGQNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWGGQNT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWGGQNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:13:19 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:42897 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932155AbWGGQNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:13:19 -0400
Date: Fri, 7 Jul 2006 13:13:10 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Andrew Morton <akpm@osdl.org>
Cc: "Michael Kerrisk" <mtk-manpages@gmx.net>, axboe@suse.de,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       vendor-sec@lst.de
Subject: Re: splice/tee bugs?
Message-ID: <20060707131310.0e382585@doriath.conectiva>
In-Reply-To: <20060707040749.97f8c1fc.akpm@osdl.org>
References: <20060707070703.165520@gmx.net>
	<20060707040749.97f8c1fc.akpm@osdl.org>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.4.0-rc2 (GTK+ 2.9.4; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 04:07:49 -0700
Andrew Morton <akpm@osdl.org> wrote:

| On Fri, 07 Jul 2006 09:07:03 +0200
| "Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
| 
| > c) Occasionally the command line just hangs, producing no output.
| >    In this case I can't kill it with ^C or ^\.  This is a 
| >    hard-to-reproduce behaviour on my (x86) system, but I have 
| >    seen it several times by now.
| 
| aka local DoS.  Please capture sysrq-T output next time.

 If I run lots of them in parallel, I get the following OOPs in a few
seconds:

Jul  7 13:04:52 doriath kernel: [  105.041722] BUG: unable to handle kernel NULL pointer dereference at virtual address 00000018
Jul  7 13:04:52 doriath kernel: [  105.048885]  printing eip:
Jul  7 13:04:52 doriath kernel: [  105.056095] c01790c7
Jul  7 13:04:52 doriath kernel: [  105.056097] *pde = 00000000
Jul  7 13:04:52 doriath kernel: [  105.063516] Oops: 0000 [#1]
Jul  7 13:04:52 doriath kernel: [  105.071116] Modules linked in: ipv6 capability commoncap snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq via_rhine mii snd_pcm_oss snd_mixer_oss af_packet snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore rfcomm l2cap bluetooth ide_cd cdrom binfmt_misc loop sata_via libata scsi_mod video thermal processor fan container button battery asus_acpi ac amd64_agp agpgart ehci_hcd uhci_hcd usbcore xfs
Jul  7 13:04:52 doriath kernel: [  105.129492] CPU:    0
Jul  7 13:04:52 doriath kernel: [  105.129494] EIP:    0060:[sys_tee+371/924]    Not tainted VLI
Jul  7 13:04:52 doriath kernel: [  105.129494] EIP:    0060:[<c01790c7>]    Not tainted VLI
Jul  7 13:04:52 doriath kernel: [  105.129495] EFLAGS: 00010293   (2.6.18-rc1 #8) 
Jul  7 13:04:52 doriath kernel: [  105.170966] EIP is at sys_tee+0x173/0x39c
Jul  7 13:04:52 doriath kernel: [  105.185414] eax: d62bfa00   ebx: 00000000   ecx: 00000000   edx: d62bfa98
Jul  7 13:04:52 doriath kernel: [  105.200731] esi: d7434800   edi: d62bfa98   ebp: d5d5cfb4   esp: d5d5cf84
Jul  7 13:04:52 doriath kernel: [  105.216341] ds: 007b   es: 007b   ss: 0068
Jul  7 13:04:52 doriath kernel: [  105.232017] Process ktee (pid: 12605, ti=d5d5c000 task=d9cce0b0 task.ti=d5d5c000)
Jul  7 13:04:52 doriath kernel: [  105.233023] Stack: d5eede40 00000000 d827ac00 00000002 00000000 d62bfa00 00000000 00000000 
Jul  7 13:04:52 doriath kernel: [  105.250147]        00000000 00000000 00000000 b7f72920 d5d5c000 c0102b7d 00000000 00000001 
Jul  7 13:04:52 doriath kernel: [  105.267904]        7fffffff 00000000 b7f72920 bf8f37b8 0000013b 0000007b 0000007b 0000013b 
Jul  7 13:04:52 doriath kernel: [  105.286091] Call Trace:
Jul  7 13:04:52 doriath kernel: [  105.321546]  [show_stack_log_lvl+140/151] show_stack_log_lvl+0x8c/0x97
Jul  7 13:04:52 doriath kernel: [  105.321546]  [<c010422c>] show_stack_log_lvl+0x8c/0x97
Jul  7 13:04:52 doriath kernel: [  105.340519]  [show_registers+292/401] show_registers+0x124/0x191
Jul  7 13:04:52 doriath kernel: [  105.340519]  [<c0104397>] show_registers+0x124/0x191
Jul  7 13:04:52 doriath kernel: [  105.359642]  [die+332/617] die+0x14c/0x269
Jul  7 13:04:53 doriath kernel: [  105.359642]  [<c0104550>] die+0x14c/0x269
Jul  7 13:04:53 doriath kernel: [  105.378978]  [do_page_fault+1091/1310] do_page_fault+0x443/0x51e
Jul  7 13:04:53 doriath kernel: [  105.378978]  [<c02a6521>] do_page_fault+0x443/0x51e
Jul  7 13:04:53 doriath kernel: [  105.398696]  [error_code+57/64] error_code+0x39/0x40
Jul  7 13:04:53 doriath kernel: [  105.398696]  [<c0103d49>] error_code+0x39/0x40
Jul  7 13:04:53 doriath kernel: [  105.418612]  [sysenter_past_esp+86/121] sysenter_past_esp+0x56/0x79
Jul  7 13:04:54 doriath kernel: [  105.418612]  [<c0102b7d>] sysenter_past_esp+0x56/0x79
Jul  7 13:04:54 doriath kernel: [  105.438935] Code: 00 00 00 89 d0 8b 55 e4 03 42 6c 83 e0 0f 6b c0 14 8d 7c 10 70 8b 46 68 89 45 e0 83 f8 0f 77 5c 8b 4f 0c 8b 5e 6c 89 fa 8b 45 e4 <ff> 51 18 03 5d e0 83 e3 0f 89 fa 6b db 14 b9 14 00 00 00 8d 5c 
Jul  7 13:04:54 doriath kernel: [  105.506704] EIP: [sys_tee+371/924] sys_tee+0x173/0x39c SS:ESP 0068:d5d5cf84
Jul  7 13:04:54 doriath kernel: [  105.506704] EIP: [<c01790c7>] sys_tee+0x173/0x39c SS:ESP 0068:d5d5cf84

-- 
Luiz Fernando N. Capitulino
