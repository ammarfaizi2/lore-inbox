Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130582AbQKJNCj>; Fri, 10 Nov 2000 08:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130640AbQKJNC3>; Fri, 10 Nov 2000 08:02:29 -0500
Received: from vill.ha.smisk.nu ([212.75.83.8]:31241 "HELO mail.smisk.nu")
	by vger.kernel.org with SMTP id <S130582AbQKJNCU>;
	Fri, 10 Nov 2000 08:02:20 -0500
Message-ID: <006a01c04b16$7725e5f0$020a0a0a@totalmef>
From: "Magnus Naeslund\(b\)" <mag@bahnhof.se>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Oops on 2.2.17 (and 2.2.18pre20)
Date: Fri, 10 Nov 2000 14:02:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello i got me several nasty oopses on my heavily loaded webserver.

[1.] One line summary of the problem:

I get a oops that seems to generate more oops.
My logs are full of them bastards.
I hate them. GRRR.

[2.] Full description of the problem/report:

I recently upgraded my box to 1GB of mem, and upgraded to 2.2.18pre20 +
andreas VM-Global patch.
The only thing i changed was to turn on (ip) firewall.
I then got a oops.
Thinking nothing of it i reverted to 2.2.17 (turned on firewalling there
too) thinking it was a pre20 or VM-Global problem.
Then i got this never ending oops loop.
Some parts of the system still worked (especially the part mailing me all
the oopses = 300MB of logs :)).
I wonder if has something to do with the memory?
How do i check for bad ram?
Does 1GB break something?

[3.] Keywords (i.e., modules, networking, kernel):

eepro100,firewalling,2.2.17,2.2.18pre20,SMP,1GB

[4.] Kernel version (from /proc/version):

Linux version 2.2.17 (root@gimme.smisk.nu) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #4 SMP Thu Nov 9 07:21:07 CET 2000

[5.] Output of Oops..

I have several megs of oops if anyone wants them.
Ksymoops complained about:
/usr/bin/nm: /lib/modules/2.2.17/build/arch/i386/boot/bbootsect.o: File
format not recognized
/usr/src/linux/scripts/ksymoops/ksymoops: read_nm_symbols pclose failed
0x100

and alot about stuff like this:

Warning: ksyms_base symbol EISA_bus_Rsmp_7413793a not found in System.map.
Ignoring ksyms_base entry
Warning: ksyms_base symbol MCA_bus_Rsmp_f48a2c4c not found in System.map.
Ignoring ksyms_base entry

The Oopses:
Nov 10 09:05:48 gimme kernel: current->tss.cr3 = 31f25000, %%cr3 = 31f25000
Nov 10 09:05:48 gimme kernel: *pde = 32556067
Nov 10 09:05:48 gimme kernel: Oops: 0000
Nov 10 09:05:48 gimme kernel: CPU:    1
Nov 10 09:05:48 gimme kernel: EIP:    0010:[do_follow_link+39/408]
Nov 10 09:05:48 gimme kernel: EFLAGS: 00010206
Nov 10 09:05:48 gimme kernel: eax: c9dd3e60   ebx: c9dd3e60   ecx: 000c0024
edx: eb374c00
Nov 10 09:05:48 gimme kernel: esi: c71387a0   edi: c9dd3e60   ebp: 00000001
esp: f2bcff20
Nov 10 09:05:48 gimme kernel: ds: 0018   es: 0018   ss: 0018
Nov 10 09:05:48 gimme kernel: Process postmaster (pid: 23613, process nr:
192, stackpage=f2bcf000)
Nov 10 09:05:48 gimme kernel: Stack: c60b0035 00000001 c012ff5b c71387a0
c9dd3e60 00000001 e4f362a0 ffffffe9
Nov 10 09:05:48 gimme kernel:        c60b0000 00000003 c60b001f 00000016
8bc1bd82 c01300ae c60b0000 c71387a0
Nov 10 09:05:48 gimme kernel:        00000001 e4f362a0 ffffffe9 c60b0000
00000028 f2bce000 00001000 0000002e
Nov 10 09:05:48 gimme kernel: Call Trace: [lookup_dentry+351/488]
[open_namei+114/1248] [filp_open+68/240] [sys_open+82/172]
[system_call+52/56]
Nov 10 09:05:48 gimme kernel: Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78
2c 00 0f 84 4a 01 00
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78 2c 00 0f 84 4a 01 00
'
  Garbage: '  '

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    8b 41 64
movl   0x64(%ecx),%eax <===
Code:  00000003 Before first symbol               3:    85 c0
testl  %eax,%eax
Code:  00000005 Before first symbol               5:    0f 84 54 01 00 00
je      0000015f Before first symbol
Code:  0000000b Before first symbol               b:    83 78 2c 00
cmpl   $0x0,0x2c(%eax)
Code:  0000000f Before first symbol               f:    0f 84 4a 01 00 00
je      0000015f Before first symbol

