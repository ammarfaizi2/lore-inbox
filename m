Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267375AbUGNMwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267375AbUGNMwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267376AbUGNMwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:52:05 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:2945 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id S267375AbUGNMv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:51:57 -0400
Date: Wed, 14 Jul 2004 14:51:53 +0200
From: Hermann Gottschalk <hg@ostc.de>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange Network behaviour
Message-ID: <20040714125153.GA12938@ostc.de>
References: <20040702153028.GD15170@ostc.de> <20040704164654.GA18688@outpost.ds9a.nl> <20040714080036.GC11178@ostc.de> <20040714090208.GA2274@k3.hellgate.ch> <20040714102849.GD11727@ostc.de> <20040714103311.GA5411@k3.hellgate.ch> <20040714104008.GA12323@ostc.de> <20040714104858.GA5942@k3.hellgate.ch> <20040714105546.GA12380@ostc.de> <20040714110348.GA6393@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040714110348.GA6393@k3.hellgate.ch>
User-Agent: Mutt/1.4.1i
X-PGP-Key: 1024D/0B2D8EEA 2004-06-07 Hermann Gottschalk (OSTC) <hg@ostc.de>
X-PGP-Fingerprint: 9A36 D20E B7FB BE5D 11DB  3006 3ADA D083 0B2D 8EEA
X-Operating-System: Linux 2.4.21-231-default
X-message-flag: Please do NOT send HTML e-mail or MS Word attachments - use plain text instead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 01:03:48PM +0200, Roger Luethi wrote:
> On Wed, 14 Jul 2004 12:55:46 +0200, Hermann Gottschalk wrote:
> > After restart with noapic lvm causes the same problems...
> 
> This seems unrelated to via-rhine. And please use ksymoops(8) to make
> stack traces meaningful.

Here what dmesg | ksymoops give:
0100000 (reserved)
1151MB HIGHMEM available.
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex
kernel BUG at memory.c:531!
invalid operand: 0000 2.4.21-231-default #1 Mon Jun 28 15:39:34 UTC 2004
CPU:    0
EIP:    0010:[<c012db64>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c10e47a0   ecx: 0000000b   edx: c27ffd40
esi: c28031f0   edi: 00000000   ebp: 00000004   esp: ca121d7c
ds: 0018   es: 0018   ss: 0018
Process lvremove (pid: 8434, stackpage=ca121000)
Stack: c10e47a0 c4485120 c012dfd7 c10e47a0 c4462800 c4462800 c4462000 c4495447
       c4485120 c4485120 c44fa000 c44936c4 c4462800 c4462170 4004fe21 00000000
       c44fa000 bffff320 c4490940 00000000 c4499ca0 ffffffff ca3f09a0 ca124ed0
Call Trace:         [<c012dfd7>] (20) [<c4495447>] (16) [<c44936c4>] (28)
  [<c4490940>] (08) [<c4499ca0>] (16) [<c012f795>] (44) [<c0118718>] (56)
  [<c01c0d05>] (32) [<c013ab0c>] (16) [<c013437e>] (28) [<c86f2924>] (20)
  [<c012f2d3>] (72) [<c014ed80>] (24) [<c0151c8a>] (16) [<c014492b>] (16)
  [<c010c5b8>] (32) [<c0144a94>] (24) [<c01438f4>] (28) [<c01437b0>] (24)
  [<c0152e26>] (32) [<c0143b0c>] (20) [<c0108e13>] (60)
Code: 0f 0b 13 02 a6 22 2a c0 eb dc 89 f6 55 57 56 53 57 57 83 7c


>>EIP; c012db64 <unpin_pte_page+34/40>   <=====

>>ebx; c10e47a0 <_end+d0fbfc/2d8b4bc>
>>edx; c27ffd40 <_end+242b19c/2d8b4bc>
>>esi; c28031f0 <_end+242e64c/2d8b4bc>
>>esp; ca121d7c <[af_packet]packet_socks_nr+53edd8/43bd0bc>

Trace; c012dfd7 <unmap_kiobuf+17/50>
Trace; c4495447 <[lvm-mod]lvm_snapshot_release+87/e0>
Trace; c44936c4 <[lvm-mod]lvm_do_lv_remove+114/2f0>
Trace; c4490940 <[lvm-mod]lvm_chr_ioctl+500/640>
Trace; c4499ca0 <[lvm-mod]lv_req+0/a0>
Trace; c012f795 <handle_mm_fault+95/150>
Trace; c0118718 <do_page_fault+1b8/5b0>
Trace; c01c0d05 <pty_write+115/150>
Trace; c013ab0c <activate_page+8c/a0>
Trace; c013437e <filemap_nopage+ce/200>
Trace; c86f2924 <[e1000]e1000_clean_rx_irq+184/400>
Trace; c012f2d3 <do_no_page+c3/3b0>
Trace; c014ed80 <cached_lookup+10/60>
Trace; c0151c8a <__link_path_walk+67a/6b0>
Trace; c014492b <get_chrfops+ab/e0>
Trace; c010c5b8 <call_do_IRQ+5/d>
Trace; c0144a94 <chrdev_open+44/50>
Trace; c01438f4 <dentry_open+134/1a0>
Trace; c01437b0 <filp_open+50/60>
Trace; c0152e26 <sys_ioctl+1d6/26a>
Trace; c0143b0c <sys_open+5c/90>
Trace; c0108e13 <system_call+33/40>

Code;  c012db64 <unpin_pte_page+34/40>
00000000 <_EIP>:
Code;  c012db64 <unpin_pte_page+34/40>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012db66 <unpin_pte_page+36/40>
   2:   13 02                     adc    (%edx),%eax
Code;  c012db68 <unpin_pte_page+38/40>
   4:   a6                        cmpsb  %es:(%edi),%ds:(%esi)
Code;  c012db69 <unpin_pte_page+39/40>
   5:   22 2a                     and    (%edx),%ch
Code;  c012db6b <unpin_pte_page+3b/40>
   7:   c0 eb dc                  shr    $0xdc,%bl
Code;  c012db6e <unpin_pte_page+3e/40>
   a:   89 f6                     mov    %esi,%esi
Code;  c012db70 <__get_user_pages+0/2c0>
   c:   55                        push   %ebp
Code;  c012db71 <__get_user_pages+1/2c0>
   d:   57                        push   %edi
Code;  c012db72 <__get_user_pages+2/2c0>
   e:   56                        push   %esi
Code;  c012db73 <__get_user_pages+3/2c0>
   f:   53                        push   %ebx
Code;  c012db74 <__get_user_pages+4/2c0>
  10:   57                        push   %edi
Code;  c012db75 <__get_user_pages+5/2c0>
  11:   57                        push   %edi
Code;  c012db76 <__get_user_pages+6/2c0>
  12:   83 7c 00 00 00            cmpl   $0x0,0x0(%eax,%eax,1)


1 warning issued.  Results may not be reliable.






-- 
  ___  ___ _____ ___    ___       _    _  _
 / _ \/ __|_   _/ __|  / __|_ __ | |__| || |
| (_) \__ \ | || (__  | (_ | '  \| '_ \ __ |
 \___/|___/ |_| \___|  \___|_|_|_|_.__/_||_|
----------------------------------------------
 OSTC Open Source Training and Consulting GmbH
 90425 Nürnberg      Web:   http://www.ostc.de
----------------------------------------------
            PGP-Key: 0x0B2D8EEA 
    No HTML-Mails; 72 Characters per line
