Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311753AbSCNUQL>; Thu, 14 Mar 2002 15:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311754AbSCNUQF>; Thu, 14 Mar 2002 15:16:05 -0500
Received: from whiterose.net ([64.65.220.94]:31750 "HELO whiterose.net")
	by vger.kernel.org with SMTP id <S311753AbSCNUPv>;
	Thu, 14 Mar 2002 15:15:51 -0500
Date: Thu, 14 Mar 2002 15:19:56 -0500 (EST)
From: M Sweger <mikesw@ns1.whiterose.net>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: linux 2.2.21 pre3, pre4 and rc1 problems. (fwd)
Message-ID: <Pine.BSF.4.21.0203141518590.18036-100000@ns1.whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



PS: Sent to invalid kml email address. This is a resend.

Hello Alan,

   I have a UMSDOS system with egcs v1.1.2 and libc 5.3.12. My hardware
is a Dell 333mhz GX1 with scsi U2W (AIC 7895) and 128 megs of memory.
I don't have any swap turned on.
Here is a list of the problems with the linux v2.2.21 pre releases:

v2.2.21pre2      boots and works ok.
v2.2.21pre3      filesystem panic after root mounted and umssync is run.
v2.2.21pre4      hangs on boot after the message
		 "Intel machine check architecture supported"

v2.2.21rc1       Oops' on boot after the message "CPU: L2 cache = 512K
                 with a kernel panic. Note: I don't have any swap turned on.

Ksymoops listing

ksymoops 2.3.3 on i686 2.2.21pre2.  Options used
     -v ./vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.2.21rc1/ (specified)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Unable to handle kernel NULL ptr dereference at virtual address 00000004
*pde = 00000000
Oops: 0000
Cpu: 0
Eip: 0010 : [<c0297244>]
Using defaults from ksymoops -t elf32-i386 -a i386
Eflags: 00010282
eax: c0273f00 ebx: c0273f06 ecx: c0275868 edx: c0273f00
esi: 00000004 edi: c0273f20 ebp: 00000200
ds: 0018 es: 0018 ss: 0018 esp: c0293f74
stack:  c0106000 0008e000 00000010 0000000c c0293f0c 00000000 000000e8 c0293fa8
        c0293fa8 00000001 00000001 00000000 00000004 03020101 00000000 00000000
        0c040843 c02973ba c0273f00 00000000 000994a2 c0106000 c0294457 c0273f00
call trace: [<c0106000>] [<c0106000>] [<c0106000>] [<c010017b>]
code: ac aa 84 c0 75 fa 5b 5e 5f 5d 83 c4 3c c3 89 f6 56 53 8b 5c

>>EIP; c0297244 <init_intel+33c/34c>   <=====
Trace; c0106000 <get_options+0/74>
Trace; c0106000 <get_options+0/74>
Trace; c0106000 <get_options+0/74>
Trace; c010017b <L6+0/2>
Code;  c0297244 <init_intel+33c/34c>
00000000 <_EIP>:
Code;  c0297244 <init_intel+33c/34c>   <=====
   0:   ac                        lodsb  %ds:(%esi),%al   <=====
Code;  c0297245 <init_intel+33d/34c>
   1:   aa                        stosb  %al,%es:(%edi)
Code;  c0297246 <init_intel+33e/34c>
   2:   84 c0                     testb  %al,%al
Code;  c0297248 <init_intel+340/34c>
   4:   75 fa                     jne    0 <_EIP>
Code;  c029724a <init_intel+342/34c>
   6:   5b                        popl   %ebx
Code;  c029724b <init_intel+343/34c>
   7:   5e                        popl   %esi
Code;  c029724c <init_intel+344/34c>
   8:   5f                        popl   %edi
Code;  c029724d <init_intel+345/34c>
   9:   5d                        popl   %ebp
Code;  c029724e <init_intel+346/34c>
   a:   83 c4 3c                  addl   $0x3c,%esp
Code;  c0297251 <init_intel+349/34c>
   d:   c3                        ret    
Code;  c0297252 <init_intel+34a/34c>
   e:   89 f6                     movl   %esi,%esi
Code;  c0297254 <table_lookup_model+0/48>
  10:   56                        pushl  %esi
Code;  c0297255 <table_lookup_model+1/48>
  11:   53                        pushl  %ebx
Code;  c0297256 <table_lookup_model+2/48>
  12:   8b 5c 00 00               movl   0x0(%eax,%eax,1),%ebx

Kernel panic: Attempted to kill the idle task!
In swapper task -- not syncing





