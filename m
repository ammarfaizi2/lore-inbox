Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVIVWFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVIVWFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 18:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVIVWFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 18:05:45 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:34300 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751319AbVIVWFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 18:05:44 -0400
Message-ID: <43332AA3.6000804@nortel.com>
Date: Thu, 22 Sep 2005 16:05:23 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20050922182719.GA4729@in.ibm.com> <4332FFF5.5060207@nortel.com> <20050922191805.GB4729@in.ibm.com>
In-Reply-To: <20050922191805.GB4729@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020105020501080102060203"
X-OriginalArrivalTime: 22 Sep 2005 22:05:35.0251 (UTC) FILETIME=[C1E4AE30:01C5BFC1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020105020501080102060203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dipankar Sarma wrote:

> Can you look at that each cpu is running (backtrace) using
> sysrq ? That may tell us what is holding up RCU. I will look
> at it myself later.

Okay, I'm not sure what you're looking for exactly, so I've included 
inline a number of sysrq-p dumps from different iterations right before 
the oom killer kicks in.  I've also attached a sysrq-t dump.

This is on a UP system running 2.6.14-rc2.

Pid: 913, comm:             rename14
EIP: 0060:[<c015b6ec>] CPU: 0
EIP is at link_path_walk+0x2c/0xe0
  EFLAGS: 00000202    Not tainted  (2.6.14-rc2-gc90eef84)
EAX: 00000007 EBX: dc35df28 ECX: 00000000 EDX: f7e7dbb8
ESI: dc35df68 EDI: dc35ded4 EBP: dc35dee0 DS: 007b ES: 007b
CR0: 8005003b CR2: b7db1000 CR3: 3470c000 CR4: 000006d0
  [<c0100f9d>] show_regs+0x14d/0x174
  [<c01f41b5>] sysrq_handle_showregs+0x15/0x20
  [<c01f43cf>] __handle_sysrq+0x7f/0x110
  [<c01f4493>] handle_sysrq+0x33/0x40
  [<c01f9dce>] receive_chars+0x22e/0x290
  [<c01fa141>] serial8250_interrupt+0xe1/0xf0
  [<c0130cfe>] handle_IRQ_event+0x3e/0x90
  [<c0130dab>] __do_IRQ+0x5b/0xc0
  [<c0104d4c>] do_IRQ+0x1c/0x30
  [<c0103586>] common_interrupt+0x1a/0x20
  [<c015b9f8>] path_lookup+0x78/0x120
  [<c015dd19>] sys_rename+0x99/0x240
  [<c0102b5f>] sysenter_past_esp+0x54/0x75

Pid: 919, comm:             rename14
EIP: 0060:[<c01c9e53>] CPU: 0
EIP is at _atomic_dec_and_lock+0x23/0x40
  EFLAGS: 00000246    Not tainted  (2.6.14-rc2-gc90eef84)
EAX: 00000000 EBX: f7fd66f0 ECX: f7fd66f0 EDX: 00000006
ESI: f7fd66f0 EDI: ce84ab2c EBP: f7fbff2c DS: 007b ES: 007b
CR0: 8005003b CR2: b7db1000 CR3: 06289000 CR4: 000006d0
  [<c0100f9d>] show_regs+0x14d/0x174
  [<c01f41b5>] sysrq_handle_showregs+0x15/0x20
  [<c01f43cf>] __handle_sysrq+0x7f/0x110
  [<c01f4493>] handle_sysrq+0x33/0x40
  [<c01f9dce>] receive_chars+0x22e/0x290
  [<c01fa141>] serial8250_interrupt+0xe1/0xf0
  [<c0130cfe>] handle_IRQ_event+0x3e/0x90
  [<c0130dab>] __do_IRQ+0x5b/0xc0
  [<c0104d4c>] do_IRQ+0x1c/0x30
  [<c0103586>] common_interrupt+0x1a/0x20
  [<c01641a6>] dput+0x56/0x1d0
  [<c014e098>] __fput+0x108/0x180
  [<c014df88>] fput+0x18/0x20
  [<c014c704>] filp_close+0x44/0x80
  [<c014c795>] sys_close+0x55/0x80
  [<c0102b5f>] sysenter_past_esp+0x54/0x75

Pid: 931, comm:             rename14
EIP: 0060:[<c01cebaf>] CPU: 0
EIP is at strncpy_from_user+0x3f/0x60
  EFLAGS: 00000216    Not tainted  (2.6.14-rc2-gc90eef84)
EAX: cd0d202f EBX: 0804aac9 ECX: 00000fff EDX: 00001000
ESI: 0804aaca EDI: dd477002 EBP: cd0d3edc DS: 007b ES: 007b
CR0: 8005003b CR2: b7e37000 CR3: 37eb7000 CR4: 000006d0
  [<c0100f9d>] show_regs+0x14d/0x174
  [<c01f41b5>] sysrq_handle_showregs+0x15/0x20
  [<c01f43cf>] __handle_sysrq+0x7f/0x110
  [<c01f4493>] handle_sysrq+0x33/0x40
  [<c01f9dce>] receive_chars+0x22e/0x290
  [<c01fa141>] serial8250_interrupt+0xe1/0xf0
  [<c0130cfe>] handle_IRQ_event+0x3e/0x90
  [<c0130dab>] __do_IRQ+0x5b/0xc0
  [<c0104d4c>] do_IRQ+0x1c/0x30
  [<c0103586>] common_interrupt+0x1a/0x20
  [<c015a235>] getname+0x75/0xc0
  [<c015dc9d>] sys_rename+0x1d/0x240
  [<c0102b5f>] sysenter_past_esp+0x54/0x75

Pid: 937, comm:             rename14
EIP: 0060:[<c015a386>] CPU: 0
EIP is at generic_permission+0x106/0x140
  EFLAGS: 00000246    Not tainted  (2.6.14-rc2-gc90eef84)
EAX: 00000000 EBX: 000041ff ECX: 00000000 EDX: f7fc10b0
ESI: ce84a994 EDI: 00000003 EBP: ca037e70 DS: 007b ES: 007b
CR0: 8005003b CR2: b7e37000 CR3: 0b40a000 CR4: 000006d0
  [<c0100f9d>] show_regs+0x14d/0x174
  [<c01f41b5>] sysrq_handle_showregs+0x15/0x20
  [<c01f43cf>] __handle_sysrq+0x7f/0x110
  [<c01f4493>] handle_sysrq+0x33/0x40
  [<c01f9dce>] receive_chars+0x22e/0x290
  [<c01fa141>] serial8250_interrupt+0xe1/0xf0
  [<c0130cfe>] handle_IRQ_event+0x3e/0x90
  [<c0130dab>] __do_IRQ+0x5b/0xc0
  [<c0104d4c>] do_IRQ+0x1c/0x30
  [<c0103586>] common_interrupt+0x1a/0x20
  [<c015a444>] permission+0x84/0xb0
  [<c015bdd0>] vfs_create+0x70/0xf0
  [<c015c140>] open_namei+0xe0/0x5f0
  [<c014c3a4>] filp_open+0x54/0xa0
  [<c014c5b9>] do_sys_open+0x59/0x100
  [<c014c67f>] sys_open+0x1f/0x30
  [<c014c6b1>] sys_creat+0x21/0x30
  [<c0102b5f>] sysenter_past_esp+0x54/0x75


Chris


--------------020105020501080102060203
Content-Type: text/plain;
 name="runningprocesses"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="runningprocesses"

SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000000     0     1      0     2               (NOTLB)
c353fea0 c34f4a10 c03b7b80 00000000 00000000 00000000 00000001 00000000 
       c34f4a10 f7ef5560 00002bfa a0dbb75a 00000187 c34f4a10 c34f4b38 0014c7ea 
       c353feb4 0000000b c353fedc c02fb023 c353feb4 0014c7ea f7f4caec c03bd9a0 
Call Trace:
 [<c02fb023>] schedule_timeout+0x53/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
ksoftirqd/0   R running     0     2      1             3       (L-TLB)
watchdog/0    S 0000014E     0     3      1             4     2 (L-TLB)
c3543f44 c34f4030 c03b7b80 0000014e 00000000 7c56f42d 0000014e 00000417 
       00000000 f7ef5560 000002de 8bcab025 00000187 c34f4030 c34f4158 0014b6ea 
       c3543f58 00000000 c3543f80 c02fb023 c3543f58 0014b6ea c34f4030 c03bdb18 
Call Trace:
 [<c02fb023>] schedule_timeout+0x53/0xb0
 [<c02fb09a>] schedule_timeout_interruptible+0x1a/0x20
 [<c011e794>] msleep_interruptible+0x34/0x40
 [<c0130b81>] watchdog+0x61/0x90
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
events/0      S 00000246     0     4      1             5     3 (L-TLB)
c3549f38 c34fba50 c03b7b80 00000246 f7d5800c 00000286 00000000 00000092 
       f7d580d8 f7ef5560 000004f8 995007cf 00000187 c34fba50 c34fbb78 00000286 
       f7d58000 c34f2848 c3549fb4 c012486c 00000000 c3549f68 00000000 c34f2858 
Call Trace:
 [<c012486c>] worker_thread+0x1ec/0x220
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
khelper       S F74F9D38     0     5      1             6     4 (L-TLB)
c354bf38 c34fb560 c03b7b80 f74f9d38 c354bf20 00000282 00000000 00000092 
       f74f9d38 f751da90 000000e9 5a1a74e3 00000008 c34fb560 c34fb688 00000292 
       f74f9d74 c34f27c8 c354bfb4 c012486c 00000000 c354bf68 00000000 c34f27d8 
Call Trace:
 [<c012486c>] worker_thread+0x1ec/0x220
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
kthread       S C3573F1C     0     6      1     8      91     5 (L-TLB)
c3573f38 c34fb070 c03b7b80 c3573f1c 00000282 c353fdd4 00000000 00000092 
       c353fd7c c34f4a10 0000004f d0f13e25 00000007 c34fb070 c34fb198 00000286 
       c353fdb8 c3505bc8 c3573fb4 c012486c 00000000 c3573f68 00000000 c3505bd8 
Call Trace:
 [<c012486c>] worker_thread+0x1ec/0x220
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
kblockd/0     S 2E8A98C2     0     8      6            89       (L-TLB)
c3575f38 c3509a90 c03b7b80 2e8a98c2 c3575f1c c0111c5c 00010000 c3574000 
       c3509a90 c34f4a10 000002fe 8ecc70a0 00000006 c3509a90 c3509bb8 c3574000 
       00000000 fffffffb c3575fb4 c012486c 00000011 c3575f68 00000000 c35058d8 
Call Trace:
 [<c012486c>] worker_thread+0x1ec/0x220
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
pdflush       S C373DF50     0    89      6            90     8 (L-TLB)
c373df70 c35095a0 c03b7b80 c373df50 00000001 c373df5c 00000086 c34fb070 
       b3494352 c35090b0 00000082 a7acf1c2 00000006 c35095a0 c35096c8 c373dfa0 
       c373df94 00000000 c373df84 c0138a60 c373c000 c373c000 c353ff58 c373dfb4 
Call Trace:
 [<c0138a60>] __pdflush+0x80/0x170
 [<c0138b78>] pdflush+0x28/0x30
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
pdflush       S 00000000     0    90      6            92    89 (L-TLB)
c375df70 c35090b0 c03b7b80 00000000 00000000 00000000 00000000 00000000 
       00000005 f7fc1a90 000008b9 90cbc789 00000187 c35090b0 c35091d8 c375dfa0 
       c375df94 00000000 c375df84 c0138a60 00000000 c375c000 c353ff58 c375dfb4 
Call Trace:
 [<c0138a60>] __pdflush+0x80/0x170
 [<c0138b78>] pdflush+0x28/0x30
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
aio/0         S 00000006     0    92      6           208    90 (L-TLB)
c379ff38 c34fb560 c03b7bb0 00000006 c379ff1c a948ef6f 00000006 00000195 
       00000000 c34fb560 00000072 a948f32f 00000006 c359b5e0 c359b708 c379e000 
       00000000 fffffffb c379ffb4 c012486c 00000011 c379ff68 00000000 c35979d8 
Call Trace:
 [<c012486c>] worker_thread+0x1ec/0x220
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
kswapd0       S 00000020     0    91      1           427     6 (L-TLB)
c375ff80 c359bad0 c03b7b80 00000020 00000000 00000000 0000052c 00000020 
       0000000c f7f10ad0 00000065 dde71359 00000133 c359bad0 c359bbf8 00000000 
       c033c014 00000000 c375ffe4 c013dffa c033bc40 00000000 00000000 00000000 
Call Trace:
 [<c013dffa>] kswapd+0xda/0xf0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
rpciod/0      S C02E41C5     0   208      6                  92 (L-TLB)
f7f71f38 c359b0f0 c03b7b80 c02e41c5 f7dd8ac4 f7dd8b80 00000000 00000092 
       f7dd8b44 f7f71f38 00000105 ea3d42af 00000182 c359b0f0 c359b218 00000292 
       f7dd8ac4 f7f1c748 f7f71fb4 c012486c 00000000 f7f71f68 00000000 f7f1c758 
Call Trace:
 [<c012486c>] worker_thread+0x1ec/0x220
 [<c012867a>] kthread+0x9a/0xe0
 [<c0100fc9>] kernel_thread_helper+0x5/0xc
syslogd       S 00000000     0   427      1           431    91 (NOTLB)
f7f09ea0 f7f5a520 c03b7b80 00000000 f7f5a520 00000010 c033bfc4 00000000 
       f7f09e90 00000000 00000489 194edd72 00000181 f7f5a520 f7f5a648 00000000 
       7fffffff 00000001 f7f09edc c02fb06f f7f09ec4 c0243292 f7fd7840 c37979d8 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
klogd         R running     0   431      1           502   427 (NOTLB)
sshd          S F7412030     0   502      1   823     518   431 (NOTLB)
f7f53ea0 f7412030 c03b7b80 f7412030 00000010 c033bfc4 00000000 00000202 
       00000000 f7fae5c0 000003d5 3a05cff4 00000136 f7412030 f7412158 00000000 
       7fffffff 00000004 f7f53edc c02fb06f c0263850 f7fae5c0 c37970d8 f7f53f38 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
xinetd        S 00000000     0   518      1           527   502 (NOTLB)
f7e2bea0 f7f105e0 c03b7b80 00000000 00000000 00000000 00000001 00000000 
       f7f105e0 00000010 00001511 38ccc693 00000008 f7f105e0 f7f10708 00000000 
       7fffffff 00000007 f7e2bedc c02fb06f c0263850 f7e55a40 f7e58c98 f7e2bf38 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
bash          S F7E57E54     0   527      1           528   518 (NOTLB)
f7e57e74 f7412a10 c03b7b80 f7e57e54 c01f9ab0 c03c91e0 00000001 00000007 
       c03c91e0 f74cd803 000003ad 79dbde27 00000181 f7412a10 f7412b38 f7d58000 
       7fffffff 00000000 f7e57eb0 c02fb06f f7d58000 00000003 c03c91e0 f74cd803 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
mingetty      S C341B000     0   528      1           529   527 (NOTLB)
f7f67e74 f7412520 c03b7b80 c341b000 c341b220 0000000b 00000001 00000000 
       00000000 c341b000 00000ac1 41ee1e5e 00000008 f7412520 f7412648 c37d1000 
       7fffffff f7f67f00 f7f67eb0 c02fb06f f7f67e98 c01f2b3f c37d1000 c379200b 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0   529      1           530   528 (NOTLB)
f7f4be74 c34f4a10 c03b8028 00000008 00000020 44d95ace 00000008 000c1ebb 
       00000000 c34f4a10 00000cee 44f60f61 00000008 f7feaa50 f7feab78 f7ef4000 
       7fffffff f7f4bf00 f7f4beb0 c02fb06f f7f4be98 c01f2b3f f7ef4000 f7ef8c0b 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0   530      1           531   529 (NOTLB)
f7e69e74 f7f5a030 c03b8028 00000008 00000020 4cc7c3e5 00000008 0014f81b 
       00000000 f7f5a030 00002aca 4cf96dd7 00000008 f7fea560 f7fea688 f7dc9000 
       7fffffff f7e69f00 f7e69eb0 c02fb06f f7e69e98 c01f2b3f f7dc9000 f7eeb80b 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
mingetty      S F7FD9000     0   531      1           532   530 (NOTLB)
f7f15e74 f7fea070 c03b7b80 f7fd9000 00000020 f7f15f28 f7f15f28 fffffffe 
       00000000 f7f5a030 00001c1a 51f4ffc2 00000008 f7fea070 f7fea198 f7ec6000 
       7fffffff f7f15f00 f7f15eb0 c02fb06f f7f15e98 c01f2b3f f7ec6000 f747f40b 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
mingetty      S F7418800     0   532      1           548   531 (NOTLB)
f7e8be74 f7f5a030 c03b7b80 f7418800 00000020 f7e8bf28 f7e8bf28 fffffffe 
       00000000 c015b71a 0000318d 567baabc 00000008 f7f5a030 f7f5a158 f7581000 
       7fffffff f7e8bf00 f7e8beb0 c02fb06f f7e8be98 c01f2b3f f7581000 f754f00b 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
udevd         S 00000000     0   548      1           573   532 (NOTLB)
f7467ea0 f7ef5070 c03b7b80 00000000 00000000 00000000 00000001 00000000 
       f7ef5070 00000010 00001e03 b3cffce1 0000000a f7ef5070 f7ef5198 00000000 
       7fffffff 00000006 f7467edc c02fb06f f7467ec4 c0243292 f7e9eb40 f7fee858 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
mingetty      S 00000008     0   573      1                 548 (NOTLB)
f74f9e74 f7553520 c03b7bb0 00000008 f74f9eac 5a25a9be 00000008 000024bd 
       00000000 f7553520 00000c4b 5a25a9be 00000008 f748e560 f748e688 f7498000 
       7fffffff f74f9f00 f74f9eb0 c02fb06f c37b2380 f74f8000 00000000 00000000 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c01e7ad2>] read_chan+0x4e2/0x640
 [<c01e287c>] tty_read+0xcc/0xe0
 [<c014d088>] vfs_read+0x198/0x1a0
 [<c014d38b>] sys_read+0x4b/0x80
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
sshd          S 00000187     0   823    502   825     832       (NOTLB)
f7fbfea0 f7f5aa10 c03b8028 00000187 c01e1853 81a0af3c 00000187 0001031e 
       00000000 f7f5aa10 00006b6c 81a314f0 00000187 f748ea50 f748eb78 00000000 
       7fffffff 00000008 f7fbfedc c02fb06f 00000286 00000000 f7d9f000 f7d9f00c 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
