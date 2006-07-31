Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWGaXrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWGaXrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWGaXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:47:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:59318 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932190AbWGaXrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:47:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=A8PpvSkznJEnCg6yEdsBtLVpYTN3xifhDmWX4tZtmZa1YV+gbqbV/Y/nDOOMEIEtqswhX0iIJUUCC2ExfE2nNXzLQwWYHf/cALdUt5Scb5ayT3kqaAtMeVlGrdDGc8ktY4tHMQsJPziFN0V1zyseFimUTNCKSryokavw0Q5WSy0=
Message-ID: <44CE96A1.2010009@gmail.com>
Date: Tue, 01 Aug 2006 01:47:22 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: usb related oops after resume
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

during resume I got this oops in 2.6.18-rc1-mm2 kernel:
[   23.633322] Restarting tasks...<6>usb 3-2: USB disconnect, address 2
[   23.633447] BUG: unable to handle kernel NULL pointer dereference at virtual 
address 00000000
[   23.633469]  printing eip:
[   23.633479] c0372aa0
[   23.633489] *pde = 00000000
[   23.633500] Oops: 0002 [#1]
[   23.633510] 4K_STACKS SMP
[   23.633523] last sysfs file: /devices/platform/i2c-9191/9191-0290/temp3_input
[   23.633537] Modules linked in: vfat fat ipv6 binfmt_misc parport floppy 
snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 
ohci1394 snd_rawmidi ieee1394 snd_ac97_codec snd_ac97_bus snd_util_mem ide_cd 
snd_hwdep cdrom
[   23.633612] CPU:    0
[   23.633612] EIP:    0060:[<c0372aa0>]    Not tainted VLI
[   23.633613] EFLAGS: 00010246   (2.6.18-rc1-mm2 #152)
[   23.633648] EIP is at _spin_lock+0x3/0x13
[   23.633660] eax: 00000000   ebx: 00000000   ecx: c18ec8c0   edx: c1a033a8
[   23.633674] esi: f7ffecac   edi: c0453720   ebp: c19f0ea4   esp: c19f0ea4
[   23.633688] ds: 007b   es: 007b   ss: 0068
[   23.633700] Process khubd (pid: 98, ti=c19f0000 task=c19efa90 task.ti=c19f0000)
[   23.633714] Stack: c19f0eb4 c0370094 f7ffecd0 f7ffec58 c19f0ed0 c026c512 
f7ffecac f7ffed10
[   23.633748]        f7ffeebc f7ffec58 f7ffecd0 c19f0ef0 c026af50 f7ffec58 
f7ffed24 f7d08458
[   23.633781]        f7ffeebc 00000010 f7ffec00 c19f0f18 c02a30f0 f7ffec58 
00000000 f7ffed10
[   23.633813] Call Trace:
[   23.633830]  [<c0104060>] show_stack_log_lvl+0xa5/0xca
[   23.633846]  [<c0104280>] show_registers+0x1b6/0x23b
[   23.633861]  [<c010444f>] die+0x14a/0x32c
[   23.633874]  [<c0118397>] do_page_fault+0x28f/0x5a9
[   23.633889]  [<c0103bc1>] error_code+0x39/0x40
[   23.633902]  [<c0370094>] klist_remove+0x11/0x29
[   23.633917]  [<c026c512>] bus_remove_device+0x9d/0xbb
[   23.633934]  [<c026af50>] device_del+0x13a/0x174
[   23.633948]  [<c02a30f0>] usb_disconnect+0xb4/0xe9
[   23.633962]  [<c02a3d1c>] hub_thread+0x1ee/0xc18
[   23.633976]  [<c01353d2>] kthread+0xfe/0x102
[   23.633991]  [<c0101005>] kernel_thread_helper+0x5/0xb
[   23.634006] Code: c8 5d c3 55 89 e5 89 c2 90 81 28 00 00 00 01 0f 94 c0 b9 01 
00 00 00 84 c0 75 09 90 81 02 00 00 00 01 30 c9 89 c8 5d c3 55 89 e5 <f0> fe 08 
79 09 f3 90 80 38 00 7e f9 eb f2 5d c3 55 89 e5 f0 81
[   23.634132] EIP: [<c0372aa0>] _spin_lock+0x3/0x13 SS:ESP 0068:c19f0ea4
[   23.634383]   done
[   23.634893] Thawing cpus ...
[   23.646353] SMP alternatives: switching to SMP code

It was maybe (forgot to lsusb, but no other usb device was connected) wacom 
driver, if it is important.

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
