Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTGAVIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 17:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTGAVIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 17:08:49 -0400
Received: from adsl-66-120-156-55.dsl.lsan03.pacbell.net ([66.120.156.55]:45309
	"EHLO river.fishnet") by vger.kernel.org with ESMTP id S263818AbTGAVIh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 17:08:37 -0400
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, jmorris@redhat.com
Subject: Re: negative tcp_tw_count and other TIME_WAIT weirdness?
References: <200307010025.h610PGmX007656@river.fishnet>
	<20030701.012107.42800729.davem@redhat.com>
	<m3brwedvd9.fsf@river.fishnet> <3F01C1B0.9030901@us.ibm.com>
From: John Salmon <jsalmon@thesalmons.org>
Date: Tue, 01 Jul 2003 14:22:48 -0700
In-Reply-To: <3F01C1B0.9030901@us.ibm.com> (Nivedita Singhvi's message of
 "Tue, 01 Jul 2003 10:15:28 -0700")
Message-ID: <m3of0e3psn.fsf@river.fishnet>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nivedita" == Nivedita Singhvi <niv@us.ibm.com> writes:

Nivedita> John Salmon wrote:
>> Another question - is there any chance that this bug could be
>> responsible for a slowdown in network processing.  Some of my machines
>> get themselves into a state in which their ability to serve
>> network traffic (they're running squid) is significantly reduced -
>> perhaps by a factor of two.  I wish I had more specific data, but at
>> this point it's a mystery.  What I'm really wondering is whether
>> there's any chance at all that this kernel bug could be behind my
>> performance problem, or should I look elsewhere.
>> TIA,
>> John Salmon

Nivedita> John, thanks for the earlier info you gave me, but
Nivedita> could you also give us your netstat -s output? For
Nivedita> example, are you seeing a lot of tcp memory pressure?
Nivedita> aborts? failures?

Thanks for your help.  For comparison, here is /proc/net/sockstat and
netstat -s on two machines that sit behind the same load-balancing switch.
They have nearly identical "life histories", having been rebooted at roughly
the same time and having served the same load-balanced traffic.

First the "bad" machine:

bash-2.05a$ cat /proc/net/sockstat
sockets: used 2374
TCP: inuse 2835 orphan 534 tw -56927 alloc 2874 mem 3299
UDP: inuse 15
RAW: inuse 1
FRAG: inuse 0 memory 0
bash-2.05a$ netstat -s
Ip:
    92668159 total packets received
    0 forwarded
    0 incoming packets discarded
    66026893 incoming packets delivered
    397703978 requests sent out
    337 outgoing packets dropped
    958 fragments dropped after timeout
    8884 reassemblies required
    3377 packets reassembled ok
    958 packet reassembles failed
    822 fragments created
Icmp:
    4980606 ICMP messages received
    28858 input ICMP message failed.
    ICMP input histogram:
        destination unreachable: 839072
        timeout in transit: 293981
        wrong parameters: 87
        source quenches: 25130
        redirects: 12749
        echo requests: 60025
        echo replies: 3720726
    104194 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        destination unreachable: 43382
        time exceeded: 787
        echo replies: 60025
Tcp:
    18144765 active connections openings
    466191160 passive connection openings
    27529643 failed connection attempts
    0 connection resets received
    1543 connections established
    78907521 segments received
    383845607 segments send out
    74153475 segments retransmited
    783367 bad segments received.
    5598827 resets sent
Udp:
    8730241 packets received
    43315 packets to unknown port received.
    2 packet receive errors
    8813412 packets sent
TcpExt:
    4078614 resets received for embryonic SYN_RECV sockets
    8104 packets pruned from receive queue because of socket buffer overrun
    625810 ICMP packets dropped because they were out-of-window
    81 ICMP packets dropped because socket was locked
    ArpFilter: 0
    83528486 TCP sockets finished time wait in fast timer
    38522 time wait sockets recycled by time stamp
    22165 packets rejects in established connections because of timestamp
    27180176 delayed acks sent
    75525 delayed acks further delayed because of locked socket
    Quick ack mode was activated 7753546 times
    8670444 times the listen queue of a socket overflowed
    8670444 SYNs to LISTEN sockets ignored
    3087191 packets directly queued to recvmsg prequeue.
    374684576 packets directly received from backlog
    1469444070 packets directly received from prequeue
    155925439 packets header predicted
    2054464 packets header predicted and directly queued to user
    TCPPureAcks: 1390687464
    TCPHPAcks: 1041606539
    TCPRenoRecovery: 318075
    TCPSackRecovery: 5457027
    TCPSACKReneging: 4409
    TCPFACKReorder: 73152
    TCPSACKReorder: 6041
    TCPRenoReorder: 10565
    TCPTSReorder: 10208
    TCPFullUndo: 20565
    TCPPartialUndo: 49973
    TCPDSACKUndo: 5480
    TCPLossUndo: 357060
    TCPLoss: 3235741
    TCPLostRetransmit: 2133
    TCPRenoFailures: 237140
    TCPSackFailures: 4214831
    TCPLossFailures: 1000832
    TCPFastRetrans: 8033638
    TCPForwardRetrans: 274954
    TCPSlowStartRetrans: 13848605
    TCPTimeouts: 26036253
    TCPRenoRecoveryFail: 68763
    TCPSackRecoveryFail: 1058296
    TCPSchedulerFailed: 2553
    TCPRcvCollapsed: 346121
    TCPDSACKOldSent: 6134270
    TCPDSACKOfoSent: 27839
    TCPDSACKRecv: 9420339
    TCPDSACKOfoRecv: 797
    TCPAbortOnSyn: 55
    TCPAbortOnData: 198545
    TCPAbortOnClose: 49635
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 1800562
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0
bash-2.05a$ 

--------------------------------------------------------------------

And now the "good" machine:

bash-2.05a$ cat /proc/net/sockstat
sockets: used 2150
TCP: inuse 2532 orphan 449 tw 2280 alloc 2566 mem 3101
UDP: inuse 15
RAW: inuse 1
FRAG: inuse 0 memory 0
bash-2.05a$ netstat -s
Ip:
    94540353 total packets received
    0 forwarded
    0 incoming packets discarded
    66756410 incoming packets delivered
    398465484 requests sent out
    337 outgoing packets dropped
    871 fragments dropped after timeout
    3151 reassemblies required
    1140 packets reassembled ok
    871 packet reassembles failed
    180 fragments created
Icmp:
    1278660 ICMP messages received
    31126 input ICMP message failed.
    ICMP input histogram:
        destination unreachable: 662172
        timeout in transit: 452460
        wrong parameters: 76
        source quenches: 23928
        redirects: 6939
        echo requests: 60134
        echo replies: 44310
    207136 ICMP messages sent
    0 ICMP messages failed
    ICMP output histogram:
        destination unreachable: 146131
        time exceeded: 871
        echo replies: 60134
Tcp:
    19378207 active connections openings
    465715267 passive connection openings
    27358745 failed connection attempts
    0 connection resets received
    1309 connections established
    85803162 segments received
    390611031 segments send out
    74510601 segments retransmited
    786167 bad segments received.
    5645248 resets sent
Udp:
    7309738 packets received
    146059 packets to unknown port received.
    2 packet receive errors
    7602730 packets sent
TcpExt:
    4074899 resets received for embryonic SYN_RECV sockets
    8482 packets pruned from receive queue because of socket buffer overrun
    624452 ICMP packets dropped because they were out-of-window
    154 ICMP packets dropped because socket was locked
    ArpFilter: 0
    84152483 TCP sockets finished time wait in fast timer
    44148 time wait sockets recycled by time stamp
    27177 packets rejects in established connections because of timestamp
    26617646 delayed acks sent
    73557 delayed acks further delayed because of locked socket
    Quick ack mode was activated 7738078 times
    8590739 times the listen queue of a socket overflowed
    8590739 SYNs to LISTEN sockets ignored
    3055576 packets directly queued to recvmsg prequeue.
    376439506 packets directly received from backlog
    1450290472 packets directly received from prequeue
    157981680 packets header predicted
    2041314 packets header predicted and directly queued to user
    TCPPureAcks: 1389130959
    TCPHPAcks: 1046357434
    TCPRenoRecovery: 315421
    TCPSackRecovery: 5463448
    TCPSACKReneging: 5224
    TCPFACKReorder: 74038
    TCPSACKReorder: 5839
    TCPRenoReorder: 10784
    TCPTSReorder: 9876
    TCPFullUndo: 20353
    TCPPartialUndo: 49027
    TCPDSACKUndo: 5529
    TCPLossUndo: 369563
    TCPLoss: 3234741
    TCPLostRetransmit: 2123
    TCPRenoFailures: 236125
    TCPSackFailures: 4210084
    TCPLossFailures: 1000244
    TCPFastRetrans: 8048858
    TCPForwardRetrans: 274446
    TCPSlowStartRetrans: 13858727
    TCPTimeouts: 26198657
    TCPRenoRecoveryFail: 67590
    TCPSackRecoveryFail: 1061841
    TCPSchedulerFailed: 2494
    TCPRcvCollapsed: 312192
    TCPDSACKOldSent: 6159451
    TCPDSACKOfoSent: 27150
    TCPDSACKRecv: 9488517
    TCPDSACKOfoRecv: 691
    TCPAbortOnSyn: 40
    TCPAbortOnData: 200595
    TCPAbortOnClose: 49754
    TCPAbortOnMemory: 0
    TCPAbortOnTimeout: 1809213
    TCPAbortOnLinger: 0
    TCPAbortFailed: 0
    TCPMemoryPressures: 0

Nivedita> thanks,
Nivedita> Nivedita