bash          S C01364EA     0   825    823   828               (NOTLB)
f75bdf08 f748e070 c03b7b80 c01364ea f75bdee4 c013bd35 00000002 f75bdee8 
       c0125211 ffffffff 0000133a b3d1ff7b 0000012c f748e070 f748e198 fffffe00 
       f748e070 f748e11c f75bdf80 c0118d2b f7f5aa10 00000000 00000000 bf914df8 
Call Trace:
 [<c0118d2b>] do_wait+0x2bb/0x390
 [<c0118ecc>] sys_wait4+0x3c/0x40
 [<c0118ef5>] sys_waitpid+0x25/0x27
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
slabtop       S F74DDEB8     0   828    825                     (NOTLB)
f74ddea0 f7f5aa10 c03b7b80 f74ddeb8 c01e1853 f7f30000 00000187 00000000 
       00000096 c34f4520 000000ac 81a31a51 00000187 f7f5aa10 f7f5ab38 0014be0e 
       f74ddeb4 00000001 f74ddedc c02fb023 f74ddeb4 0014be0e f7f30000 c03bdb58 
Call Trace:
 [<c02fb023>] schedule_timeout+0x53/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
sshd          S 00000184     0   832    502   834           823 (NOTLB)
f7517ea0 f7f100f0 c03b7bb0 00000184 c01e1853 a47a174b 00000184 000013ac 
       00000000 f7f100f0 000008bd a47a45e4 00000184 f7f10ad0 f7f10bf8 00000000 
       7fffffff 00000008 f7517edc c02fb06f 00000286 00000000 f7d7a000 f7d7a00c 
