Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUKAJ0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUKAJ0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUKAJ0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:26:22 -0500
Received: from gyre.foreca.com ([193.94.59.26]:30423 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id S261665AbUKAJ0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:26:08 -0500
Date: Mon, 1 Nov 2004 11:25:57 +0200 (EET)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: ext3 and nfsd do not work under load (Re: x86_64, LOCKUP on CPU0,
 kjournald)
In-Reply-To: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
Message-ID: <Pine.LNX.4.58.0411010847180.2172@gyre.weather.fi>
References: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is another oops and lockup, with nfsd now there in the trace also:

Unable to handle kernel paging request at ffffffff00000808 RIP:
<ffffffff80161b37>{cache_alloc_refill+329}
PML4 103027 PGD 0
Oops: 0002 [1] SMP
CPU 0
Modules linked in: w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
Pid: 1968, comm: nfsd Not tainted 2.6.8-1.521smp
RIP: 0010:[<ffffffff80161b37>] <ffffffff80161b37>{cache_alloc_refill+329}
RSP: 0018:000001003ad8d728  EFLAGS: 00010046
RAX: ffffffff00000800 RBX: 00000000ffffffff RCX: 0000010001000000
RDX: 00000100400112c8 RSI: 00000000000000d0 RDI: 0000010040011280
RBP: 000001003ffb7000 R08: a322eb30453b40eb R09: 0000000000000008
R10: 000001004d6bdb00 R11: 000001004d6bdb00 R12: 00000100400112c8
R13: 0000010040011280 R14: 00000000000000d0 R15: 0000000000000001
FS:  0000002a958624c0(0000) GS:ffffffff804e2d80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff00000808 CR3: 0000000000101000 CR4: 00000000000006e0
Process nfsd (pid: 1968, threadinfo 000001003ad8c000, task 00000100be7e5550)
Stack: 0000010076ba4388 0000010076ba4388 fffffffffffffff4 0000010076ba4388
       000001003ad8d7e8 0000000000000000 000001009c01a188 ffffffff80161eae
       0000000000000283 ffffffff80195755
Call Trace:<ffffffff80161eae>{kmem_cache_alloc+52} <ffffffff80195755>{d_alloc+196}
       <ffffffff8018a272>{cached_lookup+40} <ffffffff8018bc42>{__lookup_hash+117}
       <ffffffff8018bcdc>{lookup_one_len+87} <ffffffffa0173c4e>{:nfsd:compose_entry_fh+279}
       <ffffffffa0173e6f>{:nfsd:encode_entry+460} <ffffffff80318579>{thread_return+41}
       <ffffffff80248b5c>{__generic_unplug_device+49} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa017419b>{:nfsd:nfs3svc_encode_entry_plus+9}
       <ffffffffa0048aa4>{:ext3:call_filldir+137} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa0048c0d>{:ext3:ext3_dx_readdir+331} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa00484e2>{:ext3:ext3_readdir+131} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa0168679>{:nfsd:fh_verify+1324} <ffffffff80131f3b>{recalc_task_prio+332}
       <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffff80190053>{vfs_readdir+123} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa016bd8d>{:nfsd:nfsd_readdir+104} <ffffffffa017149a>{:nfsd:nfsd3_proc_readdirplus+245}
       <ffffffffa01668c2>{:nfsd:nfsd_dispatch+226} <ffffffffa012fb83>{:sunrpc:svc_process+931}
       <ffffffffa01665b7>{:nfsd:nfsd+750} <ffffffffa01662c9>{:nfsd:nfsd+0}
       <ffffffff801121e3>{child_rip+8} <ffffffffa01662c9>{:nfsd:nfsd+0}
       <ffffffffa01662c9>{:nfsd:nfsd+0} <ffffffff801121db>{child_rip+0}


Code: 48 89 50 08 48 89 02 48 c7 41 08 00 02 20 00 66 83 79 24 ff
RIP <ffffffff80161b37>{cache_alloc_refill+329} RSP <000001003ad8d728>
CR2: ffffffff00000808
 NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0
Modules linked in: w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
Pid: 1968, comm: nfsd Not tainted 2.6.8-1.521smp
RIP: 0010:[<ffffffff80163549>] <ffffffff80163549>{.text.lock.slab+338}
RSP: 0018:ffffffff80480b38  EFLAGS: 00000086
RAX: 000000010fe430f5 RBX: 0000010040011280 RCX: 000000000000001e
RDX: 000000000000001d RSI: 000001003ffb7000 RDI: 0000010040011280
RBP: 0000010040011370 R08: 000001003ffac010 R09: 00000100bfc34d80
R10: 0000010040011280 R11: 0000010040011280 R12: 00000100bfc34e28
R13: 0000000000000002 R14: ffffffff804af7e0 R15: 0000000000000000
FS:  0000002a958624c0(0000) GS:ffffffff804e2d80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff00000808 CR3: 0000000000101000 CR4: 00000000000006e0
Process nfsd (pid: 1968, threadinfo 000001003ad8c000, task 00000100be7e5550)
Stack: 0000010001e0fb60 0000000000000000 ffffffff80480b98 0000000000000292
       0000000000000000 0000010001e13020 ffffffff80480bb8 000001003ad8d678
       0000000000000002 ffffffff80162bcd
Call Trace:<IRQ> <ffffffff80162bcd>{reap_timer_fnc+31} <ffffffff80141c08>{run_timer_softirq+427}
       <ffffffff8013d965>{__do_softirq+65} <ffffffff8013d970>{__do_softirq+76}
       <ffffffff8013d9fd>{do_softirq+49} <ffffffff80111e91>{apic_timer_interrupt+133}
        <EOI> <ffffffff80112d92>{oops_end+80} <ffffffff80112d54>{oops_end+18}
       <ffffffff80123f80>{do_page_fault+1008} <ffffffff8017efb4>{__getblk+17}
       <ffffffffa004afb1>{:ext3:ext3_getblk+195} <ffffffff8017eed8>{bh_lru_install+221}
       <ffffffff8011202d>{error_exit+0} <ffffffff80161b37>{cache_alloc_refill+329}
       <ffffffff80195a25>{d_instantiate+202} <ffffffff80161eae>{kmem_cache_alloc+52}
       <ffffffff80195755>{d_alloc+196} <ffffffff8018a272>{cached_lookup+40}
       <ffffffff8018bc42>{__lookup_hash+117} <ffffffff8018bcdc>{lookup_one_len+87}
       <ffffffffa0173c4e>{:nfsd:compose_entry_fh+279} <ffffffffa0173e6f>{:nfsd:encode_entry+460}
       <ffffffff80318579>{thread_return+41} <ffffffff80248b5c>{__generic_unplug_device+49}
       <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa017419b>{:nfsd:nfs3svc_encode_entry_plus+9}
       <ffffffffa0048aa4>{:ext3:call_filldir+137} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa0048c0d>{:ext3:ext3_dx_readdir+331} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa00484e2>{:ext3:ext3_readdir+131} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa0168679>{:nfsd:fh_verify+1324} <ffffffff80131f3b>{recalc_task_prio+332}
       <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffff80190053>{vfs_readdir+123} <ffffffffa0174192>{:nfsd:nfs3svc_encode_entry_plus+0}
       <ffffffffa016bd8d>{:nfsd:nfsd_readdir+104} <ffffffffa017149a>{:nfsd:nfsd3_proc_readdirplus+245}
       <ffffffffa01668c2>{:nfsd:nfsd_dispatch+226} <ffffffffa012fb83>{:sunrpc:svc_process+931}
       <ffffffffa01665b7>{:nfsd:nfsd+750} <ffffffffa01662c9>{:nfsd:nfsd+0}
       <ffffffff801121e3>{child_rip+8} <ffffffffa01662c9>{:nfsd:nfsd+0}
       <ffffffffa01662c9>{:nfsd:nfsd+0} <ffffffff801121db>{child_rip+0}


Code: 80 7d b8 00 7e f8 e9 b4 f4 ff ff f3 90 80 bb a8 00 00 00 00
console shuts up ...


On Tue, 26 Oct 2004, Jaakko Hyvätti wrote:
> Last night we got this trace, saved by serial console.
>
> The machine is dual AMD Opteron 240 (1.4GHz), MSI K8D motherboard, 3G
> mem, disks in raid configuration with 3ware SATA adapter, so they show
> up as scsi devices.  Kernel is updated Fedora Core 2 2.6.8-1.521smp,
> but the same probably happened with 2.6.6 at least, cannot tell as I
> did not have serial console back then.  Disks are shared over nfs to
> a few very very busy clients, some running Linux, some running IRIX.
>
>
> NMI Watchdog detected LOCKUP on CPU0, registers:
> CPU 0
> Modules linked in: loop w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
> Pid: 210, comm: kjournald Not tainted 2.6.8-1.521smp
> RIP: 0010:[<ffffffff80161b7b>] <ffffffff80161b7b>{cache_alloc_refill+397}
> RSP: 0018:00000100bf4efa58  EFLAGS: 00000013
> RAX: 00000100bff39000 RBX: 0000000000000031 RCX: 00000100400116d8
> RDX: 00000100400116c8 RSI: 0000000000000850 RDI: 0000010040011680
> RBP: 000001003ffbf000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000010095e05e00 R12: 00000100400116c8
> R13: 0000010040011680 R14: 0000000000000850 R15: 0000010031cdb9d0
> FS:  0000002a958624c0(0000) GS:ffffffff804e2d80(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000000000a02b5c CR3: 0000000000101000 CR4: 00000000000006e0
> Process kjournald (pid: 210, threadinfo 00000100bf4ee000, task 0000010037d201f0)
> Stack: 000001007e657558 000001007e657558 00000100bdc356e0 000001007e657558
>        000001003ffb5e00 000001003c2ed180 000001007e657558 ffffffff80161eae
>        0000000000000202 ffffffff80180d98
> Call Trace:<ffffffff80161eae>{kmem_cache_alloc+52} <ffffffff80180d98>{alloc_buffer_head+17}
>        <ffffffffa003b620>{:jbd:journal_write_metadata_buffer+130}
>        <ffffffffa0038064>{:jbd:journal_commit_transaction+2847}
>        <ffffffff801367e2>{autoremove_wake_function+0} <ffffffff801367e2>{autoremove_wake_function+0}
>        <ffffffffa003b0e3>{:jbd:kjournald+333} <ffffffff801367e2>{autoremove_wake_function+0}
>        <ffffffff801367e2>{autoremove_wake_function+0} <ffffffffa003af90>{:jbd:commit_timeout+0}
>        <ffffffff801121e3>{child_rip+8} <ffffffffa003af96>{:jbd:kjournald+0}
>        <ffffffff801121db>{child_rip+0}
>
> Code: 4c 89 61 08 49 89 0c 24 85 db 0f 8f 2c ff ff ff 8b 45 00 49
> console shuts up ...

-- 
Foreca Ltd                                           Jaakko.Hyvatti@foreca.com
Pursimiehenkatu 29-31 B, FIN-00150 Helsinki, Finland     http://www.foreca.com
