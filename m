Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131755AbQLVDkY>; Thu, 21 Dec 2000 22:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131791AbQLVDkO>; Thu, 21 Dec 2000 22:40:14 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:46467 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131755AbQLVDj5>; Thu, 21 Dec 2000 22:39:57 -0500
Date: Fri, 22 Dec 2000 03:12:20 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: reliable oops in test12: kswapd: submit_bh
Message-ID: <Pine.LNX.4.30.0012220303290.27430-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a server that Oopsed 3 nights in a row at nearly the same time
04:04:{22,26,22} each /second/ night (presumably nightly locate
update)  in the same place: in submit_bh while in kswapd.

kernel in question is test12.
machine is K6-233 with a DAC960 that does NFS/dialup/iptables
serving.
Test13-pre3 Ooopses on bootup in nfsd, so I've gone back to test10.
Here are the oopses after being put through ksymoops:

ksymoops 2.3.5 on i586 2.4.0-test10.  Options used
     -v /boot/vmlinux-2.4.0-test12 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test12/ (specified)
     -m /boot/System.map-2.4.0-test12 (specified)

No modules in ksyms, skipping objects
Dec 18 04:04:26 hibernia kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Dec 18 04:04:26 hibernia kernel: c015d3d5
Dec 18 04:04:26 hibernia kernel: *pde = 00000000
Dec 18 04:04:26 hibernia kernel: Oops: 0000
Dec 18 04:04:26 hibernia kernel: CPU:    0
Dec 18 04:04:26 hibernia kernel: EIP:    0010:[submit_bh+5/92]
Dec 18 04:04:26 hibernia kernel: EFLAGS: 00010207
Dec 18 04:04:26 hibernia kernel: eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c12c8104
Dec 18 04:04:26 hibernia kernel: esi: 00000002   edi: c6ec7f00   ebp: c12ebf48   esp: c12ebeec
Dec 18 04:04:26 hibernia kernel: ds: 0018   es: 0018   ss: 0018
Dec 18 04:04:26 hibernia kernel: Process kswapd (pid: 3, stackpage=c12eb000)
Dec 18 04:04:26 hibernia kernel: Stack: 00000000 c0131701 00000001 00000000 00041300 c10a54e4 000000aa 00001000
Dec 18 04:04:26 hibernia kernel:        c0129dd7 00000001 c10a54e4 00003001 c12ebf44 00001000 00041300 c10a54e4
Dec 18 04:04:26 hibernia kernel:        000000aa 00000040 c12ebf44 00000413 30010246 00000000 00000413 c1ab7600
Dec 18 04:04:26 hibernia kernel: Call Trace: [brw_page+145/164] [rw_swap_page_base+327/428] [rw_swap_page+117/188] [swap_writepage+14/20] [page_launder+592/2056] [do_try_to_free_pages+52/128] [generic_unplug_device+0/40]
Dec 18 04:04:26 hibernia kernel: Code: 8b 43 18 a8 04 75 19 68 7f 03 00 00 68 a2 f9 1d c0 68 05 f7
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000003 Before first symbol
   3:   a8 04                     test   $0x4,%al
Code;  00000005 Before first symbol
   5:   75 19                     jne    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000007 Before first symbol
   7:   68 7f 03 00 00            push   $0x37f
Code;  0000000c Before first symbol
   c:   68 a2 f9 1d c0            push   $0xc01df9a2
Code;  00000011 Before first symbol
  11:   68 05 f7 00 00            push   $0xf705

ksymoops 2.3.5 on i586 2.4.0-test10.  Options used
     -v /boot/vmlinux-2.4.0-test12 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test12/ (specified)
     -m /boot/System.map-2.4.0-test12 (specified)