Call Trace:
 [<c02fb06f>] schedule_timeout+0x9f/0xb0
 [<c015fea6>] do_select+0x256/0x290
 [<c01601fc>] sys_select+0x2cc/0x3f0
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
bash          S C01364EA     0   834    832   846               (NOTLB)
f755bf08 f7f100f0 c03b7b80 c01364ea f755bee4 c013bd35 00000002 f755bee8 
       c0125211 ffffffff 00001e40 a47e8c3d 00000184 f7f100f0 f7f10218 fffffe00 
       f7f100f0 f7f1019c f755bf80 c0118d2b f7fc10b0 00000000 00000000 bfccc0f8 
Call Trace:
 [<c0118d2b>] do_wait+0x2bb/0x390
 [<c0118ecc>] sys_wait4+0x3c/0x40
 [<c0118ef5>] sys_waitpid+0x25/0x27
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
rename14      S E3BD3EF0     0   846    834   847               (NOTLB)
e3bd3f20 f7fc10b0 c03b7b80 e3bd3ef0 e3bd3f9c 00000001 e3bd3f24 c0140f36 
       c2d32c80 f7fc1a90 00002ff6 a6b76d1a 00000184 f7fc10b0 f7fc11d8 fffffe00 
       f7fc10b0 f7fc115c e3bd3f98 c0118d2b ffffffff 00000004 f7ef5560 b7f9f181 
