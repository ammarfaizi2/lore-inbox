Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSIIPKO>; Mon, 9 Sep 2002 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317393AbSIIPKO>; Mon, 9 Sep 2002 11:10:14 -0400
Received: from unknown.Level3.net ([63.210.233.154]:61546 "EHLO
	cinshrexc01.shermfin.com") by vger.kernel.org with ESMTP
	id <S317387AbSIIPKM> convert rfc822-to-8bit; Mon, 9 Sep 2002 11:10:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: syslogd: recvfrom inet: resource temporarily unavailable
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Mon, 9 Sep 2002 11:14:55 -0400
Message-ID: <CDF05CB9FCA0C845B9778F9E463C476101FC76@cinshrexc01.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: syslogd: recvfrom inet: resource temporarily unavailable
Thread-Index: AcJYE6chB41LrtGZRuySqDOPosLhEA==
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a Dell PowerEdge 2300 running Red Hat Linux 7.2 for a
syslog consolidation machine.  It is also our network monitoring
system and it runs Cricket, NMIS, and cflowd and Flowscan for Cisco
NetFlow collection.

Lately the machine has been running extremely slow whenever anything
that happens on the box needs to syslog something (su, logins, etc.). 
I've checked /var/log/messages and it repeatedly contains the
following line:

Sep  6 14:23:54 cinshrnms02 syslogd: recvfrom inet: Resource
temporarily unavailable

Notice the Recv-Q for the syslog port (UDP 514) in the netstat output
below.  The box does A LOT of SNMP polls as well as receives syslogs
from about 6-8 Cisco routers (3600 series and 7100 series) on T1 and
DS3 links.

My question is are there any compile-time or run-time options (via
/proc) that I can tweak to get better syslog/UDP performance out of
the box?  Is there anything else at which I should be looking?

It's an old box (cpuinfo, meminfo, kernel info below), but I was
having similar problems on a quad Xeon 700 with 2GB RAM.  I've already
upped /proc/sys/fs/file-max and /proc/sys/net/ipv4/ip_local_port_range

I may just need beefier hardware, but I wanted to see if there was
anything else I could tweak before we spend cash :)

Thanks for your assistance,
Andy.

Andrew Rechenberg
Infrastructure Team, Sherman Financial Group
arechenberg @ shermfin.com

*****************************************************

syslogd CMD line: syslogd -m 0 -r -x
RPM: sysklogd-1.4.1-4
Kernel: RH 2.4.7-10

/proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 397.958
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr
bogomips        : 794.62

/proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  525684736 416747520 108937216   315392 90697728 265424896
Swap: 534601728        0 534601728
MemTotal:       513364 kB
MemFree:        106384 kB
MemShared:         308 kB
Buffers:         88572 kB
Cached:         259204 kB
SwapCached:          0 kB
Active:          24156 kB
Inact_dirty:    323928 kB
Inact_clean:         0 kB
Inact_target:      712 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513364 kB
LowFree:        106384 kB
SwapTotal:      522072 kB
SwapFree:       522072 kB
NrSwapPages:    130518 pages



Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address        
State
tcp        0      0 10.1.1.56:8192          0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:32768           0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:2056            0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:111             0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:6000            0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:80              0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:21              0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:22              0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:23              0.0.0.0:*              
LISTEN
tcp        0      0 127.0.0.1:25            0.0.0.0:*              
LISTEN
tcp        0      0 127.0.0.1:34330         0.0.0.0:*              
LISTEN
tcp        0      0 0.0.0.0:443             0.0.0.0:*              
LISTEN
tcp        0      0 10.1.1.56:8697          10.1.1.72:6101         
TIME_WAIT
tcp        0      0 10.1.1.56:8696          10.1.1.72:6101         
TIME_WAIT
tcp        0      0 10.1.1.56:80            10.1.1.91:2878         
TIME_WAIT
tcp        0      0 10.1.1.56:22            10.1.1.35:37303        
ESTABLISHED
tcp        0      0 10.1.1.56:22            10.1.1.140:1399        
ESTABLISHED
udp        0      0 0.0.0.0:32768           0.0.0.0:*
udp    41056      0 0.0.0.0:514             0.0.0.0:*
udp        0      0 0.0.0.0:2055            0.0.0.0:*
udp        0      0 0.0.0.0:69              0.0.0.0:*
udp        0      0 0.0.0.0:69              0.0.0.0:*
udp        0      0 0.0.0.0:734             0.0.0.0:*
udp        0      0 0.0.0.0:111             0.0.0.0:*
Active UNIX domain sockets (servers and established)
Proto RefCnt Flags       Type       State         I-Node Path
unix  2      [ ACC ]     STREAM     LISTENING     1243  
/usr/local/arts/etc/cflowdtable.socket
unix  3      [ ]         DGRAM                    56399  /dev/log
unix  2      [ ACC ]     STREAM     LISTENING     1015   /dev/gpmctl
unix  2      [ ACC ]     STREAM     LISTENING     1125  
/tmp/.font-unix/fs7100
unix  2      [ ACC ]     STREAM     LISTENING     1257  
/tmp/.X11-unix/X0
unix  2      [ ]         DGRAM                    56409
unix  2      [ ]         STREAM     CONNECTED     55406
unix  2      [ ]         STREAM     CONNECTED     53649
unix  2      [ ]         DGRAM                    14449
unix  2      [ ]         STREAM     CONNECTED     2272
unix  2      [ ]         DGRAM                    1347
unix  3      [ ]         STREAM     CONNECTED     1304  
/tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     1303
unix  3      [ ]         STREAM     CONNECTED     1301  
/tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     1300
unix  3      [ ]         STREAM     CONNECTED     1297  
/tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     1296
unix  3      [ ]         STREAM     CONNECTED     1281  
/tmp/.font-unix/fs7100
unix  3      [ ]         STREAM     CONNECTED     1280
unix  3      [ ]         STREAM     CONNECTED     1284  
/tmp/.X11-unix/X0
unix  3      [ ]         STREAM     CONNECTED     1260
unix  2      [ ]         DGRAM                    1185
unix  2      [ ]         DGRAM                    1176
unix  2      [ ]         DGRAM                    1128
unix  2      [ ]         DGRAM                    996
unix  2      [ ]         DGRAM                    813
unix  2      [ ]         STREAM     CONNECTED     481

Andrew Rechenberg
Infrastructure Team, Sherman Financial Group
arechenberg@shermanfinancialgroup.com
Phone: 513.677.7809
Fax:   513.677.7838
