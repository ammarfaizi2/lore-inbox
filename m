Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbTJFQCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTJFQCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:02:00 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:450 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262307AbTJFQB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:01:57 -0400
Subject: Random Segmentation fault... in my code
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1065456083.13024.144.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 06 Oct 2003 18:01:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am really puzzled, with a friend we are having some fun with Netlink
(NETLINK_USERSOCK) but most of the time we get a segmentation fault when
we try to upload something from our user-space tool to our kernel-space
module.

I said _most_of_the_time_ because, actually, from time to time it
works... which is something that I do not understand (when I do bad
code, I want it to fail without any flaw !!! :).

Moreover, the oops that we get claim that a function (<e088393c>) has
crashed but the only module loaded is our and it doesn't seems to have
these function (or at least, I don't know how to get the name of this
function through ksyms).

Does this make any sense to somebody ???

Any comment or hint would be very welcome.

=====

printing eip:
 e088393c
 Oops: 0002
 CPU:    0
 EIP:    0010:[<e088393c>]    Not tainted
 EFLAGS: 00010086
 eax: e0c43024   ebx: ad19dade   ecx: e0c41000   ed x: e0cc54cc 
 esi: 00000000   edi: e0884320   ebp: c8511d18   es p: c8511d00
 ds: 0018   es: 0018   ss: 0018
 Process nkconf (pid: 1776, stackpage=c8511000)
 Stack: 0000000a 00000400 00000001 d2bdff40 df53db4 0 ccc0b688 c8511d48
e0883456
        00000001 00000002 00000000 00000000 ad19dad e 00000000 c01dbf67
df4d8080
        ccc0b640 d2bdff40 c8511d78 e088323a d2bdff4 0 00000001 c02055cd
00000282
 Call Trace:    [<e0883456>] [__kfree_skb+247/352] [<e088323a>]
[tcp_v4_do_rcv+285/288] [netlink_data_ready+122/128]
   [netlink_unicast+584/672] [netlink_sendmsg+491/6 40]
[sock_sendmsg+117/176] [sys_sendmsg+439/528] [do_no_page+121/432]
[handle_mm _fault+119/272]
   [do_page_fault+350/1247] [file_read_actor+0/160]  [sys_socket+61/96]
[sys_socketcall+568/608] [filp_close+77/128] [system_call+51 /56]

 Code: 89 1c b2 8b 50 08 8b 45 1c c1 e0 04 03 41 10  89 04 b2 eb 07

=====

ksyms: 

Address   Symbol                            Defined by
e0883000 
__insmod_nk_O/root/fleury/netkeeper/linux/net/ipv4/netkeeper/nk.o_M3F81AA84_V132116  [nk]
e0883060  __insmod_nk_S.text_L3067          [nk]
e0883c5c  __insmod_nk_S.rodata_L852         [nk]

=====

Regards
-- 
Emmanuel

Calvin: I'm a genius, but I'm a misunderstood genius.
Hobbes: What's misunderstood about you?
Calvin: Nobody thinks I'm a genius.
  -- Calvin & Hobbes (Bill Waterson)