Nov 10 09:05:48 gimme kernel: Unable to handle kernel paging request at
virtual address 000c0088
Nov 10 09:05:48 gimme kernel: current->tss.cr3 = 324ea000, %%cr3 = 324ea000
Nov 10 09:05:48 gimme kernel: *pde = 2f89c067
Nov 10 09:05:48 gimme kernel: Oops: 0000
Nov 10 09:05:48 gimme kernel: CPU:    0
Nov 10 09:05:48 gimme kernel: EIP:    0010:[do_follow_link+39/408]
Nov 10 09:05:48 gimme kernel: EFLAGS: 00010206
Nov 10 09:05:48 gimme kernel: eax: c9dd3e60   ebx: c9dd3e60   ecx: 000c0024
edx: eb374c00
Nov 10 09:05:48 gimme kernel: esi: c71387a0   edi: c9dd3e60   ebp: 00000001
esp: f2bcff20
Nov 10 09:05:48 gimme kernel: ds: 0018   es: 0018   ss: 0018
Nov 10 09:05:48 gimme kernel: Process postmaster (pid: 23615, process nr:
192, stackpage=f2bcf000)
Nov 10 09:05:48 gimme kernel: Stack: c77d7035 00000001 c012ff5b c71387a0
c9dd3e60 00000001 c329d1e0 ffffffe9
Nov 10 09:05:48 gimme kernel:        c77d7000 00000003 c77d701f 00000016
8bc1bd82 c01300ae c77d7000 c71387a0
Nov 10 09:05:48 gimme kernel:        00000001 c329d1e0 ffffffe9 c77d7000
00000028 f2bce000 00001000 0000002e
Nov 10 09:05:48 gimme kernel: Call Trace: [lookup_dentry+351/488]
[open_namei+114/1248] [filp_open+68/240] [sys_open+82/172]
[system_call+52/56]
Nov 10 09:05:48 gimme kernel: Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78
2c 00 0f 84 4a 01 00
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78 2c 00 0f 84 4a 01 00
'
  Garbage: '  '

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    8b 41 64
movl   0x64(%ecx),%eax <===
Code:  00000003 Before first symbol               3:    85 c0
testl  %eax,%eax
Code:  00000005 Before first symbol               5:    0f 84 54 01 00 00
je      0000015f Before first symbol
Code:  0000000b Before first symbol               b:    83 78 2c 00
cmpl   $0x0,0x2c(%eax)
Code:  0000000f Before first symbol               f:    0f 84 4a 01 00 00
je      0000015f Before first symbol

