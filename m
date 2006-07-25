Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWGYJlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWGYJlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWGYJlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:41:04 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:65457 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932287AbWGYJlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:41:01 -0400
Date: Tue, 25 Jul 2006 05:36:56 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Unable to handle kernel paging request, another 2.6.16.25
  server reboots
To: Jim Klimov <klimov@2ka.mipt.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <netdev@vger.kernel.org>
Message-ID: <200607250538_MC3-1-C5FF-4726@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <254599816.20060724120148@2ka.mipt.ru>

On Mon, 24 Jul 2006 12:01:48 +0400, Jim Klimov wrote:

>  I recently wrote about problems with a fileserver rebooting
>  frequently. Another similar server got under NFS load today
>  and rebooted at least twice in the past few hours.
>
>  This server has a similar motherboard (Supermicro X5DP8-G2),
>  dual Xeons@533, two older 3Ware controllers (7506+8506) and
>  a reiserfs v3 archive.
>
>  The server reported last week has two 3Ware 9550 controllers,
>  ext3 archives and primarily a Samba usage.

I decoded your oops.  It's in netfilter:

Unable to handle kernel paging request at virtual address f9445d43
printing eip:
 c0392bba
*pde = 32e59067
Oops: 0000 [#1]
 SMP 
Modules linked in: w83781d hwmon_vid hwmon i2c_isa i2c_core w83627hf_wdt
CPU:    0
EIP:    0060:[<c0392bba>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16.25 #3) 
EIP is at ipt_do_table+0xae/0x385
eax: 00000003   ebx: 00000000   ecx: cbf4b8d8   edx: f944a2c8
esi: e2262940   edi: f9445cf0   ebp: 80000000   esp: f700fac8
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 10685, threadinfo=f700e000 task=f36a7ab0)
Stack: f9446b10 00000282 c33e2180 f36cda80 00000000 c047deec f944a2c8 f9418000 
       f7788800 c0530cd4 00000000 cbf4b8d8 00000000 00000003 f700fba0 00000000 
       f700fba0 00000003 c052f0d8 80000000 c03947e7 f7788800 c047dec0 00000000 
Call Trace:
 [<c03947e7>] ipt_local_out_hook+0x72/0x77
 [<c035dfd9>] nf_iterate+0x69/0x83
 [<c036a1ca>] dst_output+0x0/0x7
 [<c036a1ca>] dst_output+0x0/0x7
 [<c035e050>] nf_hook_slow+0x5d/0xea
 [<c036a1ca>] dst_output+0x0/0x7
 [<c0368178>] ip_queue_xmit+0x3d4/0x4f5
 [<c036a1ca>] dst_output+0x0/0x7
 [<c012ce4a>] __rcu_process_callbacks+0x7d/0xc5
 [<c0115d92>] activate_task+0x99/0xa5
 [<c011659c>] try_to_wake_up+0x29c/0x33b
 [<c037d0d1>] tcp_v4_send_check+0x4a/0xdc
 [<c037868d>] tcp_transmit_skb+0x2e6/0x45a
 [<c0379879>] tcp_push_one+0x97/0x104
 [<c036ec4c>] tcp_sendmsg+0x36b/0xb4d
 [<c035dfd9>] nf_iterate+0x69/0x83
 [<c037e653>] tcp_v4_rcv+0x4e6/0x81f
 [<c0389cbe>] inet_sendmsg+0x47/0x5f
 [<c0344768>] sock_sendmsg+0xc9/0xe3
 [<c03649ad>] ip_rcv+0x2bc/0x56f
 [<c034e58a>] netif_receive_skb+0x227/0x2d7
 [<c0348c4c>] __kfree_skb+0x3a/0xc3
 [<c012f3e4>] autoremove_wake_function+0x0/0x43
 [<c0125923>] update_wall_time_one_tick+0x6/0x7e
 [<c01259ce>] update_wall_time+0x8/0x35
 [<c01062ab>] timer_interrupt+0x5b/0x86
 [<c0139975>] handle_IRQ_event+0x26/0x59
 [<c03447b0>] kernel_sendmsg+0x2e/0x3c
 [<c0347a3f>] sock_no_sendpage+0x80/0x9f
 [<c036e8a5>] tcp_sendpage+0x49/0x85
 [<c03a9573>] svc_sendto+0x134/0x250
 [<c034e7ce>] net_rx_action+0x88/0x15f
 [<c0104f82>] do_IRQ+0x1e/0x24
 [<c01035e2>] common_interrupt+0x1a/0x20
 [<c03aa597>] svc_tcp_sendto+0x4d/0x99
 [<c0258eab>] _atomic_dec_and_lock+0x33/0x4c
 [<c03aad1a>] svc_send+0xaa/0xed
 [<c0210abc>] fh_put+0x133/0x17d
 [<c03ac4da>] svcauth_unix_release+0x43/0x45
 [<c021d1fd>] nfs3svc_release_fhandle+0x0/0xe
 [<c03a8b14>] svc_process+0x1b1/0x619
 [<c01183f8>] default_wake_function+0x0/0xc
 [<c020e10d>] nfsd+0x178/0x301
 [<c020df95>] nfsd+0x0/0x301
 [<c01010a1>] kernel_thread_helper+0x5/0xb

   6:   8b 40 10                  mov    0x10(%eax),%eax
   9:   8b 44 86 34               mov    0x34(%esi,%eax,4),%eax
   d:   89 44 24 1c               mov    %eax,0x1c(%esp)
  11:   89 c7                     mov    %eax,%edi
  13:   8b 44 24 34               mov    0x34(%esp),%eax
  17:   8b 54 24 1c               mov    0x1c(%esp),%edx
  1b:   03 7c 86 0c               add    0xc(%esi,%eax,4),%edi
  1f:   03 54 86 20               add    0x20(%esi,%eax,4),%edx
  23:   89 5c 24 10               mov    %ebx,0x10(%esp)
  27:   89 54 24 18               mov    %edx,0x18(%esp)
   0:   0f b6 5f 53               movzbl 0x53(%edi),%ebx   <=====
   4:   89 d8                     mov    %ebx,%eax
   6:   24 08                     and    $0x8,%al
   8:   84 c0                     test   %al,%al
   a:   0f 84 b4 02 00 00         je     2c4 <_EIP+0x2c4>
  10:   8b 47 08                  mov    0x8(%edi),%eax

This is in net/ipv4/netfiler/ip_tables.c::ipt_do_table():

        table_base = (void *)private->entries[smp_processor_id()];
        e = get_entry(table_base, private->hook_entry[hook]);

        /* For return from builtin chain */
        back = get_entry(table_base, private->underflow[hook]);

        do {
                IP_NF_ASSERT(e);
                IP_NF_ASSERT(back);
===>            if (ip_packet_match(ip, indev, outdev, &e->ip, offset)) {

'e' is an invalid pointer. (ip_packet_match() was inlined.)
hook == 3


The call trace seems to show that svc_tcp_sendto() was interrupted by an
IRQ for an incoming packet, or maybe the timer interrupt?

Can you build with CONFIG_FRAME_POINTERS and see if you can get a cleaner
trace?

-- 
Chuck
