Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUJ1KhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUJ1KhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbUJ1Kf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:35:29 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29196 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262894AbUJ1KeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:34:10 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Swap strangeness: total VIRT ~23mb for all processes, swap 91156k used - impossible?
Date: Thu, 28 Oct 2004 13:33:53 +0300
User-Agent: KMail/1.5.4
Cc: uclibc@uclibc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281333.53976.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am playing with 'small/beautiful stuff' like
bbox/uclibc.

I ran oom_trigger soon after boot and took
"top b n 1" snapshot after OOM kill.

Output puzzles me: total virtual space taken by *all*
processes is ~23mb yet swap usage is ~90mb.

How that can be? *What* is there? Surely it can't
be a filesystem cache because OOM condition reduces that
to nearly zero.

top output
(note: some of them are busybox'ed, others are compiled
against uclibc, some are statically built with dietlibc,
rest is plain old shared binaries built against glibc):

top - 13:19:32 up 48 min,  1 user,  load average: 0.25, 0.22, 0.09
Tasks:  80 total,   1 running,  79 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.2% us,  0.3% sy,  0.0% ni, 98.7% id,  0.8% wa,  0.0% hi,  0.0% si
Mem:    112376k total,   109620k used,     2756k free,     6460k buffers
Swap:   262136k total,    91156k used,   170980k free,     4700k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
 1204 root      15   0  1652  788 1520 R  2.0  0.7   0:00.01 top                
    1 root      16   0   968   12  892 S  0.0  0.0   0:01.27 init               
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0        
    3 root       5 -10     0    0    0 S  0.0  0.0   0:00.03 events/0           
    4 root       8 -10     0    0    0 S  0.0  0.0   0:00.00 khelper            
   23 root       5 -10     0    0    0 S  0.0  0.0   0:00.01 kblockd/0          
   47 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush            
   48 root      15   0     0    0    0 S  0.0  0.0   0:00.03 pdflush            
   50 root      14 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0              
   49 root      15   0     0    0    0 S  0.0  0.0   0:02.15 kswapd0            
   51 root      15   0     0    0    0 S  0.0  0.0   0:00.00 cifsoplockd        
  125 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kseriod            
  251 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 reiserfs/0         
  273 root      18   0  1212    4 1180 S  0.0  0.0   0:00.00 udevd              
  479 rpc       16   0  1360    4 1308 S  0.0  0.0   0:00.00 rpc.portmap        
  543 root      16   0    52   16   16 S  0.0  0.0   0:00.01 svscan             
  556 root      17   0   348    4  316 S  0.0  0.0   0:00.00 sleep              
  557 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  558 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  559 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  560 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  561 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  563 root      16   0  1260  128 1228 S  0.0  0.1   0:00.02 gpm                
  564 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  565 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  566 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  567 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  568 user0     17   0  1660  772 1520 S  0.0  0.7   0:06.87 top                
  569 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  579 root      16   0  3076 3076 2456 S  0.0  2.7   0:00.02 ntpd               
  580 daemon    17   0    28   24   20 S  0.0  0.0   0:00.00 multilog           
  586 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  588 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  589 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  590 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  594 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  599 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  600 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  605 root      18   0  2492  700 2400 S  0.0  0.6   0:00.10 sshd               
  617 logger    17   0    28   28   20 S  0.0  0.0   0:00.00 multilog           
  624 root      17   0    36   28   16 S  0.0  0.0   0:00.01 socklog            
  632 daemon    17   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  636 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  637 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  643 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  644 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  647 root      16   0    44    4   36 S  0.0  0.0   0:00.00 tcpserver          
  648 apache    15   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  658 daemon    18   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  665 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  666 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  667 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  668 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  669 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  670 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  671 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  672 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  673 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  674 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  675 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  676 logger    16   0    36    4   16 S  0.0  0.0   0:00.00 socklog            
  677 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  678 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  679 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  680 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  681 root      16   0    20    4   16 S  0.0  0.0   0:00.00 supervise          
  685 root      16   0  1400  512 1320 S  0.0  0.5   0:00.02 automount          
  698 daemon    19   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  699 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  704 root      17   0  1824  508 1528 S  0.0  0.5   0:00.01 login              
  715 logger    15   0    28    4   20 S  0.0  0.0   0:00.01 multilog           
  716 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  721 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  725 logger    16   0    28    4   20 S  0.0  0.0   0:00.00 multilog           
  729 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  730 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
  731 root      16   0   708    4  576 S  0.0  0.0   0:00.00 getty              
 1097 root      15   0  1216  576  892 S  0.0  0.5   0:00.01 bash               
 1196 root      15   0     0    0    0 S  0.0  0.0   0:00.00 rpciod             
 1197 root      19   0     0    0    0 S  0.0  0.0   0:00.00 lockd              

oom_trigger.c:

#include <stdlib.h>
int main() {
    void *p;
    unsigned size = 1<<20;
    unsigned long total=0;
    while(size) {
        p = malloc(size);
        if(!p) size>>=1;
        else {
            memset(p, 0x77, size);
            total+=size;
            printf("Allocated %9u bytes, %12lu total\n",size,total);
        }
    }
    return 0;
}

--
vda

