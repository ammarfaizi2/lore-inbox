Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVDBTs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVDBTs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 14:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDBTs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 14:48:28 -0500
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:1677 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261240AbVDBTsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 14:48:01 -0500
Date: Sat, 2 Apr 2005 10:48:01 -0900
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: AMD64 Oops with 2.6.11.6 (unable to handle kernel paging request)
Message-ID: <20050402194801.GJ27594@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I have a dual Opteron system than has started oops-ing when amanda 
connects to the machine and triggers the system to calculate backup 
sizes using tar.  The behavior started with an upgrade from 2.6.10 to 
2.6.11.3, although at the time I also had the case open attempting an 
ethernet card upgrade from an 8139 -> e1000 card (which didn't work).  
The system had been up for around 6 months without any panics, running 
previous 2.6 kernels.

At the moment, the box is dead, and inaccessable until Monday, but on 
Monday I can get the config.gz and any other details that might be 
helpful.

Thanks!

Here's the oops, recovered from a serial console:

Unable to handle kernel paging request at 0000000000001cb0 RIP:
<ffffffff8015a72c>{set_slab_attr+92}
PGD 1fa8ee067 PUD 1ec42f067 PMD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in: 8139too mii crc32
Pid: 6620, comm: tar Not tainted 2.6.11.6
RIP: 0010:[<ffffffff8015a72c>] <ffffffff8015a72c>{set_slab_attr+92}
RSP: 0018:ffff8101fda5f8f0  EFLAGS: 00010093
RAX: ffffffff7fffffff RBX: ffff810107c5a0c0 RCX: 0000000000000018
RDX: ffff810107c5a000 RSI: ffff810107c5a0c0 RDI: ffff8101fffd4cc0
RBP: ffff8101fffd4cc0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff810107c5a000
R13: 00000000000000c0 R14: ffff8101fffd4d38 R15: 0000000000000003
FS:  00002aaaab01c4a0(0000) GS:ffffffff8053a340(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001cb0 CR3: 00000001f1728000 CR4: 00000000000006e0
Process tar (pid: 6620, threadinfo ffff8101fda5e000, task ffff8101fedd31d0)
Stack: ffffffff8015a880 0000002000000000 000000000000001b ffff8101fffcc800
       ffff8101fffd4cc0 ffff8101fffd4cd8 ffff8101fffd4d38 0000000000000020
       ffffffff8015aa95 ffff8100049b6718
Call Trace:<ffffffff8015a880>{cache_grow+240} <ffffffff8015aa95>{cache_alloc_refill+421}
       <ffffffff8015ad76>{kmem_cache_alloc+54} <ffffffff80241193>{radix_tree_node_alloc+19}
       <ffffffff802413c2>{radix_tree_insert+114} <ffffffff80151f52>{add_to_page_cache+82}
       <ffffffff801996be>{mpage_readpages+142} <ffffffff801b34c0>{ext3_get_block+0}
       <ffffffff801561ec>{__rmqueue+188} <ffffffff80158e9e>{read_pages+62}
       <ffffffff801565c3>{buffered_rmqueue+323} <ffffffff80156ac3>{__alloc_pages+947}
       <ffffffff801590ba>{__do_page_cache_readahead+266} <ffffffff8015927e>{blockable_page_cache_readahead+30}
       <ffffffff80159381>{page_cache_readahead+193} <ffffffff8015281a>{do_generic_mapping_read+346}
       <ffffffff80152c20>{file_read_actor+0} <ffffffff80152ee7>{__generic_file_aio_read+407}
       <ffffffff80152f41>{generic_file_aio_read+49} <ffffffff80174f4d>{do_sync_read+173}
       <ffffffff8018fd1e>{inode_update_time+62} <ffffffff80181b5f>{pipe_writev+1263}
       <ffffffff801486f0>{autoremove_wake_function+0} <ffffffff801a4aae>{dnotify_parent+46}
       <ffffffff8017503f>{vfs_read+191} <ffffffff80175313>{sys_read+83}
       <ffffffff8010d3ba>{system_call+126}

Code: 49 8b 89 b0 1c 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
RIP <ffffffff8015a72c>{set_slab_attr+92} RSP <ffff8101fda5f8f0>
CR2: 0000000000001cb0
 <1>Unable to handle kernel paging request at 0000000000001cb0 RIP:
<ffffffff8016023a>{pte_alloc_map+170}
PGD 1fe534067 PUD 1ff6a7067 PMD 0
Oops: 0000 [2] SMP
CPU 0
Modules linked in: 8139too mii crc32
Pid: 3014, comm: syslogd Not tainted 2.6.11.6
RIP: 0010:[<ffffffff8016023a>] <ffffffff8016023a>{pte_alloc_map+170}
RSP: 0018:ffff8101fef73c68  EFLAGS: 00010293
RAX: ffffffff7fffffff RBX: 0000000000400000 RCX: 0000000000000018
RDX: ffff810107c5b000 RSI: 0000000000000000 RDI: ffff810000011a80
RBP: ffff810107c7a010 R08: ffff810000011000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8101ff4c0940
R13: 0000000000000000 R14: ffff8101ff4c09a8 R15: ffff8101ff4c0940
FS:  00002aaaaae00620(0000) GS:ffffffff8053a2c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000001cb0 CR3: 00000001ff3fe000 CR4: 00000000000006e0
Process syslogd (pid: 3014, threadinfo ffff8101fef72000, task ffff8101fe604820)
Stack: ffff8101ff6a7010 0000000000400000 0000000000400000 ffff810107c7a010
       0000000000407000 ffffffff80160480 0000000000400000 0000000000407000
       0000000000000000 0000000000001875
Call Trace:<ffffffff80160480>{copy_pte_range+48} <ffffffff801607a5>{copy_pmd_range+277}
       <ffffffff801608fc>{copy_pud_range+284} <ffffffff80160a24>{copy_page_range+244}
       <ffffffff8015aa7e>{cache_alloc_refill+398} <ffffffff80130aca>{copy_mm+794}
       <ffffffff80131922>{copy_process+2082} <ffffffff80131f77>{do_fork+215}
       <ffffffff80186e79>{set_close_on_exec+57} <ffffffff8010d3ba>{system_call+126}
       <ffffffff8010d72f>{ptregscall_common+103}

Code: 48 8b 8e b0 1c 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
RIP <ffffffff8016023a>{pte_alloc_map+170} RSP <ffff8101fef73c68>
CR2: 0000000000001cb0
 <1>Unable to handle kernel paging request at 0000000000001cb0 RIP:
<ffffffff8015a72c>{set_slab_attr+92}
PGD 1f8952067 PUD 1f6026067 PMD 0
Oops: 0000 [3] SMP
CPU 1
Modules linked in: 8139too mii crc32
Pid: 0, comm: swapper Not tainted 2.6.11.6
RIP: 0010:[<ffffffff8015a72c>] <ffffffff8015a72c>{set_slab_attr+92}
RSP: 0018:ffff8101fffafa80  EFLAGS: 00010093
RAX: ffffffff7fffffff RBX: ffff810107c63000 RCX: 0000000000000018
RDX: ffff810107c63000 RSI: ffff810107c63000 RDI: ffff8100dfe932c0
RBP: ffff8100dfe932c0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff810107c63000
R13: 0000000000000000 R14: ffff8100dfe93338 R15: 0000000000000003
FS:  00002aaaab41a4a0(0000) GS:ffffffff8053a340(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000001cb0 CR3: 00000001e3fcd000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff8101fffa6000, task ffff8101fffa0e10)
Stack: ffffffff8015a880 0000002000000000 0000000000000010 ffff8101ffc2dc00
       ffff8100dfe932c0 ffff8100dfe932d8 ffff8100dfe93338 0000000000000020
       ffffffff8015aa95 ffff8101ff0ca378
Call Trace:<IRQ> <ffffffff8015a880>{cache_grow+240} <ffffffff8015aa95>{cache_alloc_refill+421}
       <ffffffff8015ad76>{kmem_cache_alloc+54} <ffffffff8032c193>{tcp_time_wait+99}
       <ffffffff8031edda>{tcp_fin+234} <ffffffff8031f7cf>{tcp_data_queue+687}
       <ffffffff8032234a>{tcp_rcv_state_process+2266} <ffffffff80329afb>{tcp_v4_do_rcv+187}
       <ffffffff8032a07d>{tcp_v4_rcv+1309} <ffffffff80346f93>{ip_nat_fn+403}
       <ffffffff8030f437>{ip_local_deliver_finish+199} <ffffffff8030f370>{ip_local_deliver_finish+0}
       <ffffffff803056d1>{nf_hook_slow+193} <ffffffff8030f370>{ip_local_deliver_finish+0}
       <ffffffff8030ee89>{ip_local_deliver+473} <ffffffff8030f6ff>{ip_rcv_finish+527}
       <ffffffff8030f4f0>{ip_rcv_finish+0} <ffffffff8030f4f0>{ip_rcv_finish+0}
       <ffffffff803056d1>{nf_hook_slow+193} <ffffffff8030f4f0>{ip_rcv_finish+0}
       <ffffffff80331f30>{arp_process+0} <ffffffff8030f30f>{ip_rcv+1135}
       <ffffffff8035a820>{packet_rcv_spkt+576} <ffffffff802fb33b>{netif_receive_skb+363}
       <ffffffff880078b6>{:8139too:rtl8139_rx+518} <ffffffff88007b2c>{:8139too:rtl8139_poll+92}
       <ffffffff802fb536>{net_rx_action+134} <ffffffff80137d31>{__do_softirq+113}
       <ffffffff80137de5>{do_softirq+53} <ffffffff80110347>{do_IRQ+71}
       <ffffffff8010d961>{ret_from_intr+0}  <EOI> <ffffffff8037270a>{thread_return+42}
       <ffffffff8010b420>{default_idle+0} <ffffffff8010b444>{default_idle+36}
       <ffffffff8010b58a>{cpu_idle+58}

Code: 49 8b 89 b0 1c 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
RIP <ffffffff8015a72c>{set_slab_attr+92} RSP <ffff8101fffafa80>
CR2: 0000000000001cb0
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (primary)
Intl. Arctic Research Center            cswingle@gmail.com  (secondary)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

