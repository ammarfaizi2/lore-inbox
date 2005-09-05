Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVIEAHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVIEAHK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 20:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVIEAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 20:07:09 -0400
Received: from ms-smtp-02-lbl.southeast.rr.com ([24.25.9.101]:23453 "EHLO
	ms-smtp-02-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S932229AbVIEAHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 20:07:07 -0400
Message-Id: <200509050006.j8506plA025800@ms-smtp-02-eri0.southeast.rr.com>
From: "Matt LaPlante" <laplam@rpi.edu>
To: "'Jesper Juhl'" <jesper.juhl@gmail.com>
Cc: "'Herbert Xu'" <herbert@gondor.apana.org.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Potential IPSec DoS/Kernel Panic with 2.6.13
Date: Sun, 4 Sep 2005 20:06:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <9a8748490509041556771499f5@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcWxpBjfnHe7u2bmTTOQ4cXB7jcjPAACTPSg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a direct serial connection and boy was that a lot easier.  Anyway,
without further adeu, the crash:

#############################
Unable to handle kernel paging request at virtual address 50c86502
 printing eip:
c01bd216
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: aes_i586 esp6 ah6 ipcomp esp4 ah4 af_key xfrm_user
michael_mic deflate twofish khazad wp512 arc4 serpent tea sha512 blowfish
sha256 md5 md4 cast6 cast5 des crypto_null zlib_deflate ipv6 ipt_ULOG
ipt_REJECT ipt_LOG ipt_state ipt_pkttype ipt_CONNMARK ipt_connmark ipt_owner
ipt_recent ipt_iprange ipt_multiport ip_nat_irc ip_nat_tftp ip_conntrack_irc
ip_conntrack_tftp evdev floppy pcspkr intel_agp via_rhine mii tulip agpgart
psmouse ide_cd cdrom
CPU:    0
EIP:    0060:[<c01bd216>]    Not tainted VLI
EFLAGS: 00010216   (2.6.13-Firewall.CyberDog.v12) 
EIP is at sha1_update+0x96/0xe0
eax: cd485f0c   ebx: 0000000c   ecx: 00000003   edx: 00000244
esi: 50c86502   edi: cd485f5c   ebp: 50c86502   esp: c0333c40
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0332000 task=c02edb80)
Stack: 00000244 cd485f0c 00000000 00000000 00000000 00000000 00000000
00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
Call Trace:
 [<c01bc881>] update+0x91/0xd0
 [<c01bcf11>] crypto_hmac_update+0x11/0x20
 [<c02a28c3>] skb_icv_walk+0xe3/0x200
 [<d0aa5d23>] esp_hmac_digest+0x63/0xa0 [esp4]
 [<c01bcf00>] crypto_hmac_update+0x0/0x20
 [<c01bc524>] cbc_encrypt+0x44/0x50
 [<d0aa5350>] esp_output+0x350/0x420 [esp4]
 [<c029c920>] xfrm4_output+0x70/0x170
 [<c0260510>] ip_forward_finish+0x0/0x40
 [<c02603bf>] ip_forward+0x16f/0x2c0
 [<c0260510>] ip_forward_finish+0x0/0x40
 [<c025ed85>] ip_rcv+0x365/0x4d0
 [<c025f0a0>] ip_rcv_finish+0x0/0x280
 [<c02a67a6>] packet_rcv_spkt+0x186/0x260
 [<d09e77f0>] tulip_poll+0x0/0x680 [tulip]
 [<c0244ea9>] netif_receive_skb+0x1a9/0x260
 [<d09e7c55>] tulip_poll+0x465/0x680 [tulip]
 [<d09df692>] rhine_interrupt+0x42/0x240 [via_rhine]
 [<c02450fc>] net_rx_action+0xac/0x1b0
 [<c0119c19>] __do_softirq+0x79/0x90
 [<c0119c57>] do_softirq+0x27/0x30
 [<c0119d25>] irq_exit+0x35/0x40
 [<c01047be>] do_IRQ+0x1e/0x30
 [<c0102df2>] common_interrupt+0x1a/0x20
 [<c0100bf0>] default_idle+0x0/0x30
 [<c0100c13>] default_idle+0x23/0x30
 [<c0100cb0>] cpu_idle+0x50/0x60
 [<c0334787>] start_kernel+0x177/0x1c0
 [<c0334340>] unknown_bootoption+0x0/0x1c0
Code: 83 e1 03 74 02 f3 a4 81 c4 48 01 00 00 5b 5e 5f 5d c3 8d 76 00 8b 44
24 04 bb 40 00 00 00 29 f3 89 d9 8d 7c 06 1c 89 ee c1 e9 02 <f3> a5 89 d9 83
e1 03 74 02 f3 a4 89 c6 8d 7c 24 08 89 c2 83 c6 
 <0>Kernel panic - not syncing: Fatal exception in interrupt
#############################

Hope that helps!  If you need more info just ask!

-
Matt


