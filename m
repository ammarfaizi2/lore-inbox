Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132655AbRAXSdP>; Wed, 24 Jan 2001 13:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132446AbRAXSdG>; Wed, 24 Jan 2001 13:33:06 -0500
Received: from arthur.runestig.com ([195.67.47.226]:37906 "EHLO
	arthur.runestig.com") by vger.kernel.org with ESMTP
	id <S132566AbRAXScz>; Wed, 24 Jan 2001 13:32:55 -0500
Message-ID: <003c01c08633$9839c1f0$0201010a@runestig.com>
From: "Peter 'Luna' Runestig" <peter@runestig.com>
To: "Linux Kernel Mailing list" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: 2.2.19pre7 opps on low mem machine
Date: Wed, 24 Jan 2001 19:29:31 +0100
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

[1.] One line summary of the problem:
Oops with 2.2.19pre7 on memory stressed, old PC.

[2.] Full description of the problem/report:
An old 486/66 with 20 Meg memory runs a a firewall at home. Probably runs
too much for that amount of memory (sendmail, bind, ntpd and FreeSWAN VPN),
but I can't find any more memory modules! I have gotten four or five oops
the last week or so (in different processes), running 2.2.18. Stepped up to
2.2.19pre7 and hooked up a serial console two days ago, now I got one again.

[4.] Kernel version (from /proc/version):
Linux version 2.2.19pre7 (root@r2.runestig.com) (gcc version 2.95.2 19991024
(release)) #1 Mon Jan 22 11:57:12 CET 2001

[5.] Output of Oops.. message (if applicable) with symbolic information
ksymoops 2.3.7 on i486 2.2.19pre7.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19pre7/ (default)
     -m /boot/System.map-2.2.19pre7 (default)

Warning (compare_maps): mismatch on symbol zeroes  , ipsec says c184aba0,
/lib/modules/2.2.19pre7-freeswan-1.8-lunix/misc/ipsec.o says c184a9
a0.  Ignoring /lib/modules/2.2.19pre7-freeswan-1.8-lunix/misc/ipsec.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000004
current->tss.cr3 = 00c6f000, %cr3 = 00c6f000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01314a1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010003
eax: 00000008   ebx: 410c8080   ecx: 00000000   edx: 00000000
esi: 410c807c   edi: c10c8000   ebp: 00000203   esp: c0f8beec
ds: 0018   es: 0018   ss: 0018
Process named (pid: 436, process nr: 7, stackpage=c0f8b000)
Stack: 02000000 0000001a 00000004 00000000 00000000 c01317e3 c10c8000
00000000
       0000001a c01317b5 00000001 00000004 c13e59f8 00000000 00000001
00000001
       c0f8bf4c c0f8a000 c0f8a000 00006986 00000000 c10c8000 00000001
00000000
Call Trace: [<c01317e3>] [<c01317b5>] [<c0131b79>] [<c0119910>] [<c010a4e4>]
Code: 8b 41 04 39 d8 74 09 89 c2 8b 42 04 39 d8 75 f7 89 4a 04 55

>>EIP; c01314a1 <free_wait+31/80>   <=====
Trace; c01317e3 <do_select+1e3/200>
Trace; c01317b5 <do_select+1b5/200>
Trace; c0131b79 <sys_select+379/4b0>
Trace; c0119910 <sys_gettimeofday+20/a0>
Trace; c010a4e4 <system_call+34/40>
Code;  c01314a1 <free_wait+31/80>
00000000 <_EIP>:
Code;  c01314a1 <free_wait+31/80>   <=====
   0:   8b 41 04                  movl   0x4(%ecx),%eax   <=====
Code;  c01314a4 <free_wait+34/80>
   3:   39 d8                     cmpl   %ebx,%eax
Code;  c01314a6 <free_wait+36/80>
   5:   74 09                     je     10 <_EIP+0x10> c01314b1
<free_wait+41/80>
Code;  c01314a8 <free_wait+38/80>
   7:   89 c2                     movl   %eax,%edx
Code;  c01314aa <free_wait+3a/80>
   9:   8b 42 04                  movl   0x4(%edx),%eax
Code;  c01314ad <free_wait+3d/80>
   c:   39 d8                     cmpl   %ebx,%eax
Code;  c01314af <free_wait+3f/80>
   e:   75 f7                     jne    7 <_EIP+0x7> c01314a8
<free_wait+38/80>
Code;  c01314b1 <free_wait+41/80>
  10:   89 4a 04                  movl   %ecx,0x4(%edx)
Code;  c01314b4 <free_wait+44/80>
  13:   55                        pushl  %ebp

1 warning issued.  Results may not be reliable.

[7.] Environment
BASH=/bin/bash
BASH_VERSINFO=([0]="2" [1]="03" [2]="0" [3]="1" [4]="release"
[5]="i486-pc-linux-gnu")
BASH_VERSION='2.03.0(1)-release'
CC=gcc
COLUMNS=141
DIRSTACK=()
ENV=/root/.bashrc
EUID=0
GROUPS=()
HISTFILE=/root/.bash_history
HISTFILESIZE=1000
HISTSIZE=1000
HOME=/root
HOSTNAME=host.runestig.com
HOSTTYPE=i486
IFS='
'
LC_ALL=C
LINES=71
LOGNAME=root
MACHTYPE=i486-pc-linux-gnu
MAIL=/var/spool/mail/root
MAILCHECK=60
OPTERR=1
OPTIND=1
OSTYPE=linux-gnu
PATH=/sbin:/usr/sbin:/usr/ucb:/bin:/usr/bin:/etc:/usr/X11R6/bin:/root/bin
PIPESTATUS=([0]="0")
PPID=655
PS1='[\u@\h \W]\$ '
PS2='> '
PS4='+ '
PWD=/root
SHELL=/bin/bash
SHELLOPTS=braceexpand:hashall:histexpand:monitor:history:interactive-comment
s:emacs
SHLVL=1
TERM=vt220
UID=0
USER=root
USERNAME=root
_=koops.txt
mc=()
{
    MC=/tmp/mc$$-"$RANDOM";
    /usr/bin/mc -P "$@" >"$MC";
    cd "`cat $MC`";
    rm "$MC";
    unset MC
}

[7.1.] Software (add the output of the ver_linux script here)
Linux host.runestig.com 2.2.19pre7 #1 Mon Jan 22 11:57:12 CET 2001 i486
unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Binutils               2.9.1.0.25
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.0
Mount                  2.10o
Net-tools              1.50
Kbd                    0.96
Sh-utils               1.16
Modules Loaded         ip_masq_portfw ip_masq_ftp ipsec 3c509

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 4
model           : 3
model name      : 486 DX/2
stepping        : 5
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme
bogomips        : 33.17

[7.3.] Module information (from /proc/modules):
ip_masq_portfw          2752   1 (autoclean)
ip_masq_ftp             3904   0 (unused)
ipsec                 223568   2
3c509                   6112   2 (autoclean)

[7.5.] Other information that might be relevant to the problem
[luna@host luna]$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  19152896 17920000  1232896 11243520  1175552 10391552
Swap: 123858944        0 123858944
MemTotal:     18704 kB
MemFree:       1204 kB
MemShared:    10980 kB
Buffers:       1148 kB
Cached:       10148 kB
SwapTotal:   120956 kB
SwapFree:    120956 kB
[luna@host luna]$ ps axv
  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
    1 ?        S      0:07    289    20  1019  452  2.4 init [3]
    2 ?        SW     0:00      0     0     0    0  0.0 [kflushd]
    3 ?        SW     0:00      0     0     0    0  0.0 [kupdate]
    4 ?        SW     0:00      0     0     0    0  0.0 [kswapd]
  203 ?        S      0:00      0    95  1280  756  4.0 /sbin/dhclient eth1
  238 ?        S      0:00     66    22  1221  624  3.3 syslogd
  246 ?        S      0:02     26    16  1319  728  3.8 klogd
  256 ?        S      0:00     57    25  1234  616  3.2 cron
  341 ?        S      0:20    151   230  1369  828  4.4
/usr/lib/ipsec/pluto --debug-none --uniqueids
  426 ?        S      0:00     71    12  1243  588  3.1 inetd
  436 ?        S      0:00     73   518  1953 1740  9.3 named -u named -g
named
  451 ?        S      0:00     17   259  1572 1112  5.9 sendmail: accepting
connections on port 25
  507 ?        SL     0:00    326   161  1242 1396  7.4 /usr/bin/ntpd
  510 ?        S      0:00      0   104  1279  728  3.8 dhcpd eth0
  513 tty1     S      0:00     99    11  1016  416  2.2 /sbin/agetty 38400
tty1
  649 ttyS0    S      0:00    101    11  1016  424  2.2 /sbin/agetty -L
38400 ttyS0 vt100
  653 ?        S      0:05    638   670  1893 1428  7.6 telnetd
  654 ttyp0    S      0:00    235    18  1993 1176  6.2 login -- luna
  655 ttyp0    S      0:00    248   373  1630 1144  6.1 -bash
  721 ttyp0    R      0:00    191    50  2369  820  4.3 ps axv
[luna@host luna]$ uptime
  7:27pm  up   1:16,  1 user,  load average: 0.00, 0.01, 0.00


Cheers,
Peter
----------------------------------------------------------------
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@runestig.com>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screenname: PRunestig


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