No modules in ksyms, skipping objects
Dec 16 04:04:22 hibernia kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Dec 16 04:04:22 hibernia kernel: c015d3d5
Dec 16 04:04:22 hibernia kernel: *pde = 00000000
Dec 16 04:04:22 hibernia kernel: Oops: 0000
Dec 16 04:04:22 hibernia kernel: CPU:    0
Dec 16 04:04:22 hibernia kernel: EIP:    0010:[submit_bh+5/92]
Dec 16 04:04:22 hibernia kernel: EFLAGS: 00010207
Dec 16 04:04:22 hibernia kernel: eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c12c8104
Dec 16 04:04:22 hibernia kernel: esi: 00000002   edi: c40a6b00   ebp: c12ebf48   esp: c12ebeec
Dec 16 04:04:22 hibernia kernel: ds: 0018   es: 0018   ss: 0018
Dec 16 04:04:22 hibernia kernel: Process kswapd (pid: 3, stackpage=c12eb000)
Dec 16 04:04:22 hibernia kernel: Stack: 00000000 c0131701 00000001 00000000 000a0500 c10a7a9c 000000ba 00001000
Dec 16 04:04:22 hibernia kernel:        c0129dd7 00000001 c10a7a9c 00003001 c12ebf44 00001000 000a0500 c10a7a9c
Dec 16 04:04:22 hibernia kernel:        000000ba 00000040 c12ebf44 00000a05 30010246 00000000 00000a05 c6f633e0
Dec 16 04:04:22 hibernia kernel: Call Trace: [brw_page+145/164] [rw_swap_page_base+327/428] [rw_swap_page+117/188] [swap_writepage+14/20] [page_launder+592/2056] [do_try_to_free_pages+52/128] [generic_unplug_device+0/40]
Dec 16 04:04:22 hibernia kernel: Code: 8b 43 18 a8 04 75 19 68 7f 03 00 00 68 a2 f9 1d c0 68 05 f7
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000003 Before first symbol
   3:   a8 04                     test   $0x4,%al
Code;  00000005 Before first symbol
   5:   75 19                     jne    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000007 Before first symbol
   7:   68 7f 03 00 00            push   $0x37f
Code;  0000000c Before first symbol
   c:   68 a2 f9 1d c0            push   $0xc01df9a2
Code;  00000011 Before first symbol
  11:   68 05 f7 00 00            push   $0xf705

ksymoops 2.3.5 on i586 2.4.0-test10.  Options used
     -v /boot/vmlinux-2.4.0-test12 (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test12/ (specified)
     -m /boot/System.map-2.4.0-test12 (specified)

No modules in ksyms, skipping objects
Dec 14 04:04:26 hibernia kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Dec 14 04:04:26 hibernia kernel: c015d3d5
Dec 14 04:04:26 hibernia kernel: *pde = 00000000
Dec 14 04:04:26 hibernia kernel: Oops: 0000
Dec 14 04:04:26 hibernia kernel: CPU:    0
Dec 14 04:04:26 hibernia kernel: EIP:    0010:[submit_bh+5/92]
Dec 14 04:04:26 hibernia kernel: EFLAGS: 00010203
Dec 14 04:04:26 hibernia kernel: eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c12c8104
Dec 14 04:04:26 hibernia kernel: esi: 00000002   edi: c2371680   ebp: c12ebf48   esp: c12ebeec
Dec 14 04:04:26 hibernia kernel: ds: 0018   es: 0018   ss: 0018
Dec 14 04:04:26 hibernia kernel: Process kswapd (pid: 3, stackpage=c12eb000)
Dec 14 04:04:26 hibernia kernel: Stack: 00000000 c0131701 00000001 00000000 000f2b00 c1179b08 c0201098 00001000
Dec 14 04:04:26 hibernia kernel:        c0129dd7 00000001 c1179b08 00003001 c12ebf44 00001000 000f2b00 c1179b08
Dec 14 04:04:26 hibernia kernel:        c0201098 0000003a c12ebf44 00000f2b 30010246 00000000 00000f2b c33ebce0
Dec 14 04:04:26 hibernia kernel: Call Trace: [brw_page+145/164] [rw_swap_page_base+327/428] [rw_swap_page+117/188] [swap_writepage+14/20] [page_launder+592/2056] [do_try_to_free_pages+52/128] [generic_unplug_device+0/40]
Dec 14 04:04:26 hibernia kernel: Code: 8b 43 18 a8 04 75 19 68 7f 03 00 00 68 a2 f9 1d c0 68 05 f7
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  00000003 Before first symbol
   3:   a8 04                     test   $0x4,%al
Code;  00000005 Before first symbol
   5:   75 19                     jne    20 <_EIP+0x20> 00000020 Before first symbol
Code;  00000007 Before first symbol
   7:   68 7f 03 00 00            push   $0x37f
Code;  0000000c Before first symbol
   c:   68 a2 f9 1d c0            push   $0xc01df9a2
Code;  00000011 Before first symbol
  11:   68 05 f7 00 00            push   $0xf705


-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The way I understand it, the Russians are sort of a combination of evil and
incompetence... sort of like the Post Office with tanks.
		-- Emo Philips

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
