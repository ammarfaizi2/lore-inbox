Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTKJHDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 02:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTKJHDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 02:03:51 -0500
Received: from h234n2fls24o1061.bredband.comhem.se ([217.208.132.234]:54490
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S262986AbTKJHDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 02:03:47 -0500
Date: Mon, 10 Nov 2003 08:06:41 +0100
From: Voluspa <wormprotection-lista3@comhem.se>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9:
Message-Id: <20031110080641.3b79c571.wormprotection-lista3@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OBS Remove "wormprotection-" from the address. SWEN is killing me OBS

On 2003-11-09 22:04:05 Trond Myklebust wrote:
>OK. That points squarely at the RTO timeout "inheritance" change.
>There are 2 differences as it stands in 2.6.0 w.r.t. the 2.4.23-pre
>code: the no upper limit, and the inheritance update algorithm.
>
>Could you therefore try the following patch.

All conditions reset to yesterdays tests, patch applied, regression
regresses:

===Begin 2.6.0-test9-trondpatch1===

# /bin/mount -t nfs oden.fish.net:/ /mnt/oden
# time cp -a /mnt/oden/etc .
real    49m17.077s
user    0m0.010s
sys     0m0.089s

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
964        548        0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 241    25% 0       0% 0       0% 236    24% 5       0% 
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
    5714 total packets received
    0 forwarded
    0 incoming packets discarded
    1029 incoming packets delivered
    1585 requests sent out
    446 fragments dropped after timeout
    2664 reassemblies required
    332 packets reassembled ok
    446 packet reassembles failed
Icmp:
    0 ICMP messages received
    0 input ICMP message failed.
    ICMP input histogram:
    7 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        time exceeded: 7
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
    1024 packets received
    0 packets to unknown port received.
    0 packet receive errors
    1572 packets sent
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

===End 2.6.0-test9-trondpatch1===

Mvh
Mats Johannesson
