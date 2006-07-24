Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWGXIGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWGXIGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 04:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWGXIGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 04:06:40 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27823 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932088AbWGXIGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 04:06:39 -0400
Date: Mon, 24 Jul 2006 12:01:48 +0400
From: Jim Klimov <klimov@2ka.mipt.ru>
X-Mailer: The Bat! (v2.10.01)         CD5BF9353B3B7091
Reply-To: Jim Klimov <klimov@2ka.mipt.ru>
Organization: MIPT Campus-Net
X-Priority: 3 (Normal)
Message-ID: <254599816.20060724120148@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel paging request, another 2.6.16.25 server reboots
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Mon, 24 Jul 2006 12:06:47 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel,

  I recently wrote about problems with a fileserver rebooting
  frequently. Another similar server got under NFS load today
  and rebooted at least twice in the past few hours.

  This server has a similar motherboard (Supermicro X5DP8-G2),
  dual Xeons@533, two older 3Ware controllers (7506+8506) and
  a reiserfs v3 archive.

  The server reported last week has two 3Ware 9550 controllers,
  ext3 archives and primarily a Samba usage.

[32262.075038] Unable to handle kernel paging request at virtual address f9445d43
[32262.082673]  printing eip:
[32262.085515] c0392bba
[32262.087822] *pde = 32e59067
[32262.090729] Oops: 0000 [#1]
[32262.093636] SMP 
[32262.095649] Modules linked in: w83781d hwmon_vid hwmon i2c_isa i2c_core w83627hf_wdt
[32262.104138] CPU:    0
[32262.104139] EIP:    0060:[<c0392bba>]    Not tainted VLI
[32262.104140] EFLAGS: 00010282   (2.6.16.25 #3) 
[32262.116474] EIP is at ipt_do_table+0xae/0x385
[32262.121055] eax: 00000003   ebx: 00000000   ecx: cbf4b8d8   edx: f944a2c8
[32262.128063] esi: e2262940   edi: f9445cf0   ebp: 80000000   esp: f700fac8
[32262.135095] ds: 007b   es: 007b   ss: 0068
[32262.139328] Process nfsd (pid: 10685, threadinfo=f700e000 task=f36a7ab0)
[32262.146127] Stack: <0>f9446b10 00000282 c33e2180 f36cda80 00000000 c047deec f944a2c8 f9418000 
[32262.155812]        f7788800 c0530cd4 00000000 cbf4b8d8 00000000 00000003 f700fba0 00000000 
[32262.164948]        f700fba0 00000003 c052f0d8 80000000 c03947e7 f7788800 c047dec0 00000000 
[32262.174128] Call Trace:
[32262.176759]  [<c03947e7>] ipt_local_out_hook+0x72/0x77
[32262.182228]  [<c035dfd9>] nf_iterate+0x69/0x83
[32262.186964]  [<c036a1ca>] dst_output+0x0/0x7
[32262.191502]  [<c036a1ca>] dst_output+0x0/0x7
[32262.196055]  [<c035e050>] nf_hook_slow+0x5d/0xea
[32262.200995]  [<c036a1ca>] dst_output+0x0/0x7
[32262.205528]  [<c0368178>] ip_queue_xmit+0x3d4/0x4f5
[32262.210724]  [<c036a1ca>] dst_output+0x0/0x7
[32262.215276]  [<c012ce4a>] __rcu_process_callbacks+0x7d/0xc5
[32262.221217]  [<c0115d92>] activate_task+0x99/0xa5
[32262.226231]  [<c011659c>] try_to_wake_up+0x29c/0x33b
[32262.231540]  [<c037d0d1>] tcp_v4_send_check+0x4a/0xdc
[32262.236945]  [<c037868d>] tcp_transmit_skb+0x2e6/0x45a
[32262.242419]  [<c0379879>] tcp_push_one+0x97/0x104
[32262.247423]  [<c036ec4c>] tcp_sendmsg+0x36b/0xb4d
[32262.252436]  [<c035dfd9>] nf_iterate+0x69/0x83
[32262.257190]  [<c037e653>] tcp_v4_rcv+0x4e6/0x81f
[32262.262101]  [<c0389cbe>] inet_sendmsg+0x47/0x5f
[32262.267017]  [<c0344768>] sock_sendmsg+0xc9/0xe3
[32262.271942]  [<c03649ad>] ip_rcv+0x2bc/0x56f
[32262.276481]  [<c034e58a>] netif_receive_skb+0x227/0x2d7
[32262.282039]  [<c0348c4c>] __kfree_skb+0x3a/0xc3
[32262.286881]  [<c012f3e4>] autoremove_wake_function+0x0/0x43
[32262.292741]  [<c0125923>] update_wall_time_one_tick+0x6/0x7e
[32262.298772]  [<c01259ce>] update_wall_time+0x8/0x35
[32262.303957]  [<c01062ab>] timer_interrupt+0x5b/0x86
[32262.309124]  [<c0139975>] handle_IRQ_event+0x26/0x59
[32262.314444]  [<c03447b0>] kernel_sendmsg+0x2e/0x3c
[32262.319525]  [<c0347a3f>] sock_no_sendpage+0x80/0x9f
[32262.324772]  [<c036e8a5>] tcp_sendpage+0x49/0x85
[32262.329708]  [<c03a9573>] svc_sendto+0x134/0x250
[32262.334651]  [<c034e7ce>] net_rx_action+0x88/0x15f
[32262.339777]  [<c0104f82>] do_IRQ+0x1e/0x24
[32262.344129]  [<c01035e2>] common_interrupt+0x1a/0x20
[32262.349422]  [<c03aa597>] svc_tcp_sendto+0x4d/0x99
[32262.354495]  [<c0258eab>] _atomic_dec_and_lock+0x33/0x4c
[32262.360121]  [<c03aad1a>] svc_send+0xaa/0xed
[32262.364691]  [<c0210abc>] fh_put+0x133/0x17d
[32262.369239]  [<c03ac4da>] svcauth_unix_release+0x43/0x45
[32262.374885]  [<c021d1fd>] nfs3svc_release_fhandle+0x0/0xe
[32262.380606]  [<c03a8b14>] svc_process+0x1b1/0x619
[32262.386970]  [<c01183f8>] default_wake_function+0x0/0xc
[32262.392485]  [<c020e10d>] nfsd+0x178/0x301
[32262.396891]  [<c020df95>] nfsd+0x0/0x301
[32262.401132]  [<c01010a1>] kernel_thread_helper+0x5/0xb
[32262.406560] Code: ff 21 e0 0f b7 db 8b 40 10 8b 44 86 34 89 44 24 1c
89 c7 8b 44 24 34 8b 54 24 1c 03 7c 86 0c 03 54 86 20 89 5c 24 10 89 54
24 18 <0f> b6 5f 53 89 d8 24 08 84 c0 0f 84 b4 02 00 00 8b 47 08 8b 4c
[32262.429623]  <0>Kernel panic - not syncing: Fatal exception in interrupt
[32262.436516]  <0>Rebooting in 1 seconds..  

-- 
Best regards,
 Jim Klimov                          mailto:klimov@2ka.mipt.ru