Nov 10 09:05:50 gimme kernel: Unable to handle kernel paging request at
virtual address 000c0088
Nov 10 09:05:50 gimme kernel: current->tss.cr3 = 07699000, %%cr3 = 07699000
Nov 10 09:05:50 gimme kernel: *pde = 32d08067
Nov 10 09:05:50 gimme kernel: Oops: 0000
Nov 10 09:05:50 gimme kernel: CPU:    1
Nov 10 09:05:50 gimme kernel: EIP:    0010:[do_follow_link+39/408]
Nov 10 09:05:50 gimme kernel: EFLAGS: 00010206
Nov 10 09:05:50 gimme kernel: eax: c9dd3e60   ebx: c9dd3e60   ecx: 000c0024
edx: eb374c00
Nov 10 09:05:50 gimme kernel: esi: c71387a0   edi: c9dd3e60   ebp: 00000001
esp: f26a5f20
Nov 10 09:05:50 gimme kernel: ds: 0018   es: 0018   ss: 0018
Nov 10 09:05:50 gimme kernel: Process postmaster (pid: 23621, process nr:
133, stackpage=f26a5000)
Nov 10 09:05:50 gimme kernel: Stack: f2970035 00000001 c012ff5b c71387a0
c9dd3e60 00000001 c7ea2200 ffffffe9
Nov 10 09:05:50 gimme kernel:        f2970000 00000003 f297001f 00000016
8bc1bd82 c01300ae f2970000 c71387a0
Nov 10 09:05:50 gimme kernel:        00000001 c7ea2200 ffffffe9 f2970000
00000028 f26a4000 00001000 0000002e
Nov 10 09:05:50 gimme kernel: Call Trace: [lookup_dentry+351/488]
[open_namei+114/1248] [filp_open+68/240] [sys_open+82/172]
[system_call+52/56]
Nov 10 09:05:50 gimme kernel: Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78
2c 00 0f 84 4a 01 00
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78 2c 00 0f 84 4a 01 00
'
  Garbage: '  '

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    8b 41 64
movl   0x64(%ecx),%eax <===
Code:  00000003 Before first symbol               3:    85 c0
testl  %eax,%eax
Code:  00000005 Before first symbol               5:    0f 84 54 01 00 00
je      0000015f Before first symbol
Code:  0000000b Before first symbol               b:    83 78 2c 00
cmpl   $0x0,0x2c(%eax)
Code:  0000000f Before first symbol               f:    0f 84 4a 01 00 00
je      0000015f Before first symbol

Nov 10 09:05:50 gimme kernel: Unable to handle kernel paging request at
virtual address 000c0088
Nov 10 09:05:50 gimme kernel: current->tss.cr3 = 05b93000, %%cr3 = 05b93000
Nov 10 09:05:50 gimme kernel: *pde = 32cd9067
Nov 10 09:05:50 gimme kernel: Oops: 0000
Nov 10 09:05:50 gimme kernel: CPU:    0
Nov 10 09:05:50 gimme kernel: EIP:    0010:[do_follow_link+39/408]
Nov 10 09:05:50 gimme kernel: EFLAGS: 00010206
Nov 10 09:05:50 gimme kernel: eax: c9dd3e60   ebx: c9dd3e60   ecx: 000c0024
edx: eb374c00
Nov 10 09:05:50 gimme kernel: esi: c71387a0   edi: c9dd3e60   ebp: 00000001
esp: f26a5f20
Nov 10 09:05:50 gimme kernel: ds: 0018   es: 0018   ss: 0018
Nov 10 09:05:50 gimme kernel: Process postmaster (pid: 23623, process nr:
133, stackpage=f26a5000)
Nov 10 09:05:50 gimme kernel: Stack: f290a035 00000001 c012ff5b c71387a0
c9dd3e60 00000001 ef9b20e0 ffffffe9
Nov 10 09:05:50 gimme kernel:        f290a000 00000003 f290a01f 00000016
8bc1bd82 c01300ae f290a000 c71387a0
Nov 10 09:05:50 gimme kernel:        00000001 ef9b20e0 ffffffe9 f290a000
00000028 f26a4000 00001000 0000002e
Nov 10 09:05:50 gimme kernel: Call Trace: [lookup_dentry+351/488]
[open_namei+114/1248] [filp_open+68/240] [sys_open+82/172]
[system_call+52/56]
Nov 10 09:05:50 gimme kernel: Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78
2c 00 0f 84 4a 01 00
Warning: trailing garbage ignored on Code: line
  Text: 'Code: 8b 41 64 85 c0 0f 84 54 01 00 00 83 78 2c 00 0f 84 4a 01 00
'
  Garbage: '  '

Code:  00000000 Before first symbol            00000000 <_IP>: <===
Code:  00000000 Before first symbol               0:    8b 41 64
movl   0x64(%ecx),%eax <===
Code:  00000003 Before first symbol               3:    85 c0
testl  %eax,%eax
Code:  00000005 Before first symbol               5:    0f 84 54 01 00 00
je      0000015f Before first symbol
Code:  0000000b Before first symbol               b:    83 78 2c 00
cmpl   $0x0,0x2c(%eax)
Code:  0000000f Before first symbol               f:    0f 84 4a 01 00 00
je      0000015f Before first symbol

