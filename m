Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292599AbSCSUUJ>; Tue, 19 Mar 2002 15:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292617AbSCSUUA>; Tue, 19 Mar 2002 15:20:00 -0500
Received: from nextgeneration.speedroad.net ([195.139.232.50]:42880 "HELO
	nextgeneration.speedroad.net") by vger.kernel.org with SMTP
	id <S292588AbSCSUTs> convert rfc822-to-8bit; Tue, 19 Mar 2002 15:19:48 -0500
Date: Tue, 19 Mar 2002 21:18:51 +0100
From: Arnvid Karstad <arnvid@karstad.org>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.4.18 and CL GD530 and fb?
Message-Id: <20020319204955.0A81.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.00.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I compiled my machine with the following option

< >   Cirrus Logic support (EXPERIMENTAL)

It dies kinda fast after boot up..

More precisely  when I log in and I get past line 25 and it's supposed
to start scrolling.

The lspci shows this as my VGA adapter,

00:0e.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 47)

But the card itself is an Intergraph Intense 3D Pro 3400 and the machine
is an IBM IntelliStation Z Pro 6865 250 currently fitted with an
ServeRaid 4L adapter and an EXP200 disk cabinet. But I don't really
think that it matters ;)

Snipplet from dmesg
Mar 19 09:40:34 nextgeneration kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Mar 19 09:40:35 nextgeneration kernel: JFS development version: $Name: v1_0_16 $
Mar 19 09:40:35 nextgeneration kernel: clgen: Driver for Cirrus Logic based graphic boards, v1.9.9.1
Mar 19 09:40:35 nextgeneration kernel:  RAM (512 kB) at 0xf6000000, Cirrus Logic chipset on PCI bus
Mar 19 09:40:35 nextgeneration kernel: clgen: This board has 524288 bytes of DRAM memory
Mar 19 09:40:35 nextgeneration kernel: Cirrus Logic video mode: 8 bit color depth
Mar 19 09:40:35 nextgeneration kernel: Console: switching to colour frame buffer device 80x30
Mar 19 09:40:35 nextgeneration kernel: pty: 256 Unix98 ptys configured
....
Mar 19 09:40:36 nextgeneration kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Mar 19 09:40:36 nextgeneration kernel: agpgart: Maximum main memory to use for agp memory: 816M
Mar 19 09:40:36 nextgeneration kernel: agpgart: Detected Intel 440GX chipset
Mar 19 09:40:36 nextgeneration kernel: agpgart: AGP aperture is 256M @ 0xe0000000
Mar 19 09:40:36 nextgeneration kernel: SCSI subsystem driver Revision: 1.00
Mar 19 09:40:36 nextgeneration kernel: scsi0 : IBM PCI ServeRAID 4.80.26  <ServeRAID 4L>

Mar 19 09:40:59 nextgeneration kernel: Unable to handle kernel paging request<1>Unable to handle kernel paging request at virt
ual address f88af200
Mar 19 09:40:59 nextgeneration kernel:  printing eip:
Mar 19 09:40:59 nextgeneration kernel: c01eb061
Mar 19 09:40:59 nextgeneration kernel: *pde = 37ecc067
Mar 19 09:40:59 nextgeneration kernel: *pte = 00000000
Mar 19 09:40:59 nextgeneration kernel: Oops: 0002
Mar 19 09:40:59 nextgeneration kernel: CPU:    0
Mar 19 09:40:59 nextgeneration kernel: EIP:    0010:[fbcon_cfb8_putcs+429/712]    Not tainted
Mar 19 09:40:59 nextgeneration kernel: EFLAGS: 00010202
Mar 19 09:40:59 nextgeneration kernel: eax: 00000707   ebx: c02af4d4   ecx: 0000000b   edx: 0000000c
Mar 19 09:40:59 nextgeneration kernel: esi: f88af200   edi: c02b03a0   ebp: 00000000   esp: f7805be4
Mar 19 09:40:59 nextgeneration kernel: ds: 0018   es: 0018   ss: 0018
Mar 19 09:40:59 nextgeneration kernel: Process more (pid: 176, stackpage=f7805000)
Mar 19 09:40:59 nextgeneration kernel: Stack: c02b03e0 c0324700 0000001d 00000001 f88ae808 00000024 07070707 00000280
Mar 19 09:40:59 nextgeneration kernel:        f88ae800 c01e3a5c c2009000 c0324700 f7ec1222 00000026 00000033 00000000
Mar 19 09:40:59 nextgeneration kernel:        f7ec1220 00000026 00000000 00000026 c0190170 c2009000 f7ec1220 00000026
Mar 19 09:40:59 nextgeneration kernel: Call Trace: [fbcon_putcs+184/208] [vt_console_print+648/736] [__call_console_drivers+58/76] [_call_console_drivers+83/88] [call_console_drivers+209/216]
Mar 19 09:40:59 nextgeneration kernel:    [release_console_sem+50/124] [printk+261/280] [do_page_fault+0/1164] [do_page_fault+706/1164] [do_page_fault+0/1164] [update_wall_time+11/52]
Mar 19 09:40:59 nextgeneration kernel:    [timer_bh+36/604] [do_timer+63/108] [timer_interrupt+110/232] [bh_action+26/64] [tasklet_hi_action+68/100] [do_softirq+90/164]
Mar 19 09:40:59 nextgeneration kernel:    [do_IRQ+150/168] [error_code+52/60] [fbcon_cfb8_clear+132/200] [fbcon_clear+362/392]  [fbcon_scroll+2407/2588] [scrup+107/260]
Mar 19 09:40:59 nextgeneration kernel:    [set_cursor+110/128] [lf+52/100] [do_con_trol+382/3260] [do_con_write+1464/1656] [con_put_char+45/52] [opost+428/440]
Mar 19 09:40:59 nextgeneration kernel:    [write_chan+353/532] [tty_write+400/512] [write_chan+0/532] [sys_write+146/224] [system_call+51/56]
Mar 19 09:40:59 nextgeneration kernel:
Mar 19 09:40:59 nextgeneration kernel: Code: 89 06 8a 03 24 0f 0f b6 d0 8b 44 24 18 23 04 97 31 e8 89 46
Mar 19 09:40:59 nextgeneration kernel:  <1>Unable to handle kernel paging request at virtual address f88b1000
Mar 19 09:40:59 nextgeneration kernel:  printing eip:
Mar 19 09:40:59 nextgeneration kernel: c01eac2c
Mar 19 09:40:59 nextgeneration kernel: *pde = 37ecc067
Mar 19 09:40:59 nextgeneration kernel: *pte = 00000000
Mar 19 09:40:59 nextgeneration kernel: Oops: 0002
Mar 19 09:40:59 nextgeneration kernel: CPU:    0
Mar 19 09:40:59 nextgeneration kernel: EIP:    0010:[fbcon_cfb8_clear+132/200]    Not tainted
Mar 19 09:40:59 nextgeneration kernel: EFLAGS: 00010246

