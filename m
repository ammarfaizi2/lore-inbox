Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313415AbSDYUrp>; Thu, 25 Apr 2002 16:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSDYUro>; Thu, 25 Apr 2002 16:47:44 -0400
Received: from mx0.gmx.de ([213.165.64.100]:19042 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S313415AbSDYUrn>;
	Thu, 25 Apr 2002 16:47:43 -0400
Date: Thu, 25 Apr 2002 22:47:37 +0200 (MEST)
From: gjwucherpfennig@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary41751019767657"
Subject: Kernel panic while booting on a P2 with linux-2.5.10
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008922711@gmx.net
X-Authenticated-IP: [145.254.146.57]
Message-ID: <4175.1019767657@www13.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary41751019767657
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 (my previous email got damaged, I think a KMail cvs-head bug) 
 
Please CC me, because I'm not subscribed to linux kernel any more ... 
 
This is my first real (log piped through ksymoops) kernel oops report, 
so I hope it's helpful ... 
 
It would be great if someone would set up an automated stress tester that 
will test each kernel before release, so that kernel developers and bug 
hunters can concentrate on the really important issues. 
 
Kernel 2.5.10 is the first 2.5 vanilla kerneI that compiles on my machine 
since 2.5.4 and this PC is a quite usual one :-((  
Pentium2 266MHz, 
Intel 440LX Chipset, Gigabyte mainboard, 
Advansys SCSI OEM card (bundled with TEAC8x burner) 
nVidia riva128 graphic card 4MB RAM, 
8GB IDE HDD, 
USB ACM modem, USB scanner, ... 
 
Each time I try to boot kernel 2.5.10 I get this kernel oops  
(see attachment). The kernel is a monolitic one without modules. 
 
It took me > 1h to write down the oops log but here it is :-) 
 
 
The ksymoops output:  
 
[root@localhost ~]# ksymoops -v /usr/src/linux/vmlinux -m
/boot/System.map-2.5.10 -K -L -O oops 
ksymoops 2.4.1 on i686 2.4.17.  Options used 
     -v /usr/src/linux/vmlinux (specified) 
     -K (specified) 
     -L (specified) 
     -O (specified) 
     -m /boot/System.map-2.5.10 (specified) 
 
c01b6076 
Oops: 0002 
CPU:    0 
EFLAGS: 00010002 
eax: 00000004   ebx: c13f3e94   ecx: c02a0b54   edx: 00000000 
esi: c13f3dfc   edi: c031b28c   ebp: c13dbe48 
ds: 0018   es:0018   ss: 0018 
Stack: 00000001 00000018 c13f3dfc c031b28c 00000003 c01b9f41 c031b28c
00000001 
       00000000 c01c1d83 c031b28c 00000001 00000000 00000000 00000000
00000051 
       00000000 c031b28c c13c52c0 c13da000 c01b7e5d c031b28c c01c1cb0
c031b198 
Call Trace: [<c01b9f41>] [<c01c1d83>] [<c01b7e5d>] [<c01c1cb0>] [<c010856a>]

[<c0108761>] [<c010728e>] [<c0110018>] [<c011139e>] [<c0111446>]
[<c01116a0>] 
[<c0111d4d>] [<c0111e5d>] [<c01127ad>] [<c0105000>] [<c0150018>]
[<c0105000>] 
[<c0105676>] [<c0112510>] 
Code: c7 04 90 00 00 00 00 8b 53 0c 8b 87 34 02 00 00 0f b3 10 8b 
Using defaults from ksymoops -t elf32-i386 -a i386 
 
Trace; c01b9f41 <ide_end_request+11/20> 
Trace; c01c1d83 <cdrom_pc_intr+d3/1e0> 
Trace; c01b7e5d <ide_intr+ed/1a0> 
Trace; c01c1cb0 <cdrom_pc_intr+0/1e0> 
Trace; c010856a <handle_IRQ_event+3a/70> 
Trace; c0108761 <do_IRQ+91/f0> 
Trace; c010728e <common_interrupt+22/28> 
Trace; c0110018 <mtrr_add_page+2c8/370> 
Trace; c011139e <apm_bios_call+6e/80> 
Trace; c0111446 <apm_get_event+26/70> 
Trace; c01116a0 <apm_cpu_idle+130/140> 
Trace; c0111d4d <check_events+16d/180> 
Trace; c0111e5d <apm_mainloop+7d/b0> 
Trace; c01127ad <apm+29d/2b0> 
Trace; c0105000 <_stext+0/0> 
Trace; c0150018 <elf_core_dump+1e8/a06> 
Trace; c0105000 <_stext+0/0> 
Trace; c0105676 <kernel_thread+26/30> 
Trace; c0112510 <apm+0/2b0> 
Code;  00000000 Before first symbol 
00000000 <_EIP>: 
Code;  00000000 Before first symbol 
   0:   c7 04 90 00 00 00 00      movl   $0x0,(%eax,%edx,4) 
Code;  00000007 Before first symbol 
   7:   8b 53 0c                  mov    0xc(%ebx),%edx 
Code;  0000000a Before first symbol 
   a:   8b 87 34 02 00 00         mov    0x234(%edi),%eax 
Code;  00000010 Before first symbol 
  10:   0f b3 10                  btr    %edx,(%eax) 
Code;  00000013 Before first symbol 
  13:   8b 00                     mov    (%eax),%eax 
 
<0>Kernel panic: Aieee, killing interrupt handler! 
[root@localhost ~]# 
 
 
 
 

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net
--========GMXBoundary41751019767657
Content-Type: text/plain; name="oops"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="oops"

IHByaW50aW5nIGVpcDoKYzAxYjYwNzYKKnBkZT0wMDAwMDAwMApPb3BzOiAwMDAyCkNQVTogICAg
MApFSVA6MDAxMDogWzxjMDFiNjA3Yj5dICAgIE5vdCB0YWludGVkCkVGTEFHUzogMDAwMTAwMDIK
ZWF4OiAwMDAwMDAwNCAgIGVieDogYzEzZjNlOTQgICBlY3g6IGMwMmEwYjU0ICAgZWR4OiAwMDAw
MDAwMAplc2k6IGMxM2YzZGZjICAgZWRpOiBjMDMxYjI4YyAgIGVicDogYzEzZGJlNDgKZHM6IDAw
MTggICBlczowMDE4ICAgc3M6IDAwMTgKUHJvY2VzcyBrYXBtZCAocGlkOiA0LCB0aHJlYWRpbmZv
PWMxM2RhMDAwIHRhc2s9YzEzZjExODApClN0YWNrOiAwMDAwMDAwMSAwMDAwMDAxOCBjMTNmM2Rm
YyBjMDMxYjI4YyAwMDAwMDAwMyBjMDFiOWY0MSBjMDMxYjI4YyAwMDAwMDAwMQogICAgICAgMDAw
MDAwMDAgYzAxYzFkODMgYzAzMWIyOGMgMDAwMDAwMDEgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwNTEKICAgICAgIDAwMDAwMDAwIGMwMzFiMjhjIGMxM2M1MmMwIGMxM2RhMDAwIGMw
MWI3ZTVkIGMwMzFiMjhjIGMwMWMxY2IwIGMwMzFiMTk4CkNhbGwgVHJhY2U6IFs8YzAxYjlmNDE+
XSBbPGMwMWMxZDgzPl0gWzxjMDFiN2U1ZD5dIFs8YzAxYzFjYjA+XSBbPGMwMTA4NTZhPl0KWzxj
MDEwODc2MT5dIFs8YzAxMDcyOGU+XSBbPGMwMTEwMDE4Pl0gWzxjMDExMTM5ZT5dIFs8YzAxMTE0
NDY+XSBbPGMwMTExNmEwPl0KWzxjMDExMWQ0ZD5dIFs8YzAxMTFlNWQ+XSBbPGMwMTEyN2FkPl0g
WzxjMDEwNTAwMD5dIFs8YzAxNTAwMTg+XSBbPGMwMTA1MDAwPl0KWzxjMDEwNTY3Nj5dIFs8YzAx
MTI1MTA+XQpDb2RlOiBjNyAwNCA5MCAwMCAwMCAwMCAwMCA4YiA1MyAwYyA4YiA4NyAzNCAwMiAw
MCAwMCAwZiBiMyAxMCA4Ygo8MD5LZXJuZWwgcGFuaWM6IEFpZWVlLCBraWxsaW5nIGludGVycnVw
dCBoYW5kbGVyIQpJbiBpbnRlcnJ1cHQgaGFuZGxlciAtIG5vdCBzeW5jaW5nCg==
--========GMXBoundary41751019767657--