Call Trace:
 [<c0118d2b>] do_wait+0x2bb/0x390
 [<c0118ecc>] sys_wait4+0x3c/0x40
 [<c0102b5f>] sysenter_past_esp+0x54/0x75
rename14      R running     0   847    846           848       (NOTLB)
rename14      R running     0   848    846                 847 (NOTLB)
oom-killer: gfp_mask=0xd0, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:92
cpu 0 cold: low 0, high 62, batch 31 used:0
HighMem per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:77
cpu 0 cold: low 0, high 62, batch 31 used:28
Free pages:     2487360kB (2480124kB HighMem)
Active:1693 inactive:626 dirty:19 writeback:0 unstable:0 free:621840 slab:215739 mapped:1371 pagetables:65
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:30 all_unreclaimable? yes
lowmem_reserve[]: 0 880 4080
Normal free:3648kB min:3756kB low:4692kB high:5632kB active:0kB inactive:0kB present:901120kB pages_scanned:16 all_unreclaimable? yes
lowmem_reserve[]: 0 0 25600
HighMem free:2480124kB min:512kB low:640kB high:768kB active:6772kB inactive:2504kB present:3276800kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3648kB
HighMem: 1*4kB 1*8kB 19*16kB 12*32kB 21*64kB 14*128kB 5*256kB 2*512kB 2*1024kB 1*2048kB 603*4096kB = 2480124kB
Free swap:            0kB
1048576 pages of RAM
819200 pages of HIGHMEM
206973 reserved pages
3265 pages shared
0 pages swap cached
19 pages dirty
0 pages writeback
1371 pages mapped
215561 pages slab
65 pages pagetables
oom-killer: gfp_mask=0xd0, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:92
cpu 0 cold: low 0, high 62, batch 31 used:0
HighMem per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:175
cpu 0 cold: low 0, high 62, batch 31 used:28
Free pages:     2487732kB (2480496kB HighMem)
Active:1524 inactive:604 dirty:21 writeback:0 unstable:0 free:621933 slab:215754 mapped:1142 pagetables:55
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:52 all_unreclaimable? yes
lowmem_reserve[]: 0 880 4080
Normal free:3648kB min:3756kB low:4692kB high:5632kB active:0kB inactive:0kB present:901120kB pages_scanned:22 all_unreclaimable? yes
lowmem_reserve[]: 0 0 25600
HighMem free:2480496kB min:512kB low:640kB high:768kB active:6096kB inactive:2416kB present:3276800kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3648kB
HighMem: 60*4kB 18*8kB 19*16kB 12*32kB 21*64kB 14*128kB 5*256kB 2*512kB 2*1024kB 1*2048kB 603*4096kB = 2480496kB
Free swap:            0kB
1048576 pages of RAM
819200 pages of HIGHMEM
206973 reserved pages
2450 pages shared
0 pages swap cached
21 pages dirty
0 pages writeback
1142 pages mapped
215581 pages slab
55 pages pagetables
oom-killer: gfp_mask=0xd0, order=0
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1 used:2
cpu 0 cold: low 0, high 2, batch 1 used:0
Normal per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:92
cpu 0 cold: low 0, high 62, batch 31 used:0
HighMem per-cpu:
cpu 0 hot: low 62, high 186, batch 31 used:162
cpu 0 cold: low 0, high 62, batch 31 used:28
Free pages:     2487980kB (2480744kB HighMem)
Active:1476 inactive:603 dirty:22 writeback:1 unstable:0 free:621995 slab:215760 mapped:1014 pagetables:51
DMA free:3588kB min:68kB low:84kB high:100kB active:0kB inactive:0kB present:16384kB pages_scanned:68 all_unreclaimable? yes
lowmem_reserve[]: 0 880 4080
Normal free:3648kB min:3756kB low:4692kB high:5632kB active:0kB inactive:0kB present:901120kB pages_scanned:16 all_unreclaimable? yes
lowmem_reserve[]: 0 0 25600
HighMem free:2480744kB min:512kB low:640kB high:768kB active:5904kB inactive:2412kB present:3276800kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3588kB
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3648kB
HighMem: 86*4kB 26*8kB 20*16kB 14*32kB 21*64kB 14*128kB 5*256kB 2*512kB 2*1024kB 1*2048kB 603*4096kB = 2480744kB
Free swap:            0kB
1048576 pages of RAM
819200 pages of HIGHMEM
206973 reserved pages
2116 pages shared
0 pages swap cached
22 pages dirty
1 pages writeback
1014 pages mapped
215581 pages slab
51 pages pagetables

--------------020105020501080102060203--
