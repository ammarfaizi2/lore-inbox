Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTKIVVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbTKIVVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:21:25 -0500
Received: from h234n2fls24o1061.bredband.comhem.se ([217.208.132.234]:41947
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S261460AbTKIVVO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:21:14 -0500
Date: Sun, 9 Nov 2003 22:23:58 +0100
From: Voluspa <wormprotection-lista3@comhem.se>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9:
Message-Id: <20031109222358.78a8d403.wormprotection-lista3@comhem.se>
In-Reply-To: <shssml5o2lp.fsf@charged.uio.no>
References: <20031103163455.57d24178.lista2@comhem.se>
	<shssml5o2lp.fsf@charged.uio.no>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OBS
OBS Remove "wormprotection-" from the address. SWEN is killing me OBS
OBS

On 03 Nov 2003 11:09:54 -0500
Trond Myklebust wrote:
> >>>>> " " == lista2  <Voluspa> writes:
[...]
> So where *does* the big jump from 3 minutes to 29 minutes occur?

Copy test times:
2.6.0-test3-bk10 = ~ 2 minutes
2.6.0-test3-bk10-final -- 2.6.0-test6-bk9 = ~ 4 minutes
2.6.0-test6-bk10 -- 2.6.0-test9 = ~ 30 minutes (and more)

Here's "time", "nfsstat" and "netstat -s" from the relevant kernels. I
had shut down any excessive netservices and ran without X.

===Begin 2.6.0-test3-bk10===

# /bin/mount -t nfs oden.fish.net:/ /mnt/oden
# time cp -a /mnt/oden/etc .
real    2m3.153s
user    0m0.011s
sys     0m0.099s

# nfsstat
Server rpc stats:
calls      badcalls   badauth    badclnt    xdrcall
1          0          0          0          0       
Server nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Server nfs v3:
null       getattr    setattr    lookup     access     readlink   
1      100% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

Client rpc stats:
calls      retrans    authrefrsh
959        636        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 236    24% 0       0% 0       0% 236    24% 5       0% 
read       wrcache    write      create     remove     rename     
464    48% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 17      1% 1       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

# netstat -s
Ip:
    6235 total packets received
    0 forwarded
    0 incoming packets discarded
    1024 incoming packets delivered
    1662 requests sent out
    58 fragments dropped after timeout
    3288 reassemblies required
    332 packets reassembled ok
    620 packet reassembles failed
Icmp:
    0 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
    1 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        time exceeded: 1
Tcp:
    1 active connections openings
    0 passive connection openings
    0 failed connection attempts
    0 connection resets received
    0 connections established
    5 segments received
    6 segments send out
    0 segments retransmited
    0 bad segments received.
    0 resets sent
Udp:
    1019 packets received
    0 packets to unknown port received.
    0 packet receive errors
    1655 packets sent
TcpExt:
    ArpFilter: 0
    1 TCP sockets finished time wait in fast timer
    1 packets header predicted
    TCPPureAcks: 1
    TCPHPAcks: 1
    TCPRenoRecovery: 0
    TCPSackRecovery: 0
    TCPSACKReneging: 0
    TCPFACKReorder: 0
    TCPSACKReorder: 0
    TCPRenoReorder: 0
    TCPTSReorder: 0
    TCPFullUndo: 0
    TCPPartialUndo: 0
    TCPDSACKUndo: 0
    TCPLossUndo: 0
    TCPLoss: 0
    TCPLostRetransmit: 0
    TCPRenoFailures: 0
    TCPSackFailures: 0
    TCPLossFailures: 0
    TCPFastRetrans: 0
    TCPForwardRetrans: 0
    TCPSlowStartRetrans: 0
    TCPTimeouts: 0
    TCPRenoRecoveryFail: 0
    TCPSackRecoveryFail: 0
    TCPSchedulerFailed: 0
    TCPRcvCollapsed: 0
    TCPDSACKOldSent: 0
    TCPDSACKOfoSent: 0
    TCPDSACKRecv: 0
    TCPDSACKOfoRecv: 0
    TCPAbortOnSyn: 0
    TCPAbortOnData: 0
    TCPAbortOnClose: 0
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 0
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0

===End 2.6.0-test3-bk10===

===Begin 2.6.0-test6-bk9===

# /bin/mount -t nfs oden.fish.net:/ /mnt/oden
# time cp -a /mnt/oden/etc .
real    3m43.904s
user    0m0.011s
sys     0m0.114s

# nfsstat
Server rpc stats:
calls      badcalls   badauth    badclnt    xdrcall
1          0          0          0          0       
Server nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Server nfs v3:
null       getattr    setattr    lookup     access     readlink   
1      100% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

Client rpc stats:
calls      retrans    authrefrsh
959        613        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 236    24% 0       0% 0       0% 236    24% 5       0% 
read       wrcache    write      create     remove     rename     
464    48% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 17      1% 1       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

# netstat -s
Ip:
    6107 total packets received
    0 forwarded
    0 incoming packets discarded
    1024 incoming packets delivered
    1638 requests sent out
    87 fragments dropped after timeout
    3051 reassemblies required
    332 packets reassembled ok
    587 packet reassembles failed
Icmp:
    0 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
    0 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
Tcp:
    1 active connections openings
    0 passive connection openings
    0 failed connection attempts
    0 connection resets received
    0 connections established
    5 segments received
    6 segments send out
    0 segments retransmited
    0 bad segments received.
    0 resets sent
Udp:
    1019 packets received
    0 packets to unknown port received.
    0 packet receive errors
    1632 packets sent
TcpExt:
    ArpFilter: 0
    1 TCP sockets finished time wait in fast timer
    1 packets header predicted
    TCPPureAcks: 1
    TCPHPAcks: 1
    TCPRenoRecovery: 0
    TCPSackRecovery: 0
    TCPSACKReneging: 0
    TCPFACKReorder: 0
    TCPSACKReorder: 0
    TCPRenoReorder: 0
    TCPTSReorder: 0
    TCPFullUndo: 0
    TCPPartialUndo: 0
    TCPDSACKUndo: 0
    TCPLossUndo: 0
    TCPLoss: 0
    TCPLostRetransmit: 0
    TCPRenoFailures: 0
    TCPSackFailures: 0
    TCPLossFailures: 0
    TCPFastRetrans: 0
    TCPForwardRetrans: 0
    TCPSlowStartRetrans: 0
    TCPTimeouts: 0
    TCPRenoRecoveryFail: 0
    TCPSackRecoveryFail: 0
    TCPSchedulerFailed: 0
    TCPRcvCollapsed: 0
    TCPDSACKOldSent: 0
    TCPDSACKOfoSent: 0
    TCPDSACKRecv: 0
    TCPDSACKOfoRecv: 0
    TCPAbortOnSyn: 0
    TCPAbortOnData: 0
    TCPAbortOnClose: 0
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 0
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0

===End 2.6.0-test6-bk9===

===Begin 2.6.0-test6-bk10===

# /bin/mount -t nfs oden.fish.net:/ /mnt/oden
# time cp -a /mnt/oden/etc .
real    34m37.280s
user    0m0.009s
sys     0m0.105s

# nfsstat
Server rpc stats:
calls      badcalls   badauth    badclnt    xdrcall
1          0          0          0          0       
Server nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Server nfs v3:
null       getattr    setattr    lookup     access     readlink   
1      100% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

Client rpc stats:
calls      retrans    authrefrsh
963        569        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 240    24% 0       0% 0       0% 236    24% 5       0% 
read       wrcache    write      create     remove     rename     
464    48% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 17      1% 1       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       write      create     mkdir      symlink    mknod      
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 0       0% 0       0% 0       0% 

# netstat -s
Ip:
    5859 total packets received
    0 forwarded
    0 incoming packets discarded
    1028 incoming packets delivered
    1603 requests sent out
    555 fragments dropped after timeout
    2804 reassemblies required
    332 packets reassembled ok
    555 packet reassembles failed
Icmp:
    0 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
    5 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        time exceeded: 5
Tcp:
    1 active connections openings
    0 passive connection openings
    0 failed connection attempts
    0 connection resets received
    0 connections established
    5 segments received
    6 segments send out
    0 segments retransmited
    0 bad segments received.
    0 resets sent
Udp:
    1023 packets received
    0 packets to unknown port received.
    0 packet receive errors
    1592 packets sent
TcpExt:
    ArpFilter: 0
    1 TCP sockets finished time wait in fast timer
    1 packets header predicted
    TCPPureAcks: 1
    TCPHPAcks: 1
    TCPRenoRecovery: 0
    TCPSackRecovery: 0
    TCPSACKReneging: 0
    TCPFACKReorder: 0
    TCPSACKReorder: 0
    TCPRenoReorder: 0
    TCPTSReorder: 0
    TCPFullUndo: 0
    TCPPartialUndo: 0
    TCPDSACKUndo: 0
    TCPLossUndo: 0
    TCPLoss: 0
    TCPLostRetransmit: 0
    TCPRenoFailures: 0
    TCPSackFailures: 0
    TCPLossFailures: 0
    TCPFastRetrans: 0
    TCPForwardRetrans: 0
    TCPSlowStartRetrans: 0
    TCPTimeouts: 0
    TCPRenoRecoveryFail: 0
    TCPSackRecoveryFail: 0
    TCPSchedulerFailed: 0
    TCPRcvCollapsed: 0
    TCPDSACKOldSent: 0
    TCPDSACKOfoSent: 0
    TCPDSACKRecv: 0
    TCPDSACKOfoRecv: 0
    TCPAbortOnSyn: 0
    TCPAbortOnData: 0
    TCPAbortOnClose: 0
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 0
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0

===End 2.6.0-test6-bk10===

Mvh
Mats Johannesson
