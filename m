Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbTJZWDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTJZWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 17:03:07 -0500
Received: from viefep15-int.chello.at ([213.46.255.19]:28497 "EHLO
	viefep15-int.chello.at") by vger.kernel.org with ESMTP
	id S263669AbTJZWDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 17:03:01 -0500
From: Simon Roscic <simon.roscic@chello.at>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test8/9] ethertap oops
Date: Sun, 26 Oct 2003 23:02:57 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200310262302.57320.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc me, as i´m not subscribed to lkml - thanks)

hi,

last week i started playing around with -test8, wich was working
very well on my machine, except ethertap, wich oopsed ...
i tried again with -test9, and as i expected (changelog doesnt
mention ethertap changes) i got the same oops.

i need ethertap for the vpn software (phion vpn) we use
at the office, the phion vpn client uses the ethertap
device and works well with kernel 2.4 series, but 
on 2.6 it doesn't work. (tried with -test8 & 9)
the initial connect seems to work, i see the vpn motd 
(the vpn client is an ncurses program), but as soon
as i try to do something eg. ping, or as soon as 
network traffic is going to / coming from the vpn, 
i get the following oops:

Unable to handle kernel paging request at virtual address 0000885e
 printing eip:
e18792d1
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<e18792d1>]    Not tainted
EFLAGS: 00010246
EIP is at ethertap_rx+0x131/0x2a0 [ethertap]
eax: 00000000   ebx: df344840   ecx: 00000000   edx: 00000800
esi: 0000885a   edi: df3448a4   ebp: 00000048   esp: de421d84
ds: 007b   es: 007b   ss: 0068
Process phionvpn (pid: 553, threadinfo=de420000 task=df746080)
Stack: df344840 de579ecc 00000011 dffcdc04 de420000 de579ecc dffcdbc0 de420000
       dffcdbc0 df633c80 c030d979 dffcdbc0 00000048 df344840 c030d050 dffcdbc0
       00000048 7fffffff 00000010 00000048 00000000 df746080 c0117370 00000000
Call Trace:
 [<c030d979>] netlink_data_ready+0x59/0x70
 [<c030d050>] netlink_unicast+0x290/0x340
 [<c0117370>] default_wake_function+0x0/0x30
 [<c0117370>] default_wake_function+0x0/0x30
 [<c02fd267>] alloc_skb+0x47/0xe0
 [<c030d632>] netlink_sendmsg+0x202/0x2f0
 [<c0117099>] schedule+0x2f9/0x580
 [<c02f980e>] sock_sendmsg+0x9e/0xd0
 [<c030e590>] netlink_write+0x0/0x80
 [<c030e600>] netlink_write+0x70/0x80
 [<c014d128>] vfs_write+0xb8/0x130
 [<c014d252>] sys_write+0x42/0x70
 [<c01091db>] syscall_call+0x7/0xb

Code: ff 46 04 01 6e 0c 89 1c 24 e8 51 85 a8 de 8b 54 24 14 a1 80

i´ve put up further information here:

kernel 2.6.0-test9 (vanilla+con`s swappiness autoregulation patch):

kernel .config:
http://segfault.info/simon/ethertap-oops/2.6.0-test9/kernel-2.6.0-test9.config
dmesg output:
http://segfault.info/simon/ethertap-oops/2.6.0-test9/dmesg-2.6.0-test9
ksymoops (useless on 2.6? - i remember there was some discussion on lkml a while back):
http://segfault.info/simon/ethertap-oops/2.6.0-test9/ksymoops-2.6.0-test9
the oops:
http://segfault.info/simon/ethertap-oops/2.6.0-test9/oops-2.6.0-test9
strace of the phion vpn client, one on kernel 2.4.22, and one on kernel 2.6.0-test9:
http://segfault.info/simon/ethertap-oops/2.6.0-test9/phion-strace-2.4.22
http://segfault.info/simon/ethertap-oops/2.6.0-test9/phion-strace-2.6.0-test9
ver_linux output:
http://segfault.info/simon/ethertap-oops/2.6.0-test9/ver_linux

kernel 2.6.0-test8 (vanilla, without any other patches):

kernel .config:
http://segfault.info/simon/ethertap-oops/2.6.0-test8/kernel-2.6.0-test8.config
ksymoops (useless on 2.6? - i remember there was some discussion on lkml a while back):
http://segfault.info/simon/ethertap-oops/2.6.0-test8/ksymoops-2.6.0-test8
the oops:
http://segfault.info/simon/ethertap-oops/2.6.0-test8/oops-2.6.0-test8
strace of the phion vpn client, one on kernel 2.4.22, and one on kernel 2.6.0-test8:
http://segfault.info/simon/ethertap-oops/2.6.0-test8/phion-strace-2.4.22
http://segfault.info/simon/ethertap-oops/2.6.0-test8/phion-strace-2.6.0-test8
ver_linux output:
http://segfault.info/simon/ethertap-oops/2.6.0-test8/ver_linux

i dont know, how  "clean" the phion vpn client software is, as it is a
closed source :(  program, but i think even if a program does something
ugly with ethertap it should not oops. (and it works on 2.4)
i hope the provided information is useable, if you need more information,
logs, etc. just mail me.

bye,
	simon.

