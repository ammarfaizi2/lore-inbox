Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVBNA3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVBNA3j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 19:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBNA3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 19:29:38 -0500
Received: from arhont4.eclipse.co.uk ([81.168.98.124]:28622 "EHLO
	heart-a.dmz.arhont.com") by vger.kernel.org with ESMTP
	id S261325AbVBNA3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 19:29:18 -0500
Message-ID: <420FF0DC.4060804@arhont.com>
Date: Mon, 14 Feb 2005 00:29:16 +0000
From: "Konstantin V. Gavrilenko" <mlists@arhont.com>
Reply-To: kos@arhont.com
Organization: Arhont Ltd. - Information Security
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: whoops in kernel 2.6.9
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoops happened when tried to do
#ip route del blackhole to xxx.xxx.xxx.xxx


output of dmesg, and lsmod

Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c031ce3b
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: sch_sfq sch_htb cls_u32 sch_ingress ipt_mark ipt_MARK 
ipt_limit ipt_state ipt_MASQUERADE ipt_REJECT ipt_mac ipt_LOG ip_nat_irc 
ip_nat_ftp ip_conntrack_irc ip_conntrack_ftp iptable_mangle ipt_conntrack 
iptable_nat ip_conntrack iptable_filter ip_tables esp4 nfs lockd sunrpc twofish 
serpent aes_i586 blowfish sha256 crypto_null eeprom w83781d i2c_sensor i2c_piix4 
i2c_core tulip 8139too mii 3c59x
CPU:    0
EIP:    0060:[<c031ce3b>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-gentoo-r1)
EIP is at fib_release_info+0x8b/0xf0
eax: 00000000   ebx: ddb64a80   ecx: 00000000   edx: ddb64ae4
esi: ddb64ae8   edi: 00000000   ebp: dfc57bd0   esp: d6c5fc24
ds: 007b   es: 007b   ss: 0068
Process ip (pid: 7663, threadinfo=d6c5e000 task=c1543aa0)
Stack: 824b088e 00000001 defd1768 df7a7500 c031fc35 ddb64a80 defd1760 df7a7500
        00000020 000000fe dfc57bc0 df5cf2b8 0058489c c17a8fc0 00000020 defd1760
        746747ca dfc57bd0 dfc57bc0 dffe6a20 dfc57bc0 c031c58a dfc10c60 dfc57bd0
Call Trace:
  [<c031fc35>] fn_hash_delete+0x1e5/0x2a0
  [<c031c58a>] inet_rtm_delroute+0x6a/0x80
  [<c02da291>] rtnetlink_rcv+0x2e1/0x3a0
  [<c02e5f4f>] netlink_data_ready+0x5f/0x70
  [<c02e54b2>] netlink_sendskb+0x32/0x60
  [<c02e5bc6>] netlink_sendmsg+0x216/0x310
  [<c01cc8a4>] ext3_mark_inode_dirty+0x64/0x70
  [<c01cc91b>] ext3_dirty_inode+0x6b/0xd0
  [<c02c70ca>] sock_sendmsg+0xda/0x100
  [<c0141f4b>] do_page_cache_readahead+0x9b/0x1a0
  [<c013a5c9>] find_get_page+0x29/0x70
  [<c013ebaa>] buffered_rmqueue+0xfa/0x1f0
  [<c0211318>] copy_from_user+0x68/0xa0
  [<c011bce0>] autoremove_wake_function+0x0/0x60
  [<c02c8d4f>] sys_sendmsg+0x18f/0x1f0
  [<c014ab2e>] handle_mm_fault+0xde/0x1a0
  [<c011878c>] do_page_fault+0x3ac/0x5ae
  [<c02c6e1c>] sockfd_lookup+0x1c/0x80
  [<c02c8a76>] sys_setsockopt+0x76/0xc0
  [<c0211318>] copy_from_user+0x68/0xa0
  [<c02c91f2>] sys_socketcall+0x242/0x260
  [<c010b7aa>] do_gettimeofday+0x1a/0xd0
  [<c01183e0>] do_page_fault+0x0/0x5ae
  [<c0105cf5>] error_code+0x2d/0x38
  [<c01052eb>] syscall_call+0x7/0xb
Code: 43 08 00 01 10 00 c7 41 04 00 02 20 00 31 ff 8d 53 64 3b 7b 5c 7d 32 89 f6 
8d bc 27 00 00 00 00 8b 42 04 8d 72 04 8b 4e 04 85 c0 <89> 01 74 03 89 48 04 c7 
42 04 00 01 10 00 47 83 c2 2c c7 46 04
  <6>note: ip[7663] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
  [<c011b8a7>] __might_sleep+0xb7/0xe0
  [<c011e457>] printk+0x17/0x20
  [<c01204d0>] do_exit+0xb0/0x450
  [<c010655d>] die+0x18d/0x190
  [<c011e457>] printk+0x17/0x20
  [<c011861f>] do_page_fault+0x23f/0x5ae
  [<c033b03e>] schedule+0x2be/0x500
  [<c02cb2d4>] kfree_skbmem+0x24/0x30
  [<c02cb3a3>] __kfree_skb+0xc3/0x160
  [<c02e5807>] netlink_broadcast+0x197/0x2a0
  [<c01183e0>] do_page_fault+0x0/0x5ae
  [<c0105cf5>] error_code+0x2d/0x38
  [<c031ce3b>] fib_release_info+0x8b/0xf0
  [<c031fc35>] fn_hash_delete+0x1e5/0x2a0
  [<c031c58a>] inet_rtm_delroute+0x6a/0x80
  [<c02da291>] rtnetlink_rcv+0x2e1/0x3a0
  [<c02e5f4f>] netlink_data_ready+0x5f/0x70
  [<c02e54b2>] netlink_sendskb+0x32/0x60
  [<c02e5bc6>] netlink_sendmsg+0x216/0x310
  [<c01cc8a4>] ext3_mark_inode_dirty+0x64/0x70
  [<c01cc91b>] ext3_dirty_inode+0x6b/0xd0
  [<c02c70ca>] sock_sendmsg+0xda/0x100
  [<c0141f4b>] do_page_cache_readahead+0x9b/0x1a0
  [<c013a5c9>] find_get_page+0x29/0x70
  [<c013ebaa>] buffered_rmqueue+0xfa/0x1f0
  [<c0211318>] copy_from_user+0x68/0xa0
  [<c011bce0>] autoremove_wake_function+0x0/0x60
  [<c02c8d4f>] sys_sendmsg+0x18f/0x1f0
  [<c014ab2e>] handle_mm_fault+0xde/0x1a0
  [<c011878c>] do_page_fault+0x3ac/0x5ae
  [<c02c6e1c>] sockfd_lookup+0x1c/0x80
  [<c02c8a76>] sys_setsockopt+0x76/0xc0
  [<c0211318>] copy_from_user+0x68/0xa0
  [<c02c91f2>] sys_socketcall+0x242/0x260
  [<c010b7aa>] do_gettimeofday+0x1a/0xd0
  [<c01183e0>] do_page_fault+0x0/0x5ae
  [<c0105cf5>] error_code+0x2d/0x38
  [<c01052eb>] syscall_call+0x7/0xb
bad: scheduling while atomic!
  [<c033b26c>] schedule+0x4ec/0x500
  [<c0148da3>] unmap_page_range+0x53/0x80
  [<c0148f96>] unmap_vmas+0x1c6/0x1f0
  [<c014d9ce>] exit_mmap+0x7e/0x160
  [<c011bff5>] mmput+0x65/0xb0
  [<c012052f>] do_exit+0x10f/0x450
  [<c010655d>] die+0x18d/0x190
  [<c011e457>] printk+0x17/0x20
  [<c011861f>] do_page_fault+0x23f/0x5ae
  [<c033b03e>] schedule+0x2be/0x500
  [<c02cb2d4>] kfree_skbmem+0x24/0x30
  [<c02cb3a3>] __kfree_skb+0xc3/0x160
  [<c02e5807>] netlink_broadcast+0x197/0x2a0
  [<c01183e0>] do_page_fault+0x0/0x5ae
  [<c0105cf5>] error_code+0x2d/0x38
  [<c031ce3b>] fib_release_info+0x8b/0xf0
  [<c031fc35>] fn_hash_delete+0x1e5/0x2a0
  [<c031c58a>] inet_rtm_delroute+0x6a/0x80
  [<c02da291>] rtnetlink_rcv+0x2e1/0x3a0
  [<c02e5f4f>] netlink_data_ready+0x5f/0x70
  [<c02e54b2>] netlink_sendskb+0x32/0x60
  [<c02e5bc6>] netlink_sendmsg+0x216/0x310
  [<c01cc8a4>] ext3_mark_inode_dirty+0x64/0x70
  [<c01cc91b>] ext3_dirty_inode+0x6b/0xd0
  [<c02c70ca>] sock_sendmsg+0xda/0x100
  [<c0141f4b>] do_page_cache_readahead+0x9b/0x1a0
  [<c013a5c9>] find_get_page+0x29/0x70
  [<c013ebaa>] buffered_rmqueue+0xfa/0x1f0
  [<c0211318>] copy_from_user+0x68/0xa0
  [<c011bce0>] autoremove_wake_function+0x0/0x60
  [<c02c8d4f>] sys_sendmsg+0x18f/0x1f0
  [<c014ab2e>] handle_mm_fault+0xde/0x1a0
  [<c011878c>] do_page_fault+0x3ac/0x5ae
  [<c02c6e1c>] sockfd_lookup+0x1c/0x80
  [<c02c8a76>] sys_setsockopt+0x76/0xc0
  [<c0211318>] copy_from_user+0x68/0xa0
  [<c02c91f2>] sys_socketcall+0x242/0x260
  [<c010b7aa>] do_gettimeofday+0x1a/0xd0
  [<c01183e0>] do_page_fault+0x0/0x5ae
  [<c0105cf5>] error_code+0x2d/0x38
  [<c01052eb>] syscall_call+0x7/0xb





gate / # lsmod
Module                  Size  Used by
sch_sfq                 4640  7
sch_htb                22944  1
cls_u32                 7652  16
sch_ingress             2912  1
ipt_mark                1248  5
ipt_MARK                1536  1
ipt_limit               1824  8
ipt_state               1376  6
ipt_MASQUERADE          3528  0
ipt_REJECT              5600  2
ipt_mac                 1472  49
ipt_LOG                 6176  8
ip_nat_irc              3728  0
ip_nat_ftp              4368  0
ip_conntrack_irc       70640  1 ip_nat_irc
ip_conntrack_ftp       71600  1 ip_nat_ftp
iptable_mangle          2048  1
ipt_conntrack           1920  0
iptable_nat            28932  4 ipt_MASQUERADE,ip_nat_irc,ip_nat_ftp
ip_conntrack           51836  8 
ipt_state,ipt_MASQUERADE,ip_nat_irc,ip_nat_ftp,ip_conntrack_irc,ip_conntrack_ftp,ipt_conntrack,iptable_nat
iptable_filter          2112  1
ip_tables              19520  12 
ipt_mark,ipt_MARK,ipt_limit,ipt_state,ipt_MASQUERADE,ipt_REJECT,ipt_mac,ipt_LOG,iptable_mangle,ipt_conntrack,iptable_nat,iptable_filter
esp4                    6368  6
nfs                   216804  2
lockd                  63592  2 nfs
sunrpc                133764  6 nfs,lockd
twofish                38304  0
serpent                13248  0
aes_i586               38196  6
blowfish                9888  0
sha256                  9312  0
crypto_null             1920  0
eeprom                  6624  0
w83781d                34160  0
i2c_sensor              2944  2 eeprom,w83781d
i2c_piix4               6960  0
i2c_core               19440  4 eeprom,w83781d,i2c_sensor,i2c_piix4
tulip                  42272  0
8139too                20544  0
mii                     3872  1 8139too
3c59x                  35176  0

-- 
Respectfully,
Konstantin V. Gavrilenko

Arhont Ltd - Information Security

web:    http://www.arhont.com
	http://www.wi-foo.com
e-mail: k.gavrilenko@arhont.com

tel: +44 (0) 870 44 31337
fax: +44 (0) 117 969 0141

PGP: Key ID - 0x4F3608F7
PGP: Server - keyserver.pgp.com
