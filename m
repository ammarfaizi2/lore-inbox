Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTLKKVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLKKVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:21:47 -0500
Received: from [194.243.27.136] ([194.243.27.136]:23823 "HELO
	venere.pandoraonline.it") by vger.kernel.org with SMTP
	id S264879AbTLKKUM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:20:12 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlo <devel@integra-sc.it>
Subject: Fwd: Re: System hanged for a kernel NULL pointer dereference in SLES8-UL1
Date: Thu, 11 Dec 2003 11:20:20 +0100
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
Cc: ivan.sassi@prototipo.it
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200312111120.20819.devel@integra-sc.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem with RedHat 7.3 and kernel 2.4.22 with raiserFS. The
system reply to ping bunt isn't accessible from SSH and http neither from
respond to keyboard keypressing.
The dmesg command return:

Dec  4 04:26:02 webeye kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Dec  4 04:26:02 webeye kernel:  printing eip:
Dec  4 04:26:02 webeye kernel: c0127d55
Dec  4 04:26:02 webeye kernel: *pde = 00000000
Dec  4 04:26:02 webeye kernel: Oops: 0002
Dec  4 04:26:02 webeye kernel: CPU:    0
Dec  4 04:26:02 webeye kernel: EIP:    0010:[<c0127d55>]    Tainted: P
Dec  4 04:26:02 webeye kernel: EFLAGS: 00010202
Dec  4 04:26:02 webeye kernel: eax: 00000000   ebx: ca4df864   ecx: c0190f30
edx: 00000000
Dec  4 04:26:02 webeye kernel: esi: ca4df834   edi: 00000000   ebp: ca4df844
esp: cff2bf78
Dec  4 04:26:02 webeye kernel: ds: 0018   es: 0018   ss: 0018
Dec  4 04:26:02 webeye kernel: Process kupdated (pid: 6, stackpage=cff2b000)
Dec  4 04:26:02 webeye kernel: Stack: ca4df780 ca4df780 ca4df780 cfe3085c
c0147667 ca4df834 cfe30800 cff2bf9c
Dec  4 04:26:02 webeye kernel:        cff2bf9c 00000000 00000000 0066286a
cff2a000 c01159a0 c03b4d60 cff2a000
Dec  4 04:26:02 webeye kernel:        cff2a560 cff2a560 cff2a000 c01392d5
c013957c c0385e90 c12ddf98 c0105000
Dec  4 04:26:02 webeye kernel: Call Trace:    [<c0147667>] [<c01159a0>]
[<c01392d5>]
[<c013957c>] [<c0105000>]
Dec  4 04:26:02 webeye kernel:   [<c0105000>] [<c0107116>] [<c01394a0>]
Dec  4 04:26:02 webeye kernel:
Dec  4 04:26:02 webeye kernel: Code: 89 50 04 89 02 c7 03 00 00 00 00 c7 43
 04 00 00
00 00 8b 06

Alle 15:11, venerdì 28 novembre 2003, Ivan Sassi ha scritto:
> System hanged for a kernel NULL pointer dereference in SLES8-UL1
>
> The system (an IBM xSeries 440 4way xeon 2.4 MHz RAM 4 Gb) hanged whit
> the previus error. The machine continued to reply at ping requestes but
> no shell at all was accessible (the SSL connection also don't worked)...
> I restarted the machine (hard power reset) and the system seems to have
> no problem at all... but the server works as TSM server and runs the
> backup of VERY iportant data, so the maximun stability is absolutly
> necesary...
>
> Result of ps -ef:
>
> UID        PID  PPID  C STIME TTY          TIME CMD
> root         1     0  0 Nov27 ?        00:00:24 init
> root         2     1  0 Nov27 ?        00:00:00 [migration_CPU0]
> root         3     1  0 Nov27 ?        00:00:00 [migration_CPU1]
> root         4     1  0 Nov27 ?        00:00:00 [migration_CPU2]
> root         5     1  0 Nov27 ?        00:00:00 [migration_CPU3]
> root         6     1  0 Nov27 ?        00:00:08 [keventd]
> root         7     1  0 Nov27 ?        00:01:21 [ksoftirqd_CPU0]
> root         8     1  0 Nov27 ?        00:01:20 [ksoftirqd_CPU1]
> root         9     1  0 Nov27 ?        00:00:46 [ksoftirqd_CPU2]
> root        10     1  0 Nov27 ?        00:00:43 [ksoftirqd_CPU3]
> root        11     1  0 Nov27 ?        00:14:52 [kswapd]
> root        12     1  0 Nov27 ?        00:00:01 [bdflush]
> root        13     1  0 Nov27 ?        00:00:09 [kupdated]
> root        14     1  0 Nov27 ?        00:00:00 [kinoded]
> root        16     1  0 Nov27 ?        00:00:00 [mdrecoveryd]
> root        19     1  0 Nov27 ?        00:00:00 [qla2300_dpc0]
> root        20     1  0 Nov27 ?        00:00:00 [scsi_eh_0]
> root        22     1  0 Nov27 ?        00:00:00 [ahc_dv_0]
> root        23     1  0 Nov27 ?        00:00:00 [ahc_dv_1]
> root        24     1  0 Nov27 ?        00:00:00 [ahc_dv_2]
> root        25     1  0 Nov27 ?        00:00:00 [ahc_dv_3]
> root        26     1  0 Nov27 ?        00:00:00 [scsi_eh_1]
> root        27     1  0 Nov27 ?        00:00:00 [scsi_eh_2]
> root        28     1  0 Nov27 ?        00:00:00 [scsi_eh_3]
> root        29     1  0 Nov27 ?        00:00:00 [scsi_eh_4]
> root        33     1  0 Nov27 ?        00:00:11 [kjournald]
> root        92     1  0 Nov27 ?        00:00:00 [lvm-mpd]
> root       133     1  0 Nov27 ?        00:00:00 [kjournald]
> root       134     1  0 Nov27 ?        00:03:07 [kjournald]
> root       135     1  0 Nov27 ?        00:01:16 [kjournald]
> root       136     1  0 Nov27 ?        00:02:14 [kjournald]
> root       461     1  0 Nov27 ?        00:00:00 /sbin/syslogd
> root       464     1  0 Nov27 ?        00:00:00 /sbin/klogd -c 1 -2
> root       500     1  0 Nov27 ?        00:00:00 [khubd]
> bin        627     1  0 Nov27 ?        00:00:00 /sbin/portmap
> root       670     1  0 Nov27 ?        00:00:00 /usr/sbin/sshd
> root       931     1  0 Nov27 ?        00:00:03 /usr/lib/postfix/master
> at         954     1  0 Nov27 ?        00:00:00 /usr/sbin/atd
> postfix    964   931  0 Nov27 ?        00:00:01 qmgr -l -t fifo -u
> root       971     1  0 Nov27 ?        00:00:02 /usr/sbin/cron
> root      1064     1  0 Nov27 ?        00:00:01 /usr/sbin/nscd
> root      1065  1064  0 Nov27 ?        00:00:00 /usr/sbin/nscd
> root      1066  1065  0 Nov27 ?        00:00:01 /usr/sbin/nscd
> root      1067  1065  0 Nov27 ?        00:00:00 /usr/sbin/nscd
> root      1068  1065  0 Nov27 ?        00:00:00 /usr/sbin/nscd
> root      1069  1065  0 Nov27 ?        00:00:00 /usr/sbin/nscd
> root      1070  1065  0 Nov27 ?        00:00:00 /usr/sbin/nscd
> root      1081     1  0 Nov27 ?        00:00:00 /usr/sbin/inetd
> root      1098     1  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1107     1  0 Nov27 tty3     00:00:00 /sbin/mingetty tty3
> root      1109     1  0 Nov27 tty4     00:00:00 /sbin/mingetty tty4
> root      1111     1  0 Nov27 tty5     00:00:00 /sbin/mingetty tty5
> root      1112     1  0 Nov27 tty6     00:00:00 /sbin/mingetty tty6
> root      1126     1  0 Nov27 ?        00:00:42 /usr/bin/IBMtaped
> root      1141  1098  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1142  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1143  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1144  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1145  1141  0 Nov27 ?        00:00:20
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1146  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1147  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1148  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1149  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1150  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1151  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1152  1141  0 Nov27 ?        00:00:00
> /opt/IBM_FAStT/jre/bin/i386/native_threads/java -classpath
> /opt/IBM_FAStT/clie
> root      1365     1  0 Nov27 ?        00:00:06 ./dsmserv
> root      1366  1365  0 Nov27 ?        00:00:01 ./dsmserv
> root      1368  1366  0 Nov27 ?        00:01:37 ./dsmserv
> root      1369  1366  0 Nov27 ?        00:01:15 ./dsmserv
> root      1370  1366  0 Nov27 ?        00:01:40 ./dsmserv
> root      1371  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1372  1366  0 Nov27 ?        00:01:57 ./dsmserv
> root      1373  1366  0 Nov27 ?        00:00:06 ./dsmserv
> root      1374  1366  0 Nov27 ?        00:00:06 ./dsmserv
> root      1375  1366  0 Nov27 ?        00:00:31 ./dsmserv
> root      1376  1366  0 Nov27 ?        00:00:01 ./dsmserv
> root      1377  1366  0 Nov27 ?        00:00:02 ./dsmserv
> root      1387  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1388  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1390  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1391  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1392  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1394  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1397  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1398  1366  0 Nov27 ?        00:02:22 ./dsmserv
> root      1401  1366  0 Nov27 ?        00:09:33 ./dsmserv
> root      1404  1366  0 Nov27 ?        00:09:13 ./dsmserv
> root      1406  1366  0 Nov27 ?        00:02:35 ./dsmserv
> root      1409  1366  0 Nov27 ?        00:02:21 ./dsmserv
> root      1410  1366  0 Nov27 ?        00:02:22 ./dsmserv
> root      1413  1366  0 Nov27 ?        00:02:15 ./dsmserv
> root      1415  1366  0 Nov27 ?        00:04:25 ./dsmserv
> root      1417  1366  0 Nov27 ?        00:02:34 ./dsmserv
> root      1420  1366  0 Nov27 ?        00:14:07 ./dsmserv
> root      1423  1366  0 Nov27 ?        00:04:47 ./dsmserv
> root      1425  1366  0 Nov27 ?        00:05:07 ./dsmserv
> root      1427  1366  0 Nov27 ?        00:03:20 ./dsmserv
> root      1429  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1430  1366  0 Nov27 ?        00:05:06 ./dsmserv
> root      1431  1366  0 Nov27 ?        00:06:34 ./dsmserv
> root      1432  1366  0 Nov27 ?        00:05:04 ./dsmserv
> root      1433  1366  0 Nov27 ?        00:00:46 ./dsmserv
> root      1434  1366  0 Nov27 ?        00:03:01 ./dsmserv
> root      1435  1366  0 Nov27 ?        00:02:06 ./dsmserv
> root      1436  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1437  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1438  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1439  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1442  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1443  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1444  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1445  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1446  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1447  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1449  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1451  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1452  1366  0 Nov27 ?        00:00:00 ./dsmserv
> root      1488     1  0 Nov27 tty2     00:00:00 /sbin/mingetty tty2
> root      1512     1  0 Nov27 tty1     00:00:00 /sbin/mingetty --noclear
> tty1
> root      3522  1366  0 Nov27 ?        00:00:00 ./dsmserv
> postfix   8159   931  0 13:45 ?        00:00:00 pickup -l -t fifo -u
> root      8248   670  0 14:28 ?        00:00:00 /usr/sbin/sshd
> root      8250  8248  0 14:28 pts/0    00:00:00 -bash
> root      8400  8250  0 14:54 pts/0    00:00:00 ps -ef
>
> Result of cat /proc/version:
>
> Linux version 2.4.19-64GB-SMP (root@SMP_X86.suse.de) (gcc version 3.2.2)
> #1 SMP Mon Aug 4 23:48:22 UTC 2003
>
> Output of Oops.. message:
>
> Nov 26 22:31:55 SSILXTSM kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000004
> Nov 26 22:31:55 SSILXTSM kernel:  printing eip:
> Nov 26 22:31:55 SSILXTSM kernel: c015633b
> Nov 26 22:31:55 SSILXTSM kernel: *pde = 0b61a001
> Nov 26 22:31:55 SSILXTSM kernel: Oops: 0002 2.4.19-64GB-SMP #1 SMP Mon
> Aug 4 23:48:22 UTC 2003
> Nov 26 22:31:55 SSILXTSM kernel: CPU:    1
> Nov 26 22:31:55 SSILXTSM kernel: EIP:    0010:[sys_close+27/128]    Not
> tainted
> Nov 26 22:31:55 SSILXTSM kernel: EIP:    0010:[<c015633b>]    Not tainted
> Nov 26 22:31:55 SSILXTSM kernel: EFLAGS: 00010286
> Nov 26 22:31:55 SSILXTSM kernel: eax: 00000004   ebx: d75fe000   ecx:
> 00000023   edx: 00000000
> Nov 26 22:31:55 SSILXTSM kernel: esi: 0000005c   edi: 00000000   ebp:
> b79fb454   esp: d75fffb4
> Nov 26 22:31:55 SSILXTSM kernel: ds: 0018   es: 0018   ss: 0018
> Nov 26 22:31:55 SSILXTSM kernel: Process dsmserv (pid: 6653,
> stackpage=d75ff000)
> Nov 26 22:31:55 SSILXTSM kernel: Stack: b79ffc00 00000000 d75fe000
> c01095ef 00000023 00000000 4006fac0 0000005c
> Nov 26 22:31:55 SSILXTSM kernel:        00000000 b79fb454 00000006
> 0000002b 0000002b 00000006 40132a4d 00000023
> Nov 26 22:31:55 SSILXTSM kernel:        00000246 b79fb438 0000002b
> Nov 26 22:31:55 SSILXTSM kernel: Call Trace:    [system_call+51/56]
> Nov 26 22:31:55 SSILXTSM kernel: Call Trace:    [<c01095ef>]
> Nov 26 22:31:55 SSILXTSM kernel: Code: f0 81 28 00 00 00 01 0f 85 04 07
> 00 00 3b 4a 08 73 43 8b 42
>
> The are no apparent trigger to the error status...
>
> The distro is a SLES8 powered by UnitedLinux 1.0... the only upgrade was
> to the kernel k_smp-2.4.19-340...
>
> Result of sh /usr/src/linux/scripts/ver_linux:
>
> Linux SSILXTSM 2.4.19-64GB-SMP #1 SMP Mon Aug 4 23:48:22 UTC 2003 i686
> unknown
>
> Gnu C                  gcc (GCC) 3.2 Copyright (C) 2002 Free Software
> Foundation, Inc. This is free software; see the source for copying
> conditions. There is NO warranty; not even for MERCHANTABILITY or
> FITNESS FOR A PARTICULAR PURPOSE.
> Gnu make               3.79.1
> util-linux             2.11u
> mount                  2.11u
> modutils               2.4.19
> e2fsprogs              1.28
> PPP                    2.4.1
> isdn4k-utils           3.2p1
> Linux C Library        x    1 root     root      1312470 Oct 22  2002
> /lib/libc.so.6
> Dynamic linker (ldd)   2.2.5
> Linux C++ Library      5.0.0
> Procps                 2.0.7
> Net-tools              1.60
> Kbd                    1.06
> Sh-utils               2.0
> Modules Loaded         ide-cd isa-pnp ipv6 st sr_mod cdrom sg joydev
> evdev input usb-uhci usbcore bcm5700 lvm-mod ext3 jbd IBMtape aic7xxx
> qla2300
>
> Result of cat /proc/cpuinfo:
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.40GHz
> stepping        : 7
> cpu MHz         : 2395.205
> cache size      : 512 KB
> physical id     : 0
> siblings        : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 198.65
>
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.40GHz
> stepping        : 7
> cpu MHz         : 2395.205
> cache size      : 512 KB
> physical id     : 0
> siblings        : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 199.47
>
> processor       : 2
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.40GHz
> stepping        : 7
> cpu MHz         : 2395.205
> cache size      : 512 KB
> physical id     : 0
> siblings        : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 199.47
>
> processor       : 3
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 2.40GHz
> stepping        : 7
> cpu MHz         : 2395.205
> cache size      : 512 KB
> physical id     : 0
> siblings        : 1
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 199.47
>
> Result of cat /proc/modules:
>
> ide-cd                 30564   0 (autoclean)
> isa-pnp                32512   0 (unused)
> ipv6                  268124  -1 (autoclean)
> st                     29324   0 (autoclean)
> sr_mod                 14520   0 (autoclean) (unused)
> cdrom                  29056   0 (autoclean) [ide-cd sr_mod]
> sg                     30368   0 (autoclean)
> joydev                  6112   0 (unused)
> evdev                   4800   0 (unused)
> input                   3488   0 [joydev evdev]
> usb-uhci               24460   0 (unused)
> usbcore                64960   1 [usb-uhci]
> bcm5700                86280   2
> lvm-mod                68256   0 (autoclean)
> ext3                   89160   5
> jbd                    54020   5 [ext3]
> IBMtape               167141   1
> aic7xxx               179108   0
> qla2300               236096   6
>
> Result of cat /proc/ioports:
>
> 0000-001f : dma1
> 0020-003f : pic1
> 0040-005f : timer
> 0060-006f : keyboard
> 0070-007f : rtc
> 0080-008f : dma page reg
> 00a0-00bf : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 01f0-01f7 : ide0
> 03c0-03df : vesafb
> 03f6-03f6 : ide0
> 0440-044f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> 0700-070f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
>    0700-0707 : ide0
>    0708-070f : ide1
> 0cf8-0cff : PCI conf1
> 1800-187f : PCI device 1014:010f (IBM)
> 1880-189f : VIA Technologies, Inc. USB
>    1880-189f : usb-uhci
> 18a0-18bf : VIA Technologies, Inc. USB (#2)
>    18a0-18bf : usb-uhci
> 3000-30ff : QLogic Corp. QLA2312 Fibre Channel Adapter
>    3000-30fe : qla2300
> 3800-38ff : Adaptec AHA-3960D / AIC-7899A U160/m
>    3800-38ff : aic7xxx
> 3900-39ff : Adaptec AHA-3960D / AIC-7899A U160/m (#2)
>    3900-39ff : aic7xxx
> 3a00-3aff : Adaptec AHA-3960D / AIC-7899A U160/m (#3)
>    3a00-3aff : aic7xxx
> 3b00-3bff : Adaptec AHA-3960D / AIC-7899A U160/m (#4)
>    3b00-3bff : aic7xxx
>
> Result of cat /proc/iomem:
>
> 00000000-0009d7ff : System RAM
> 0009d800-0009ffff : reserved
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000c8000-000c97ff : Extension ROM
> 000c9800-000cafff : Extension ROM
> 000cb000-000cd9ff : Extension ROM
> 000f0000-000fffff : System ROM
> 00100000-dffb6fbf : System RAM
>    00100000-002e3f65 : Kernel code
>    002e3f66-0037d39f : Kernel data
> dffb6fc0-dffbf7ff : ACPI Tables
> dffbf800-dfffffff : reserved
> e0000000-e7ffffff : S3 Inc. Savage 4
>    e0000000-e07fffff : vesafb
> f0410000-f041ffff : PCI device 14e4:1648 (Broadcom Corporation)
>    f0410000-f041ffff : bcm5700
> f0420000-f042ffff : PCI device 14e4:1648 (Broadcom Corporation)
>    f0420000-f042ffff : bcm5700
> f0430000-f043ffff : PCI device 14e4:1648 (Broadcom Corporation)
>    f0430000-f043ffff : bcm5700
> f0440000-f044ffff : PCI device 14e4:1648 (Broadcom Corporation)
>    f0440000-f044ffff : bcm5700
> f0800000-f09fffff : PCI device 1014:010f (IBM)
> f0a00000-f0a7ffff : S3 Inc. Savage 4
> f0e00000-f0e0ffff : Broadcom Corporation NetXtreme BCM5700 Gigabit Ethernet
>    f0e00000-f0e0ffff : bcm5700
> fb620000-fb620fff : QLogic Corp. QLA2312 Fibre Channel Adapter
> fb720000-fb720fff : Adaptec AHA-3960D / AIC-7899A U160/m
>    fb720000-fb720fff : aic7xxx
> fb721000-fb721fff : Adaptec AHA-3960D / AIC-7899A U160/m (#2)
>    fb721000-fb721fff : aic7xxx
> fb722000-fb722fff : Adaptec AHA-3960D / AIC-7899A U160/m (#3)
>    fb722000-fb722fff : aic7xxx
> fb723000-fb723fff : Adaptec AHA-3960D / AIC-7899A U160/m (#4)
>    fb723000-fb723fff : aic7xxx
> fec00000-ffffffff : reserved
>
> Result of lspci -vvv:
>
> 00:00.0 Host bridge: IBM: Unknown device 0302 (rev 03)
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>          Latency: 240
>          Capabilities: [60] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=0 OST=1
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 00:03.0 VGA compatible controller: S3 Inc. Savage 4 (rev 06) (prog-if 00
> [VGA])
>          Subsystem: IBM: Unknown device 01c5
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 248 (1000ns min, 63750ns max), cache line size 10
>          Interrupt: pin A routed to IRQ 39
>          Region 0: Memory at f0a00000 (32-bit, non-prefetchable)
> [size=512K] Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
> Expansion ROM at <unassigned> [disabled] [size=64K]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:04.0 Bridge: IBM: Unknown device 010f
>          Subsystem: IBM: Unknown device 0113
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 247 (1000ns min, 2000ns max), cache line size 10
>          Interrupt: pin A routed to IRQ 16
>          BIST result: 00
>          Region 0: Memory at f0800000 (64-bit, non-prefetchable) [size=2M]
>          Region 2: I/O ports at 1800 [size=128]
>          Expansion ROM at <unassigned> [disabled] [size=2M]
>          Capabilities: [48] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:05.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
>          Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 0
>          Capabilities: [c0] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:05.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master
> IDE (rev 06) (prog-if 8a [Master SecP PriP])
>          Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240
>          Region 4: I/O ports at 0700 [size=16]
>          Capabilities: [c0] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:05.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
> [UHCI])
>          Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240, cache line size 10
>          Interrupt: pin D routed to IRQ 18
>          Region 4: I/O ports at 1880 [size=32]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:05.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00
> [UHCI])
>          Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240, cache line size 10
>          Interrupt: pin D routed to IRQ 18
>          Region 4: I/O ports at 18a0 [size=32]
>          Capabilities: [80] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 00:05.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
>          Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
>          Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Capabilities: [68] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 01:00.0 Host bridge: IBM: Unknown device 0302 (rev 03)
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>          Latency: 240
>          Capabilities: [60] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=0 OST=1
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 01:04.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700
> Gigabit Ethernet (rev 12)
>          Subsystem: IBM Broadcom Vigil B5700 1000BaseTX
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (16000ns min), cache line size 10
>          Interrupt: pin A routed to IRQ 42
>          Region 0: Memory at f0e00000 (64-bit, non-prefetchable) [size=64K]
>          Capabilities: [40] PCI-X non-bridge device.
>                  Command: DPERE- ERO+ RBC=3 OST=6
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48]
> Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                  Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>          Capabilities: [50] Vital Product Data
>          Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                  Address: 94aad0631e01a210  Data: 3a3b
>
> 02:00.0 Host bridge: IBM: Unknown device 0302 (rev 03)
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>          Latency: 240
>          Capabilities: [60] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=0 OST=1
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 02:02.0 Ethernet controller: Broadcom Corporation: Unknown device 1648
> (rev 03)
>          Subsystem: Broadcom Corporation: Unknown device 1648
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (16000ns min), cache line size 10
>          Interrupt: pin A routed to IRQ 55
>          Region 0: Memory at f0410000 (64-bit, non-prefetchable) [size=64K]
>          Region 2: Memory at f0420000 (64-bit, non-prefetchable) [size=64K]
>          Expansion ROM at <unassigned> [disabled] [size=64K]
>          Capabilities: [40] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=2 OST=0
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48]
> Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                  Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
>          Capabilities: [50] Vital Product Data
>          Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                  Address: 2804801110811200  Data: 2260
>
> 02:02.1 Ethernet controller: Broadcom Corporation: Unknown device 1648
> (rev 03)
>          Subsystem: Broadcom Corporation: Unknown device 1648
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (16000ns min), cache line size 10
>          Interrupt: pin B routed to IRQ 56
>          Region 0: Memory at f0430000 (64-bit, non-prefetchable) [size=64K]
>          Region 2: Memory at f0440000 (64-bit, non-prefetchable) [size=64K]
>          Capabilities: [40] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=2 OST=0
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [48]
> Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                  Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
>          Capabilities: [50] Vital Product Data
>          Capabilities: [58] Message Signalled Interrupts: 64bit+
> Queue=0/3 Enable-
>                  Address: 0004205020500000  Data: 0c02
>
> 05:00.0 Host bridge: IBM: Unknown device 0302 (rev 03)
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>          Latency: 240
>          Capabilities: [60] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=0 OST=1
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 05:04.0 Fibre Channel: QLogic Corp. QLA2312 Fibre Channel Adapter (rev 02)
>          Subsystem: QLogic Corp.: Unknown device 0100
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (16000ns min), cache line size 10
>          Interrupt: pin A routed to IRQ 71
>          Region 0: I/O ports at 3000 [size=256]
>          Region 1: Memory at fb620000 (64-bit, non-prefetchable) [size=4K]
>          Expansion ROM at <unassigned> [disabled] [size=128K]
>          Capabilities: [44] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>          Capabilities: [4c] PCI-X non-bridge device.
>                  Command: DPERE- ERO+ RBC=3 OST=6
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [54]
> Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
>                  Address: 0000000000000000  Data: 0000
>          Capabilities: [64] #06 [0080]
>
> 07:00.0 Host bridge: IBM: Unknown device 0302 (rev 03)
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>          Latency: 240
>          Capabilities: [60] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=0 OST=1
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 09:00.0 Host bridge: IBM: Unknown device 0302 (rev 03)
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr+ Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
> <TAbort- <MAbort+ >SERR- <PERR-
>          Latency: 240
>          Capabilities: [60] PCI-X non-bridge device.
>                  Command: DPERE- ERO- RBC=0 OST=1
>                  Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-
> 09:01.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
> (rev 01)
>          Subsystem: Adaptec AHA-3960D U160/m
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (10000ns min, 6250ns max), cache line size 10
>          Interrupt: pin A routed to IRQ 59
>          BIST result: 00
>          Region 0: I/O ports at 3800 [disabled] [size=256]
>          Region 1: Memory at fb720000 (64-bit, non-prefetchable) [size=4K]
>          Expansion ROM at <unassigned> [disabled] [size=128K]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 09:01.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
> (rev 01)
>          Subsystem: Adaptec AHA-3960D U160/m
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (10000ns min, 6250ns max), cache line size 10
>          Interrupt: pin B routed to IRQ 60
>          BIST result: 00
>          Region 0: I/O ports at 3900 [disabled] [size=256]
>          Region 1: Memory at fb721000 (64-bit, non-prefetchable) [size=4K]
>          Expansion ROM at <unassigned> [disabled] [size=128K]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 09:02.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
> (rev 01)
>          Subsystem: Adaptec AHA-3960D U160/m
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (10000ns min, 6250ns max), cache line size 10
>          Interrupt: pin A routed to IRQ 63
>          BIST result: 00
>          Region 0: I/O ports at 3a00 [disabled] [size=256]
>          Region 1: Memory at fb722000 (64-bit, non-prefetchable) [size=4K]
>          Expansion ROM at <unassigned> [disabled] [size=128K]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> 09:02.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
> (rev 01)
>          Subsystem: Adaptec AHA-3960D U160/m
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 240 (10000ns min, 6250ns max), cache line size 10
>          Interrupt: pin B routed to IRQ 64
>          BIST result: 00
>          Region 0: I/O ports at 3b00 [disabled] [size=256]
>          Region 1: Memory at fb723000 (64-bit, non-prefetchable) [size=4K]
>          Expansion ROM at <unassigned> [disabled] [size=128K]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
> Result of cat /proc/scsi/scsi:
>
> Attached devices:
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>    Vendor: IBM      Model: 1742             Rev: 0520
>    Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 00 Lun: 01
>    Vendor: IBM      Model: 1742             Rev: 0520
>    Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 00 Lun: 02
>    Vendor: IBM      Model: 1742             Rev: 0520
>    Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi0 Channel: 00 Id: 00 Lun: 03
>    Vendor: IBM      Model: 1742             Rev: 0520
>    Type:   Direct-Access                    ANSI SCSI revision: 03
> Host: scsi1 Channel: 00 Id: 05 Lun: 00
>    Vendor: IBM      Model: ULT3580-TD2      Rev: 3A30
>    Type:   Sequential-Access                ANSI SCSI revision: 03
> Host: scsi2 Channel: 00 Id: 03 Lun: 00
>    Vendor: IBM      Model: ULT3580-TD2      Rev: 3A30
>    Type:   Sequential-Access                ANSI SCSI revision: 03
> Host: scsi2 Channel: 00 Id: 04 Lun: 00
>    Vendor: IBM      Model: ULT3580-TD2      Rev: 3A30
>    Type:   Sequential-Access                ANSI SCSI revision: 03
> Host: scsi3 Channel: 00 Id: 00 Lun: 00
>    Vendor: IBM      Model: ULT3580-TD2      Rev: 3A30
>    Type:   Sequential-Access                ANSI SCSI revision: 03
> Host: scsi3 Channel: 00 Id: 00 Lun: 01
>    Vendor: IBM      Model: 03584L32         Rev: 3480
>    Type:   Medium Changer                   ANSI SCSI revision: 03
> Host: scsi3 Channel: 00 Id: 01 Lun: 00
>    Vendor: IBM      Model: ULT3580-TD2      Rev: 3A30
>    Type:   Sequential-Access                ANSI SCSI revision: 03
> Host: scsi4 Channel: 00 Id: 02 Lun: 00
>    Vendor: IBM      Model: ULT3580-TD2      Rev: 3A30
>    Type:   Sequential-Access                ANSI SCSI revision: 03

-------------------------------------------------------

-------------------------------------------------------

