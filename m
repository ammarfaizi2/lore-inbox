Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTJBWRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 18:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTJBWRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 18:17:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:50074 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263531AbTJBWRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 18:17:22 -0400
Date: Fri, 3 Oct 2003 00:17:21 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linux-ppp@vger.kernel.org, linux-atm@vger.kernel.org
Cc: util@deuroconsult.ro, devik@cdi.cz
MIME-Version: 1.0
Subject: [BUG] linux-2.6.0-test6 networking HTB/qdisc oops...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <16523.1065133041@www19.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I kill pppd after it has brought up the ppp0 interface with HTB QoS
filtering/traffic shaping to my PPPoA ADSL speedtouch modem, I get this oops.
Please reply to me directly for more information, as I'm not on the mailing
lists.

---

Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02d11f5>]    Not tainted
EFLAGS: 00010282
eax: 00000000   ebx: da7aa86c   ecx: db3a6df8   edx: da7aa7f8
esi: db3a6df8   edi: d364e578   ebp: ccc2fdfc   esp: ccc2fde4
ds: 007b   es: 007b   ss: 0068
Stack: c11c5458 00000000 c011a5b5 cc9eb000 d364e52c dc7de80c ccc2fe10
c02d941a
       da7aa7f8 db3a6df8 00000000 ccc2fe2c c02d96c3 d364e578 d364e52c
dc7de80c
       dc7de28c d364e578 ccc2fe50 c02d9702 d364e578 dc7de80c c011a5b5
c11f8cb8
Call Trace:
 [<c011a5b5>] kernel_map_pages+0x28/0x5f
 [<c02d941a>] u32_destroy_key+0x6a/0x6c
 [<c02d96c3>] u32_clear_hnode+0x2e/0x48
 [<c02d9702>] u32_destroy_hnode+0x25/0xa9
 [<c011a5b5>] kernel_map_pages+0x28/0x5f
 [<c02d9868>] u32_destroy+0xe2/0x110
 [<c02d04cf>] htb_destroy_class+0x18b/0x1c3
 [<c02d0338>] htb_destroy_filters+0x1d/0x29
 [<c02d056e>] htb_destroy+0x67/0xd2
 [<c02c7b31>] qdisc_destroy+0x81/0x92
 [<c02c8292>] dev_shutdown+0xaa/0x268
 [<c0139a34>] wakeme_after_rcu+0x0/0xc
 [<c02bb6b5>] unregister_netdevice+0xdb/0x352
 [<c02c32d2>] rtnl_lock+0x22/0x37
 [<c0236c5b>] unregister_netdev+0x19/0x26
 [<c023ceed>] ppp_shutdown_interface+0x21e/0x3ba
 [<c0183c66>] dput+0x23/0x723
 [<c0165644>] __fput+0x7c/0xcd
 [<c02370c5>] ppp_release+0x5f/0x61
 [<c0165683>] __fput+0xbb/0xcd
 [<c016371b>] filp_close+0x57/0x81
 [<c0163849>] sys_close+0x104/0x228
 [<c010a3eb>] syscall_call+0x7/0xb
Code: 83 ae 58 01 00 00 01 8b 5d f8 8b 75 fc 89 ec 5d c3 83 ab 3c
 
 
>>EIP; c02d11f5 <htb_unbind_filter+49/6b>   <=====
 
>>ebx; da7aa86c <_end+1a330f74/3fb84708>
>>ecx; db3a6df8 <_end+1af2d500/3fb84708>
>>edx; da7aa7f8 <_end+1a330f00/3fb84708>
>>esi; db3a6df8 <_end+1af2d500/3fb84708>
>>edi; d364e578 <_end+131d4c80/3fb84708>
>>ebp; ccc2fdfc <_end+c7b6504/3fb84708>
>>esp; ccc2fde4 <_end+c7b64ec/3fb84708>
 
Trace; c011a5b5 <kernel_map_pages+28/5f>
Trace; c02d941a <u32_destroy_key+6a/6c>
Trace; c02d96c3 <u32_clear_hnode+2e/48>
Trace; c02d9702 <u32_destroy_hnode+25/a9>
Trace; c011a5b5 <kernel_map_pages+28/5f>
Trace; c02d9868 <u32_destroy+e2/110>
Trace; c02d04cf <htb_destroy_class+18b/1c3>
Trace; c02d0338 <htb_destroy_filters+1d/29>
Trace; c02d056e <htb_destroy+67/d2>
Trace; c02c7b31 <qdisc_destroy+81/92>
Trace; c02c8292 <dev_shutdown+aa/268>
Trace; c0139a34 <wakeme_after_rcu+0/c>
Trace; c02bb6b5 <unregister_netdevice+db/352>
Trace; c02c32d2 <rtnl_lock+22/37>
Trace; c0236c5b <unregister_netdev+19/26>
Trace; c023ceed <ppp_shutdown_interface+21e/3ba>
Trace; c0183c66 <dput+23/723>
Trace; c0165644 <__fput+7c/cd>
Trace; c02370c5 <ppp_release+5f/61>
Trace; c0165683 <__fput+bb/cd>
Trace; c016371b <filp_close+57/81>
Trace; c0163849 <sys_close+104/228>
Trace; c010a3eb <syscall_call+7/b>
 
Code;  c02d11f5 <htb_unbind_filter+49/6b>
00000000 <_EIP>:
Code;  c02d11f5 <htb_unbind_filter+49/6b>   <=====
   0:   83 ae 58 01 00 00 01      subl   $0x1,0x158(%esi)   <=====
Code;  c02d11fc <htb_unbind_filter+50/6b>
   7:   8b 5d f8                  mov    0xfffffff8(%ebp),%ebx
Code;  c02d11ff <htb_unbind_filter+53/6b>
   a:   8b 75 fc                  mov    0xfffffffc(%ebp),%esi
Code;  c02d1202 <htb_unbind_filter+56/6b>
   d:   89 ec                     mov    %ebp,%esp
Code;  c02d1204 <htb_unbind_filter+58/6b>
   f:   5d                        pop    %ebp
Code;  c02d1205 <htb_unbind_filter+59/6b>
  10:   c3                        ret
Code;  c02d1206 <htb_unbind_filter+5a/6b>
  11:   83 ab 3c 00 00 00 00      subl   $0x0,0x3c(%ebx)
 
 <0>Kernel panic: Fatal exception in interrupt

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

