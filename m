Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283376AbRK2S3z>; Thu, 29 Nov 2001 13:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283379AbRK2S3q>; Thu, 29 Nov 2001 13:29:46 -0500
Received: from mplayerhq.banki.hu ([192.190.173.45]:39058 "EHLO
	mplayerhq.banki.hu") by vger.kernel.org with ESMTP
	id <S283376AbRK2S3e>; Thu, 29 Nov 2001 13:29:34 -0500
Date: Thu, 29 Nov 2001 19:37:22 +0100 (CET)
From: Szabolcs Berecz <szabi@mplayer.dev.hu>
X-X-Sender: <szabi@mplayer.dev.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.1-pre1
Message-ID: <Pine.LNX.4.33.0111291917150.14936-100000@mplayer.dev.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

here is the ksymoops output:

ksymoops 2.4.3 on i586 2.5.1-pre1.  Options used
     -v /hdc1/kernel/linux-2.5.1-pre1/vmlinux (specified)
     -k 20011128131327.ksyms (specified)
     -l 20011128131327.modules (specified)
     -o /lib/modules/2.5.1-pre1/ (default)
     -m /boot/System.map (specified)

Warning (expand_objects): object
/lib/modules/2.5.1-pre1/kernel/drivers/char/mga_vid.o for module mga_vid
has changed since load
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c019ec27>]   Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c02455a8   ebx: c8b364e0     ecx: 00000000       edx: 00000000
esi: c8b364e0   edi: 00000000     ebp: c546e3a0       esp: c5a0bf10
ds: 0018        es: 0018       ss: 0018
Process icewm (pid: 1157, stackpage=c5a0b000)
Stack: c8b364e0 c93c9980 c12851e0 c546e3a0 00000040 00000400 bffff53c
00000040
        bffff53c c018d29a bffff534 00008912 c8b364e0 c93c9980 c01b4268
c8b364e0
        c93c9980 c93c9860 c01866fe c93c9980 c93c9860 c0186bcc c93c9980
Call Trace: [<c018d29a>] [<c01b4268>] [<c01866fe>] [<c0186bcc>]
[<c012cab4>]
        [<c012bc3b>] [<c012bc87>] [<c0106b33>]
Code: 00 0f 85 4c 45 02 00 89 f6 8a 46 20 c6 46 27 03 3c 0a 75 ad

>>EIP; c019ec26 <tcp_close+3e/5bc>   <=====
Trace; c018d29a <dev_ioctl+2e/2e8>
Trace; c01b4268 <inet_release+48/50>
Trace; c01866fe <sock_release+12/50>
Trace; c0186bcc <sock_close+38/40>
Trace; c012cab4 <fput+4c/d0>
Trace; c012bc3a <filp_close+5a/64>
Trace; c012bc86 <sys_close+42/54>
Trace; c0106b32 <system_call+32/40>
Code;  c019ec26 <tcp_close+3e/5bc>
00000000 <_EIP>:
Code;  c019ec26 <tcp_close+3e/5bc>   <=====
   0:   00 0f                     add    %cl,(%edi)   <=====
Code;  c019ec28 <tcp_close+40/5bc>
   2:   85 4c 45 02               test   %ecx,0x2(%ebp,%eax,2)
Code;  c019ec2c <tcp_close+44/5bc>
   6:   00 89 f6 8a 46 20         add    %cl,0x20468af6(%ecx)
Code;  c019ec32 <tcp_close+4a/5bc>
   c:   c6 46 27 03               movb   $0x3,0x27(%esi)
Code;  c019ec36 <tcp_close+4e/5bc>
  10:   3c 0a                     cmp    $0xa,%al
Code;  c019ec38 <tcp_close+50/5bc>
  12:   75 ad                     jne    ffffffc1 <_EIP+0xffffffc1>
c019ebe6 <tcp_destroy_sock+1c6/1c8>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


I recompiled linux/net/ipv4/tcp.c with -g, and checked tcp_close(), but it
does not look like the output of ksymoops. so sorry, if you can't do
anything with this report.

I was doing nothing interesting, justplaying mp3, downloading some files.


here is the list of modules:

sg                     22692   0 (autoclean) (unused)
nls_cp437               4384   0 (autoclean)
floppy                 44896   0 (autoclean)
vfat                    9468   0 (autoclean)
fat                    29912   0 (autoclean) [vfat]
mga_vid                 7488   0 (autoclean)
snd-pcm-oss            36352   1 (autoclean)
nls_iso8859-1           2880   0 (autoclean)
sr_mod                 13496   0 (autoclean)
ide-scsi                7616   0
cdrom                  27008   0 (autoclean) [sr_mod]
scsi_mod               80216   3 (autoclean) [sg sr_mod ide-scsi]
isofs                  25024   0 (autoclean)
inflate_fs             18048   0 (autoclean) [isofs]
snd-mixer-oss           8832   0 (autoclean) [snd-pcm-oss]
agpgart                12608   2 (autoclean)
snd-card-ymfpci         3200   1
snd-ymfpci             36256   0 [snd-card-ymfpci]
snd-ac97-codec         22432   0 [snd-ymfpci]
snd-pcm                45952   0 [snd-pcm-oss snd-ymfpci]
snd-mpu401-uart         2784   0 [snd-card-ymfpci]
snd-rawmidi            11648   0 [snd-mpu401-uart]
snd-opl3                5568   0 [snd-card-ymfpci]
snd-seq-device          4016   0 [snd-rawmidi snd-opl3]
snd-timer               9280   0 [snd-pcm snd-opl3]
snd-hwdep               3680   0 [snd-opl3]
snd                    25224   0 [snd-pcm-oss snd-mixer-oss
snd-card-ymfpci snd-ymfpci snd-ac97-codec snd-pcm snd-mpu401-uart
snd-rawmidi snd-opl3 snd-seq-device snd-timer snd-hwdep]
soundcore               3844   4 [snd]
iptable_filter          1984   0 (autoclean) (unused)
ip_tables              10560   1 [iptable_filter]
reiserfs              147776   4 (autoclean)
ne2k-pci                5088   1
8390                    6144   0 [ne2k-pci]


(I don't know which module made the kernel tainted...)


Bye,
Szabi


