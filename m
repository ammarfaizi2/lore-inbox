Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265975AbRGXAfz>; Mon, 23 Jul 2001 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRGXAfp>; Mon, 23 Jul 2001 20:35:45 -0400
Received: from pop3.telenet-ops.be ([195.130.132.40]:56301 "EHLO
	pop3.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S265975AbRGXAfb>; Mon, 23 Jul 2001 20:35:31 -0400
Subject: Kernel OOPS in 2.4.6-ac2
From: Roel Teuwen <Roel.Teuwen@advalvas.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.11 (Beta Release)
Date: 24 Jul 2001 02:33:33 +0200
Message-Id: <995934813.8110.18.camel@omniroel>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

When inserting and removing a pcmcia compactflash card, the following
(decoded) oops occurred :

ksymoops 2.3.4 on i586 2.4.6-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6-ac2/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address 333dbb10
c019009b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c019009b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000030   ebx: 333dbb10   ecx: 00000029   edx: 00000000
esi: c362cc00   edi: 00000020   ebp: c26fd930   esp: c26fd8f0
ds: 0018   es: 0018   ss: 0018
Process cardmgr (pid: 2006, stackpage=c26fd000)
Stack: 333dbb10 c362cc00 00000020 c0191046 333dbb10 c01f9971 c3bfd280
c26fdcb0
       00000030 c482489d 00000029 333dbb10 00000000 00000030 c26fdcb0
00000020
       c26fdb94 c4824831 c362cc00 c362cc00 c26fdcb0 c3bfd2d8 3dbb3a90
3e864190
Call Trace: [<c0191046>] [<c0189f34>] [<c018a183>] [<c018b3f7>]
[<c01605d9>]
   [<c019a361>] [<c0165383>] [<c01648bc>] [<c01124a9>] [<c011260a>]
[<c01127a3>]   [<c0190e50>] [<c01910f7>] [<c018c946>] [<c011f2f0>]
[<c018fd67>] [<c018fd67>]   [<c0177d1c>] [<c0170de0>] [<c0170e14>]
[<c0190ffc>] [<c018f080>] [<c018d724>]   [<c018e1d6>] [<c01162ee>]
[<c010807a>] [<c01161eb>] [<c011603b>] [<c010822c>]   [<c010a4be>]
[<c011f25f>] [<c019f1a7>] [<c01a0979>] [<c01cf632>] [<c0140e55>]
[<c016f538>] [<c0177d76>] [<c0177c80>] [<c0170de0>] [<c0177c80>]
[<c010807a>]   [<c0120234>] [<c010a4be>] [<c012006d>] [<c0120415>]
[<c013af07>] [<c0106cb3>]Code: 66 81 3b 5c b3 75 18 66 8b 4b 02 bf 20 00
00 00 8b 53 04 89

>>EIP; c019009b <pcmcia_release_window+b/90>   <=====
Trace; c0191046 <CardServices+1e6/330>
Trace; c0189f34 <pcmcia_get_next_tuple+a4/280>
Trace; c018a183 <pcmcia_get_tuple_data+73/80>
Trace; c018b3f7 <pcmcia_parse_tuple+d7/170>
Trace; c01605d9 <scrup+69/110>
Trace; c019a361 <vgacon_cursor+191/1a0>
Trace; c0165383 <poke_blanked_console+63/70>
Trace; c01648bc <vt_console_print+2fc/310>
Trace; c01124a9 <__call_console_drivers+39/50>
Trace; c011260a <call_console_drivers+da/e0>
Trace; c01127a3 <printk+123/130>
Trace; c0190e50 <pcmcia_report_error+a0/b0>
Trace; c01910f7 <CardServices+297/330>
Trace; c018c946 <MTDHelperEntry+36/80>
Trace; c011f2f0 <do_no_page+50/e0>
Trace; c018fd67 <pcmcia_register_client+237/260>
Trace; c018fd67 <pcmcia_register_client+237/260>
Trace; c0177d1c <write_intr+9c/130>
Trace; c0170de0 <ide_intr+f0/150>
Trace; c0170e14 <ide_intr+124/150>
Trace; c0190ffc <CardServices+19c/330>
Trace; c018f080 <pcmcia_bind_device+40/d0>
Trace; c018d724 <bind_request+174/1a0>
Trace; c018e1d6 <ds_ioctl+546/670>
Trace; c01162ee <bh_action+1e/40>
Trace; c010807a <handle_IRQ_event+3a/70>
Trace; c01161eb <tasklet_hi_action+4b/80>
Trace; c011603b <do_softirq+4b/70>
Trace; c010822c <do_IRQ+9c/b0>
Trace; c010a4be <call_do_IRQ+5/17>
Trace; c011f25f <do_anonymous_page+8f/d0>
Trace; c019f1a7 <alloc_skb+d7/1a0>
Trace; c01a0979 <memcpy_toiovec+69/70>
Trace; c01cf632 <mark_source_chains+42/1f0>
Trace; c0140e55 <iget4+c5/d0>
Trace; c016f538 <ide_set_handler+58/60>
Trace; c0177d76 <write_intr+f6/130>
Trace; c0177c80 <write_intr+0/130>
Trace; c0170de0 <ide_intr+f0/150>
Trace; c0177c80 <write_intr+0/130>
Trace; c010807a <handle_IRQ_event+3a/70>
Trace; c0120234 <do_munmap+64/260>
Trace; c010a4be <call_do_IRQ+5/17>
Trace; c012006d <unmap_fixup+6d/140>
Trace; c0120415 <do_munmap+245/260>
Trace; c013af07 <sys_ioctl+187/1a0>
Trace; c0106cb3 <system_call+33/40>
Code;  c019009b <pcmcia_release_window+b/90>
00000000 <_EIP>:
Code;  c019009b <pcmcia_release_window+b/90>   <=====
   0:   66 81 3b 5c b3            cmpw   $0xb35c,(%ebx)   <=====
Code;  c01900a0 <pcmcia_release_window+10/90>
   5:   75 18                     jne    1f <_EIP+0x1f> c01900ba
<pcmcia_release_window+2a/90>
Code;  c01900a2 <pcmcia_release_window+12/90>
   7:   66 8b 4b 02               mov    0x2(%ebx),%cx
Code;  c01900a6 <pcmcia_release_window+16/90>
   b:   bf 20 00 00 00            mov    $0x20,%edi
Code;  c01900ab <pcmcia_release_window+1b/90>
  10:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01900ae <pcmcia_release_window+1e/90>
  13:   89 00                     mov    %eax,(%eax)

I haven'y had time to test any newer kernels yet.

Kind regards,

Roel Teuwen

