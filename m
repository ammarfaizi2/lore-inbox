Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbQLJSPF>; Sun, 10 Dec 2000 13:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbQLJSOz>; Sun, 10 Dec 2000 13:14:55 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:37132 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S131483AbQLJSOt>; Sun, 10 Dec 2000 13:14:49 -0500
Date: Sun, 10 Dec 2000 17:44:06 +0000 (GMT)
From: Tim <tim@parrswood.manchester.sch.uk>
To: linux-kernel@vger.kernel.org
Subject: Oops in test11, test11-ac4 and test12-pre4/7
Message-ID: <Pine.LNX.4.21.0012101742020.3920-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Runing "modprobe megaraid" triggers this:

Dec 10 17:08:08 oxygen kernel: megaraid: v107 (December 22, 1999)
Dec 10 17:08:08 oxygen kernel: megaraid: found 0x101e:0x9010: in 00:0c.0
Dec 10 17:08:08 oxygen kernel: scsi0 : Found a MegaRAID controller at 0xe010, IRQ: 16
Dec 10 17:08:08 oxygen kernel: megaraid: Couldn't register I/O range!

Running "cat /proc/ioports" afterwards triggers this:

Dec 10 17:08:24 oxygen kernel: Unable to handle kernel paging request at virtual address d08925b7
Dec 10 17:08:24 oxygen kernel:  printing eip:
Dec 10 17:08:24 oxygen kernel: c022b1e6
Dec 10 17:08:24 oxygen kernel: *pde = 0ff1c063
Dec 10 17:08:24 oxygen kernel: *pte = 00000000
Dec 10 17:08:24 oxygen kernel: Oops: 0000
Dec 10 17:08:24 oxygen kernel: CPU:    0
Dec 10 17:08:24 oxygen kernel: EIP:    0010:[vsprintf+494/988]
Dec 10 17:08:24 oxygen kernel: EFLAGS: 00010297
Dec 10 17:08:24 oxygen kernel: eax: d08925b7   ebx: ffffffff ecx: d08925b7 edx: fffffffe
Dec 10 17:08:24 oxygen kernel: esi: ffffffff   edi: cd9b02f1 ebp: cda1dee8 esp: cda1de9c
Dec 10 17:08:24 oxygen kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 17:08:24 oxygen kernel: Process cat (pid: 1114, stackpage=cda1d000)
Dec 10 17:08:24 oxygen kernel: Stack: d08925b7 cd9b02e3 ce42dd00 00000006 0000004e c0240073 00000000 00000000
Dec 10 17:08:24 oxygen kernel:        0000000a c022b3e8 cd9b02e3 c0240058 cda1dedc c011ee9d cd9b02e3 c0240047
Dec 10 17:08:24 oxygen kernel:        0000e010 0000e01f d08925b7 c147f614 cd9b02e3 c147f454 00000008 c011eebe
Dec 10 17:08:24 oxygen kernel: Call Trace: [<d08925b7>] [call_spurious_interrupt+33951/35940] [sprintf+20/28] [call_spurious_interrupt+33924/35940] [do_resource_list+77/132] [call_spurious_interrupt+33907/35940] [<d08925b7>]
Dec 10 17:08:24 oxygen kernel:        [do_resource_list+110/132] [call_spurious_interrupt+33901/35940] [get_resource_list+64/80] [call_spurious_interrupt+33901/35940] [ioports_read_proc+36/60] [proc_file_read+247/464] [sys_read+146/200] [system_call+51/56]
Dec 10 17:08:24 oxygen kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 c6 8b 44 24 1c

Running "modprobe megaraid" again will hard lock the box, no messages or
sysrq

System details:
Dual PIII 650, 256Mb, software raid0 and 1 disks

lspci -vvvv on the megaraid card:
00:0c.0 Unknown mass storage controller: American Megatrends Inc. MegaRAID (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at e000 [size=128]
        Expansion ROM at ec000000 [disabled] [size=16K]

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X   
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

Catapultam habeo. Nisi pecuniam omnem mihi dabis, ad caput tuum saxum
immane mittam (For non-latiners: "I have a catapult. Give me all the
money, or I will fling an enormous rock at your head.")


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
