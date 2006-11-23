Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932953AbWKWHiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953AbWKWHiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 02:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWKWHiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 02:38:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:29141 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932953AbWKWHiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 02:38:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fL2cLVbY8mg1lYMIT1yQ0yG1TkflniSky1BgBIDpJEhudzqUiM0Sf2SU0hbQyl0SHnKGSAvVzKxCz59t3/BbZXkZDnlMu/vbsfyizaTaGQzydeC0MvFNc0vYlWw0Hny3xIJVIGEHNqpsfgno7Na9qw9asLt7ODnYRmtpaET8Hxo=
Message-ID: <37d33d830611222337t20ff02f8xfee72aa9c7e64439@mail.gmail.com>
Date: Thu, 23 Nov 2006 13:07:59 +0530
From: "Sandeep Kumar" <sandeepksinha@gmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>
Subject: kernel BUG at fs/inode.c:1139!
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I got  the following error insidea kernel module.

My module made a call to the blkdev_get ( ) inside the module and I
get the following error.

I also checked the line from fs/inode.c line number 1139 :

Its BUG_ON(inode->i_state == I_CLEAR);

What can be the possible reason for this assertion to hold true.
Kindly help.




Nov 22 17:54:34 localhost kernel: ------------[ cut here ]------------
 Nov 22 17:54:34 localhost kernel: kernel BUG at fs/inode.c:1139!
 Nov 22 17:54:34 localhost kernel: invalid opcode: 0000 [#1]
 Nov 22 17:54:34 localhost kernel: Modules linked in: dm_cdp
parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc dm_mod
video button battery asus_acpi ac ipv6 uhci_hcd shpchp i2c_piix4
i2c_core snd_ens1371 gameport snd_rawmidi snd_ac97_codec snd_ac97_bus
snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc pcnet32 mii floppy ext3 jbd BusLogic sd_mod scsi_mod
 Nov 22 17:54:34 localhost kernel: CPU:    0
 Nov 22 17:54:34 localhost kernel: EIP:    0060:[<c016507d>]
Tainted: P      VLI
 Nov 22 17:54:34 localhost kernel: EFLAGS: 00010246   (2.6.18 #1)
 Nov 22 17:54:34 localhost kernel: EIP is at iput+0x19/0x66
 Nov 22 17:54:34 localhost kernel: eax: c032df20   ebx: cb7359c4
ecx: d0970798   edx: c116e6a0
 Nov 22 17:54:34 localhost kernel: esi: c0ec5ec0   edi: 00000300
ebp: 00000000   esp: ca33de78
 Nov 22 17:54:34 localhost kernel: ds: 007b   es: 007b   ss: 0068
 Nov 22 17:54:34 localhost kernel: Process a.out (pid: 29096,
ti=ca33d000 task=c533c0f0 task.ti=ca33d000)
 Nov 22 17:54:34 localhost kernel: Stack: cb735940 d097039b c0ec5ec0
ca33de98 c0ec5ec4 00000006 d09705a2 00316764
 Nov 22 17:54:34 localhost kernel:        00768e2c 0083b5e0 00768e2c
0083b740 b7ff2000 00000009 0083aff4 00000000
 Nov 22 17:54:34 localhost kernel:        b7ff32ac b7ff63e0 00711fb4
007126d0 08048218 bfb8acf0 007046d8 00712878
 Nov 22 17:54:34 localhost kernel: Call Trace:
 Nov 22 17:54:34 localhost kernel:  [<d097039b>]
get_dev_info+0x72/0x150 [dm_cdp]
 Nov 22 17:54:34 localhost kernel:  [<d09705a2>] cdp_ioctl+0x129/0x28e [dm_cdp]
 Nov 22 17:54:34 localhost kernel:  [<c019e6b4>] file_has_perm+0x7f/0x88
 Nov 22 17:54:34 localhost kernel:  [<d0970479>] cdp_ioctl+0x0/0x28e [dm_cdp]
 Nov 22 17:54:34 localhost kernel:  [<c015fb29>] do_ioctl+0x39/0x48
 Nov 22 17:54:34 localhost kernel:  [<c015fd32>] vfs_ioctl+0x1fa/0x211
 Nov 22 17:54:34 localhost kernel:  [<c015fd8f>] sys_ioctl+0x46/0x5f
 Nov 22 17:54:34 localhost kernel:  [<c0102b33>] syscall_call+0x7/0xb
 Nov 22 17:54:34 localhost kernel: Code: 04 89 33 89 5e 04 b8 d8 e2 32
c0 5b 5e e9 49 6b 16 00 53 89 c3 85 c0 74 5d 8b 80 c0 00 00 00 8b 40
20 83 bb 90 01 00 00 20 75 08 <0f> 0b 73 04 2f aa 2e c0 85 c0 74 0b 8b
50 14 85 d2 74 04 89 d8
 Nov 22 17:54:34 localhost kernel: EIP: [<c016507d>] iput+0x19/0x66
SS:ESP 0068:ca33de78
 Nov 22 17:55:50 localhost gpm[1997]: *** info [client.c(137)]:


-- 
Regards,
Sandeep


-- 
Regards,
Sandeep





Winners expect to win in advance. Life is a self-fulfilling prophecy.