[7.] Environment

HOSTNAME=gimme.smisk.nu
RESIN_HOME=/opt/resin
HISTFILESIZE=0
CLASSPATH=/usr/lib/java/jre/lib/rt.jar:.
LESSKEY=/etc/.less
PS1=[\u@\h \W]\$
ENV=/root/.bashrc
LESS=-MM
USER=root
LS_COLORS=no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;
33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=0
1;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.tbz2=01;31:*.arc=01;3
1:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lha=01;31:*.zip=01;31:*.z=01;31:*.Z=
01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.jpg=01;35:*
.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.ti
f=01;35:*.tiff=01;35:
MACHTYPE=i586-mandrake-linux-gnu
THREADS_FLAG=green
MAIL=/var/spool/mail/root
JAVA_COMPILER=javacomp
INPUTRC=/etc/inputrc
EDITOR=jed
JAVAHOME=/usr/lib/java
SSH_CLIENT=212.75.83.17 62252 22
LOGNAME=root
SHLVL=1
SHELL=/bin/bash
USERNAME=root
HOSTTYPE=i586
OSTYPE=linux-gnu
HISTSIZE=1000
HOME=/root
TERM=ansi
PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/lib/java/bin:/usr/bin:/bin:/usr/bin:
/usr/lib/java/bin:/usr/local/bin:/usr/local/sbin
SSH_TTY=/dev/pts/4
_=/usr/bin/env
OLDPWD=/usr/src/linux

[7.1.] Software (add the output of the ver_linux script here)

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux gimme.smisk.nu 2.2.17 #4 SMP Thu Nov 9 07:21:07 CET 2000 i686 unknown
Kernel modules         2.3.10-pre1
Gnu C                  egcs-2.91.66
Binutils               2.9.1.0.25
Linux C Library        2.1.2
Dynamic linker         ldd (GNU libc) 2.1.2
Procps                 2.0.2
Mount                  2.9w
Net-tools              1.52
Console-tools          0.2.0
Sh-utils               2.0
Modules Loaded         eepro100

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.147
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 501.147
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr xmm
bogomips        : 999.42

[7.3.] Module information (from /proc/modules):

eepro100               16656   1 (autoclean)

[7.4.] SCSI information (from /proc/scsi/scsi)

[root@gimme scripts]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST318451LW       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST318451LW       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03

[root@gimme scripts]# cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 5.1.31/3.2.4
Compile Options:
  TCQ Enabled By Default : Enabled
  AIC7XXX_PROC_STATS     : Disabled
  AIC7XXX_RESET_DELAY    : 5

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7890/1 Ultra2 SCSI host adapter
                           Ultra-2 LVD/SE Wide Controller at PCI 0/6/0
    PCI MMAPed I/O Base: 0xe1000000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 7
                   SCBs: Active 0, Max Active 44,
                         Allocated 75, HW 32, Page 255
             Interrupts: 2866085
      BIOS Control Word: 0x10a4
   Adapter Control Word: 0x1c5e
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x001b
Ordered Queue Tag Flags: 0x001b
Default Tag Queue Depth: 16
    Tagged Queue By Device array for aic7xxx host instance 0:
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    Actual queue depth per device for aic7xxx host instance 0:
      {16,16,1,16,16,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:0:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 31
  Transinfo settings: current(10/31/1/0), goal(10/127/1/0), user(10/127/1/0)
  Total transfers 35374 (9715 reads and 25659 writes)


(scsi0:0:1:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 63
  Transinfo settings: current(10/63/1/0), goal(10/127/1/0), user(10/127/1/0)
  Total transfers 2796285 (36205 reads and 2760080 writes)


(scsi0:0:3:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 63
  Transinfo settings: current(10/63/1/0), goal(10/127/1/0), user(10/127/1/0)
  Total transfers 16875 (357 reads and 16518 writes)


(scsi0:0:4:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 31
  Transinfo settings: current(10/31/1/0), goal(10/127/1/0), user(10/127/1/0)
  Total transfers 17584 (16956 reads and 628 writes)



Tell me if i can assist any more...


Magnus Naeslund

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
