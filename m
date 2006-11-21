Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934381AbWKUPFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934381AbWKUPFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934380AbWKUPFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:05:32 -0500
Received: from main.gmane.org ([80.91.229.2]:1456 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S934378AbWKUPFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:05:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Akemi Yagi <amyagi@gmail.com>
Subject: Re: Kernel panic in cifs_revalidate
Date: Tue, 21 Nov 2006 06:58:38 -0800
Message-ID: <pan.2006.11.21.14.58.30.968552@gmail.com>
References: <92cbf19b0611210024j3c1e2c6cr4b6d47ed6aaf2925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: energy.scripps.edu
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 00:24:40 -0800, Chakri n wrote:

> Hi,
> 
> I am seeing a kernel panic in cifs module. It seems to be a result of
> invalid inode entry in dentry for the file it is trying to validate.
> 
> The inode->i_ino is set zero and inode->i_mapping is set to NULL in
> the inode pointer in the dentry (0xdf8ea200) structure. I went through
> the cifs code and could not find any valid case that could trigger
> this situation. Is there any case which can lead to this situation?
> 
> 0xed47fe70 0xc0133b30 filemap_fdatawait+0x20 (0x0, 0xe0e1c780, 0x0,
> 0xf5b35000, 0x0)
>                                kernel .text 0xc0100000 0xc0133b10 0xc0133bc0
> 0xed47feb8 0xf8b49855 [cifs]cifs_revalidate+0x225 (0xdf8ea200)
>                                cifs .text 0xf8b27060 0xf8b49630 0xf8b49af0
> 0xed47fec4 0xf8b3ec71 [cifs]cifs_d_revalidate+0x11 (0xdf8ea200, 0x0, 0xef47a031)
>                                cifs .text 0xf8b27060 0xf8b3ec60 0xf8b3ec7d
> 0xed47fed8 0xc0151c03 cached_lookup+0x43 (0xe8e03a00, 0xed47fefc, 0x0,
> 0x1, 0xe7f5b0f8)
>                                kernel .text 0xc0100000 0xc0151bc0 0xc0151c20
> 0xed47ff18 0xc01522a8 link_path_walk+0x3e8
>                                kernel .text 0xc0100000 0xc0151ec0 0xc0152610
> 0xed47ff20 0xc0152629 path_walk+0x19 (0x8002, 0x8003, 0x83141a0)
>                                kernel .text 0xc0100000 0xc0152610 0xc0152630
> 0xed47ff34 0xc015280a path_lookup+0x3a (0x0, 0x0, 0x2, 0x0, 0x0)
>                                kernel .text 0xc0100000 0xc01527d0 0xc0152810
> 0xed47ff64 0xc0152d3a open_namei+0x6a (0xef47a000, 0x8003, 0x0,
> 0xed47ff7c, 0xe8e03a00)
>                                kernel .text 0xc0100000 0xc0152cd0 0xc0153260
> 0xed47ffa0 0xc01448b1 filp_open+0x41 (0xef47a000, 0x8002, 0x0,
> 0xed47e000, 0x8002)
>                                kernel .text 0xc0100000 0xc0144870 0xc01448e0
> 0xed47ffbc 0xc0144ca1 sys_open+0x51 (0x83141a0, 0x8002, 0x0, 0x8002, 0x83141a0)
> 
> Thanks
> --Chakri

I have been getting kernel oops caused by cifs mount starting with kernel
2.6.18.  I filed a bug report to RedHat bugzilla at:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=211672

Part of the report:

Nov  2 07:49:00 sienna kernel: <addir.c: Fo 2648
Nov  2 07:49:00 sienna kernel: but unchanged
Nov  2 07:49:00 sienna kernel: </cifs/nd bloexists but unchanged
Nov  2 07:49:00 sienna kernel: <c
Nov  2 07:49:00 sienna kernel: <7ir.c: Fo
Nov  2 07:49:00 sienna kernel: <7entry f43f440c/cifs/readdir.c: File Size 298008576 and blocks 582048
Nov  2 07:49:00 sienna kernel: <- could notfs/cifs/cifs/file.fs_closedir as Xid: 165707 withta in (xid = 16d: 165708 wit15932c coode.c: CIFS VFS: leaving cifs_revalidate (xid = 165708) rc = 0
Nov  2 07:49:00 sienna kernel: = -95
Nov  2 07:49:00 sienna kernel: <: 3882
Nov  2 07:49:00 sienna kernel: <7nodetry: 0xf3e9aving c cifs_getxattr as Xing cifs_g
Nov  2 07:49:38 sienna automount[2448]: open_mount: (mount):cannot open mount module cifs (/usr/lib/autofs/mount_cifs.so: cannot open shared object file: No such file or directory)
Nov  2 07:49:50 sienna kernel: list_del corruption. next->prev should be f76b1d60, but was 00808ce5
Nov  2 07:49:50 sienna kernel: ------------[ cut here ]------------
Nov  2 07:49:50 sienna kernel: kernel BUG at lib/list_debug.c:70!
Nov  2 07:49:50 sienna kernel: invalid opcode: 0000 [#1]
Nov  2 07:49:50 sienna kernel: SMP 
Nov  2 07:49:50 sienna kernel: last sysfs file: /power/state
Nov  2 07:49:50 sienna kernel: Modules linked in: nfs lockd fscache nfs_acl nls_utf8 cifs autofs4 it87 hwmon_vid hwmon eeprom i2c_isa hidp rfcomm l2cap bluetooth sunrpc ipv6 dm_mirror dm_multipath dm_mod video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq ide_cd snd_seq_device i2c_nforce2 sg serio_raw snd_pcm_oss snd_mixer_oss cdrom forcedeth nvidia(U) snd_pcm i2c_core snd_timer floppy pcspkr snd soundcore snd_page_alloc k8_edac edac_mc ohci1394 ieee1394 sata_nv libata sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Nov  2 07:49:50 sienna kernel: CPU:    0
Nov  2 07:49:50 sienna kernel: EIP:    0060:[<c04e9568>]    Tainted: P      VLI
Nov  2 07:49:50 sienna kernel: EFLAGS: 00010086   (2.6.18-1.2798.fc6 #1) 
Nov  2 07:49:50 sienna kernel: EIP is at list_del+0x48/0x6c
Nov  2 07:49:50 sienna kernel: eax: 00000048   ebx: f76b1d60   ecx: c067e1d0   edx: 00000086
Nov  2 07:49:50 sienna kernel: esi: f7ff9dc0   edi: f4b83000   ebp: f7e7a380   esp: f7fefef8
Nov  2 07:49:50 sienna kernel: ds: 007b   es: 007b   ss: 0068
Nov  2 07:49:50 sienna kernel: Process events/0 (pid: 8, ti=f7fef000 task=c20c05e0 task.ti=f7fef000)
Nov  2 07:49:50 sienna kernel: Stack: c0641c62 f76b1d60 00808ce5 f76b1d60 c046b307 f7fdfe80 00000005 00000000 
Nov  2 07:49:50 sienna kernel:        f7ff9e60 f7ff9e60 00000005 f7ff9e40 00000000 c046b40a 00000000 00000000 
Nov  2 07:49:50 sienna kernel:        f7e7a380 f7ff9de4 f7ff9dc0 f7e7a380 f7e0ebc0 00000282 c046c82e 00000000 
Nov  2 07:49:50 sienna kernel: Call Trace:
Nov  2 07:49:50 sienna kernel:  [<c046b307>] free_block+0x63/0xdc
Nov  2 07:49:50 sienna kernel:  [<c046b40a>] drain_array+0x8a/0xb5
Nov  2 07:49:50 sienna kernel:  [<c046c82e>] cache_reap+0x53/0x117
Nov  2 07:49:50 sienna kernel:  [<c0433c30>] run_workqueue+0x83/0xc5
Nov  2 07:49:50 sienna kernel:  [<c0434520>] worker_thread+0xd9/0x10d
Nov  2 07:49:50 sienna kernel:  [<c04369f3>] kthread+0xc0/0xed
Nov  2 07:49:50 sienna kernel:  [<c0404dab>] kernel_thread_helper+0x7/0x10
Nov  2 07:49:50 sienna kernel: DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
Nov  2 07:49:50 sienna kernel: Leftover inexact backtrace:
Nov  2 07:49:50 sienna kernel:  =======================
Nov  2 07:49:50 sienna kernel: Code: c0 e8 4b c2 f3 ff 0f 0b 41 00 51 1c 64 c0 8b 03 8b 40 04 39 d8 74 1c 89 5c 24 04 89 44 24 08 c7 04 24 62 1c 64 c0 e8 26 c2 f3 ff <0f> 0b 46 00 51 1c 64 c0 8b 13 8b 43 04 89 42 04 89 10 c7 43 04 
Nov  2 07:49:50 sienna kernel: EIP: [<c04e9568>] list_del+0x48/0x6c SS:ESP 0068:f7fefef8
Nov  2 07:49:50 sienna kernel:  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Nov  2 07:49:50 sienna kernel: in_atomic():0, irqs_disabled():1
Nov  2 07:49:50 sienna kernel:  [<c04051db>] dump_trace+0x69/0x1af
Nov  2 07:49:50 sienna kernel:  [<c0405339>] show_trace_log_lvl+0x18/0x2c
Nov  2 07:49:50 sienna kernel:  [<c04058ed>] show_trace+0xf/0x11
Nov  2 07:49:50 sienna kernel:  [<c04059ea>] dump_stack+0x15/0x17
Nov  2 07:49:50 sienna kernel:  [<c0439446>] down_read+0x12/0x20
Nov  2 07:49:50 sienna kernel:  [<c0431601>] blocking_notifier_call_chain+0xe/0x29
Nov  2 07:49:50 sienna kernel:  [<c04275e8>] do_exit+0x1b/0x776
Nov  2 07:49:50 sienna kernel:  [<c040588e>] die+0x29d/0x2c2
Nov  2 07:49:50 sienna kernel:  [<c0405fd3>] do_invalid_op+0xa2/0xab
Nov  2 07:49:50 sienna kernel:  [<c0404b85>] error_code+0x39/0x40
Nov  2 07:49:50 sienna kernel: DWARF2 unwinder stuck at error_code+0x39/0x40
Nov  2 07:49:50 sienna kernel: Leftover inexact backtrace:
Nov  2 07:49:50 sienna kernel:  [<c04e9568>] list_del+0x48/0x6c
Nov  2 07:49:50 sienna kernel:  [<c046b307>] free_block+0x63/0xdc
Nov  2 07:49:50 sienna kernel:  [<c046b40a>] drain_array+0x8a/0xb5
Nov  2 07:49:50 sienna kernel:  [<c046c82e>] cache_reap+0x53/0x117
Nov  2 07:49:50 sienna kernel:  [<c0433c30>] run_workqueue+0x83/0xc5
Nov  2 07:49:50 sienna kernel:  [<c046c7db>] cache_reap+0x0/0x117
Nov  2 07:49:50 sienna kernel:  [<c0434520>] worker_thread+0xd9/0x10d
Nov  2 07:49:50 sienna kernel:  [<c041f073>] default_wake_function+0x0/0xc
Nov  2 07:49:50 sienna kernel:  [<c0434447>] worker_thread+0x0/0x10d
Nov  2 07:49:50 sienna kernel:  [<c04369f3>] kthread+0xc0/0xed
Nov  2 07:49:50 sienna kernel:  [<c0436933>] kthread+0x0/0xed
Nov  2 07:49:50 sienna kernel:  [<c0404dab>] kernel_thread_helper+0x7/0x10
Nov  2 07:49:50 sienna kernel:  =======================
Nov  2 07:52:01 sienna gpm[2544]: O0o.oops(): [console.c(83)]: 
Nov  2 07:52:01 sienna gpm[2544]: Opening console failed.


