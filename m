Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263444AbTC2Rne>; Sat, 29 Mar 2003 12:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263446AbTC2Rne>; Sat, 29 Mar 2003 12:43:34 -0500
Received: from ns.tasking.nl ([195.193.207.2]:47621 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S263444AbTC2Rnb>;
	Sat, 29 Mar 2003 12:43:31 -0500
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: dicks@altium.nl (Dick Streefland)
Subject: [2.5.66] Oops in bttv driver
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <1071.3e85dd92.989cd@altium.nl>
Date: Sat, 29 Mar 2003 17:53:22 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to upgrade from 2.4.20 to 2.5.66, but got a kernel panic during
the initialization of the bttv driver. I captured the oops via a serial
console:

Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is Intel Corp. 440BX/ZX/DX - 82443B
bttv: Host bridge needs ETBF enabled.
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 2) at 00:10.0, irq: 17, latency: 32, mmio: 0xec100000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: enabling ETBF (430FX/VP3 compatibilty)
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=61344, tuner=Philips FM1216 (5), radio=yes
bttv0: using tuner=5
bttv0: i2c: checking for MSP34xx @ 0x80... found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
 printing eip:
c0210544
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c0210544>]    Not tainted
EFLAGS: 00010206
eax: 00000001   ebx: 0000005c   ecx: ffffffff   edx: c04c3e20
esi: c04ff694   edi: c04ff6e8   ebp: c04ff6d8   esp: dbf8ff74
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dbf8e000 task=dbf8c040)
Stack: c04ff6d8 c021030d 0000005c c04ff6d8 c02104a3 c04ff6d8 fffffffc c027e29b 
       c04ff6d8 c04ff684 c04ff680 c051b720 00000000 c027e6ac c04ff6b8 c032b098 
       c04ff6b8 c054d8e4 00000000 00000000 00000000 c051b720 c02abbea c04ff680 
Call Trace: [<c021030d>]  [<c02104a3>]  [<c027e29b>]  [<c027e6ac>]  [<c032b098>]  [<c02abbea>]  [<c01050bf>]  [<c0105064>]  [<c01088e1>] 
Code: 8b 43 10 85 c0 7e 06 f0 ff 43 10 eb 02 31 db c6 05 20 3e 4c 
 <0>Kernel panic: Attempted to kill init!

This machine is a dual P3 system. The output of ksymoops:

>>EIP; c0210544 <kobject_get+34/64>   <=====

>>ecx; ffffffff <TSS_ESP0_OFFSET+1fb/????>
>>edx; c04c3e20 <kobj_lock+0/20>
>>esi; c04ff694 <driver+14/c0>
>>edi; c04ff6e8 <driver+68/c0>
>>ebp; c04ff6d8 <driver+58/c0>
>>esp; dbf8ff74 <_end+1ba05970/3fa75800>

Trace; c021030d <kobject_init+25/40>
Trace; c02104a3 <kobject_register+f/4c>
Trace; c027e29b <bus_add_driver+4f/d8>
Trace; c027e6ac <driver_register+34/38>
Trace; c032b098 <i2c_add_driver+bc/104>
Trace; c02abbea <msp3400_init_module+a/10>
Trace; c01050bf <init+5b/1ac>
Trace; c0105064 <init+0/1ac>
Trace; c01088e1 <kernel_thread_helper+5/c>

Code;  c0210544 <kobject_get+34/64>
00000000 <_EIP>:
Code;  c0210544 <kobject_get+34/64>   <=====
   0:   8b 43 10                  mov    0x10(%ebx),%eax   <=====
Code;  c0210547 <kobject_get+37/64>
   3:   85 c0                     test   %eax,%eax
Code;  c0210549 <kobject_get+39/64>
   5:   7e 06                     jle    d <_EIP+0xd>
Code;  c021054b <kobject_get+3b/64>
   7:   f0 ff 43 10               lock incl 0x10(%ebx)
Code;  c021054f <kobject_get+3f/64>
   b:   eb 02                     jmp    f <_EIP+0xf>
Code;  c0210551 <kobject_get+41/64>
   d:   31 db                     xor    %ebx,%ebx
Code;  c0210553 <kobject_get+43/64>
   f:   c6 05 20 3e 4c 00 00      movb   $0x0,0x4c3e20

Output of the ver_linux script:

Linux zaphod 2.4.20 #1 SMP Sat Nov 30 15:08:53 CET 2002 i686 Pentium III (Katmai) GenuineIntel GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.10
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2
Modules Loaded         

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------

