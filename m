Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266378AbRGFKwd>; Fri, 6 Jul 2001 06:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266374AbRGFKw1>; Fri, 6 Jul 2001 06:52:27 -0400
Received: from picard.csihq.com ([204.17.222.1]:33697 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S266371AbRGFKwK>;
	Fri, 6 Jul 2001 06:52:10 -0400
Message-ID: <004601c10609$c33b72d0$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Cc: "raid" <linux-raid@vger.kernel.org>
Subject: 2.4.6-pre9 lockup
Date: Fri, 6 Jul 2001 06:52:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.6-pre6 with ext3-2.4-0.0.8-246p5
System had been up for almost 3 days.  Couldn't do anything remotely --
console login did work.  No swap was being used.  Couldn't do a graceful
reboot and had to use ALTSYSRQ-B
Here's the ALTSYSRQ-T table:
I know the afio process and updatedb process were both locked up (both of
which hit the disks pretty hard)
System has IDE RAID1, SCSI RAID5 (two sets)
The IDE RAID1 is on ext3, the RAID5's are ext2

Jul  6 06:15:31 yeti kernel:                          free
sibling
Jul  6 06:15:31 yeti kernel:   task             PC    stack   pid father
child younger older
Jul  6 06:15:31 yeti kernel: init          S 7FFFFFFF     0     1      0
148               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_select+458/516] [sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: keventd       S C322E650     0     2      1
3       (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [context_thread+261/452]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: kswapd        S F7BFFFA8    56     3      1
4     2 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+122/156]
[process_timeout+0/92] [interruptible_sleep_on_timeout+78/116]
[kswapd+196/232] [kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: kreclaimd     S 00000286    56     4      1
5     3 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [interruptible_sleep_on+74/108]
[kreclaimd+66/152] [kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: bdflush       S 00000286    76     5      1
6     4 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [md_wakeup_thread+29/32]
[interruptible_sleep_on+74/108] [bdflush+193/196] [kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: kupdated      S F7BD9FC8    76     6      1
7     5 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [do_ide_request+15/20]
[schedule_timeout+122/156] [process_timeout+0/92] [kupdate+134/268]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: scsi_eh_0     S F7A65FDC    12     7      1
8     6 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__down_interruptible+107/236]
[__down_failed_interruptible+7/12] [stext_lock+18241/37756]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: scsi_eh_1     S F7A63FDC    12     8      1
9     7 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__down_interruptible+107/236]
[__down_failed_interruptible+7/12] [stext_lock+18241/37756]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: scsi_eh_2     S F7A61FDC    12     9      1
10     8 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__down_interruptible+107/236]
[__down_failed_interruptible+7/12] [stext_lock+18241/37756]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: mdrecoveryd   S F784E000     4    10      1
11     9 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [md_thread+303/476]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: raid1d        S F7840000    56    11      1
12    10 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [md_thread+303/476]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: kjournald     S 00000286  2432    12      1
42    11 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [interruptible_sleep_on+74/108]
[kjournald+345/460] [commit_timeout+0/12] [kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: crond         S F7269F8C     0    42      1
20389      57    12 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+122/156]
[process_timeout+0/92] [sys_nanosleep+258/372] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: syslogd       S 7FFFFFFF     0    56      1
72    63 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: klogd         R F7224000     0    57      1
59    42 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [do_syslog+188/896]
[kmsg_read+17/24] [sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: rpc.portmap   S 7FFFFFFF     0    59      1
61    57 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_poll+134/220] [do_poll+187/220] [sys_poll+509/784]
[sys_socketcall+484/512] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: inetd         S 7FFFFFFF     0    61      1
15767      63    59 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_select+458/516] [sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: lpd           S 7FFFFFFF     0    63      1
56    61 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [tcp_poll+46/344]
[schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: rpc.mountd    S 7FFFFFFF     0    72      1
75    56 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_poll+134/220] [do_poll+187/220] [sys_poll+509/784] [filp_close+178/188]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: nfsd          S 7FFFFFFF     0    75      1
76      79    72 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: lockd         S 7FFFFFFF     0    76     75
77               (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: rpciod        S 00000001  2432    77     76
(L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: rpc.statd     S 7FFFFFFF     0    79      1
90    75 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [tcp_poll+46/344]
[schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: sendmail      S F6B7DF2C     0    90      1
92    79 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [tcp_poll+46/344]
[schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: httpd         S F6B73F2C     0    92      1
109      98    90 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [smp_apic_timer_interrupt+241/276]
[schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: smbd          S 7FFFFFFF     0    98      1
20758     100    92 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_select+458/516] [sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: nmbd          S F6B37F2C     0   100      1
101     111    98 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: nmbd          S F6B80000     0   101    100
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [do_page_fault+0/1164]
[pipe_wait+125/164] [pipe_read+176/516] [sys_read+143/196]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: httpd         S 7FFFFFFF     0   105     92
106       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[wait_for_connect+270/468] [tcp_accept+193/572] [inet_accept+44/440]
[sys_accept+102/252] [do_page_fault+0/1164] [do_munmap+88/600]
Jul  6 06:15:31 yeti kernel:        [sys_rt_sigaction+138/220]
[sys_socketcall+180/512] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: httpd         S 7FFFFFFF     0   106     92
107   105 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[wait_for_connect+270/468] [tcp_accept+193/572] [inet_accept+44/440]
[sys_accept+102/252] [do_page_fault+0/1164]
[free_page_and_swap_cache+188/192]
Jul  6 06:15:31 yeti kernel:        [zap_page_range+446/596]
[do_munmap+88/600] [sys_rt_sigaction+138/220] [sys_socketcall+180/512]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: httpd         S 7FFFFFFF     4   107     92
108   106 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[wait_for_connect+270/468] [tcp_accept+193/572] [inet_accept+44/440]
[sys_accept+102/252] [do_page_fault+0/1164]
[free_page_and_swap_cache+188/192]
Jul  6 06:15:31 yeti kernel:        [zap_page_range+446/596]
[do_munmap+88/600] [sys_rt_sigaction+138/220] [sys_socketcall+180/512]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: httpd         S 7FFFFFFF     0   108     92
109   107 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[wait_for_connect+270/468] [tcp_accept+193/572] [inet_accept+44/440]
[sys_accept+102/252] [do_page_fault+0/1164]
[free_page_and_swap_cache+188/192]
Jul  6 06:15:31 yeti kernel:        [zap_page_range+446/596]
[do_munmap+88/600] [sys_rt_sigaction+138/220] [sys_socketcall+180/512]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: httpd         S 7FFFFFFF     0   109     92
108 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[wait_for_connect+270/468] [tcp_accept+193/572] [inet_accept+44/440]
[sys_accept+102/252] [do_page_fault+0/1164]
[free_page_and_swap_cache+188/192]
Jul  6 06:15:31 yeti kernel:        [zap_page_range+446/596]
[do_munmap+88/600] [sys_rt_sigaction+138/220] [sys_socketcall+180/512]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: ntpd          S 7FFFFFFF     0   111      1
113     115   100 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_select+458/516] [sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: ntpd          S F6AF9F28     0   113    111
114               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[schedule_timeout+122/156] [process_timeout+0/92] [do_poll+187/220]
[sys_poll+509/784] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: ntpd          S F6AE1F8C     0   114    113
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+122/156]
[process_timeout+0/92] [sys_nanosleep+258/372] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: iplog         S 7FFFFFFF     0   115      1
118     124   111 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_select+56/516] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: msql2d        S 7FFFFFFF     0   116      1
143   130 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: iplog         S F6AD7F28     0   118    115
121               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[schedule_timeout+122/156] [process_timeout+0/92] [do_poll+187/220]
[sys_poll+509/784] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: iplog         S F6AD3FB0     0   119    118
120       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_rt_sigsuspend+251/280]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: iplog         S F6ACFF2C     0   120    118
121   119 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+122/156]
[process_timeout+0/92] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: iplog         S 7FFFFFFF     0   121    118
120 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_IRQ+198/236] [wait_for_packet+210/320] [skb_recv_datagram+204/236]
[packet_recvmsg+103/300] [sock_recvmsg+61/172] [sys_recvfrom+173/264]
Jul  6 06:15:31 yeti kernel:        [kill_something_info+240/256]
[sys_kill+77/88] [do_IRQ+219/236] [sock_ioctl+94/132]
[sys_socketcall+387/512] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: snmpd         S 7FFFFFFF     0   124      1
126   115 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[do_select+458/516] [sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: qla2100_dpc_3 S F6A9DFD8     0   126      1
136   124 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [vsprintf+830/876]
[__down_interruptible+107/236] [__down_failed_interruptible+7/12]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: tempwatch     S F6AE5F8C     0   130      1
116   138 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [unmap_fixup+316/344]
[schedule_timeout+122/156] [process_timeout+0/92] [sys_nanosleep+258/372]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: sshd          S 7FFFFFFF     0   136      1
138   126 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [tcp_poll+46/344]
[schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: raid5d        S F6692000     0   138      1
130   136 (L-TLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [md_thread+303/476]
[kernel_thread+40/56]
Jul  6 06:15:31 yeti kernel: tcsh          S 7FFFFFFF     0   143      1
144   116 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[read_chan+942/1876] [tty_read+206/300] [sys_read+143/196]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: agetty        S 7FFFFFFF    16   144      1
145   143 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[write_chan+448/552] [read_chan+942/1876] [tty_read+206/300]
[sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: agetty        S 7FFFFFFF     0   145      1
146   144 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[write_chan+448/552] [read_chan+942/1876] [tty_read+206/300]
[sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: agetty        S 7FFFFFFF     0   146      1
147   145 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [con_flush_chars+35/52] [schedule_t
imeout+23/156] [write_chan+448/552] [read_chan+942/1876] [tty_read+206/300]
[sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: agetty        S 7FFFFFFF     0   147      1
148   146 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [con_flush_chars+35/52]
[schedule_timeout+23/156] [write_chan+448/552] [read_chan+942/1876]
[tty_read+206/300] [sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: agetty        S 7FFFFFFF     0   148      1
147 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[write_chan+448/552] [read_chan+942/1876] [tty_read+206/300]
[sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: in.telnetd    S 7FFFFFFF  4808   157     61
158     391       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[pty_chars_in_buffer+32/56] [schedule_timeout+23/156] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          S F626BFB0     0   158    157
20743               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_rt_sigsuspend+251/280]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: in.telnetd    S 7FFFFFFF   512   391     61
392    4161   157 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[pty_chars_in_buffer+32/56] [schedule_timeout+23/156] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          S E9FCDFB0    24   392    391
20744               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_rt_sigsuspend+251/280]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: in.telnetd    S 7FFFFFFF     0  4161     61
4162   15767   391 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[pty_chars_in_buffer+32/56] [normal_poll+259/292] [schedule_timeout+23/156]
[do_select+458/516] [sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          S DDCD3FB0  1408  4162   4161
18088               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_rt_sigsuspend+251/280]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: octave        T 00000014  1408  4833   4162
7053   18088       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [dequeue_signal+116/188]
[do_signal+471/652] [sys_wait4+952/964] [signal_return+20/24]
Jul  6 06:15:31 yeti kernel: less          T 00000014  4520  7053   4833
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [dequeue_signal+116/188]
[do_signal+471/652] [n_tty_ioctl+185/1024] [sys_rt_sigaction+138/220]
[signal_return+20/24]
Jul  6 06:15:31 yeti kernel: in.telnetd    S 7FFFFFFF     0 15767     61
15768          4161 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[pty_chars_in_buffer+32/56] [schedule_timeout+23/156] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          S F26D5FB0     0 15768  15767
20745               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_rt_sigsuspend+251/280]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: octave        S 00000000     0 18088   4162
18103          4833 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_wait4+909/964]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: less          S 7FFFFFFF     0 18103  18088
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [schedule_timeout+23/156]
[read_chan+942/1876] [tty_read+206/300] [sys_read+143/196]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: sh            S 00000000  1408 19074     42
19083   20389       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_wait4+909/964]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: sh            S 00000000     0 19077  19074
19094   19082       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_wait4+909/964]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: tail          S C874E000  2436 19082  19074
19083 19077 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [pipe_wait+125/164]
[pipe_read+176/516] [sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: mail          S D173A000     0 19083  19074
19082 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [pipe_wait+125/164]
[pipe_read+176/516] [sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: cat           S D7162000  4416 19093  19077
19094       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__mark_inode_dirty+42/148]
[pipe_wait+125/164] [pipe_write+201/616] [sys_write+143/196]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: afio          D F785DA1C     0 19094  19077
19093 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [scsi_insert_special_req+26/32]
[__down+108/200] [__down_failed+8/12] [sys_write+143/196]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: sh            S 00000000     0 20389     42
20391         19074 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_wait4+909/964]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: updatedb      S 00000000     0 20391  20389
20397               (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_wait4+909/964]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: updatedb      S 00000000     0 20395  20391
20398   20396       (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [sys_wait4+909/964]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: sort          S CFBD0000     0 20396  20391
20397 20395 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [pipe_wait+125/164]
[pipe_read+176/516] [sys_read+143/196] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: frcode        S E87A0000     0 20397  20391
20396 (NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [do_page_fault+0/1164]
[pipe_wait+125/164] [pipe_read+176/516] [sys_read+143/196]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: find          D EBE6FEC8     0 20398  20395
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [generic_unplug_device+45/60]
[__lock_page+131/172] [lock_page+23/28] [read_cache_page+204/412]
[ext2_get_page+31/248] [ext2_readpage+0/20] [ext2_readdir+241/660]
Jul  6 06:15:31 yeti kernel:        [vfs_readdir+150/248] [filldir64+0/268]
[sys_getdents64+79/184] [filldir64+0/268] [sys_fcntl64+127/136]
[system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          D DED8FD1C     0 20743    158
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [generic_unplug_device+45/60]
[__lock_page+131/172] [lock_page+23/28] [read_cache_page+204/412]
[ext2_get_page+31/248] [ext2_readpage+0/20] [ext2_find_entry+119/312]
Jul  6 06:15:31 yeti kernel:        [ext2_inode_by_name+27/128]
[ext2_lookup+39/104] [real_lookup+122/284] [path_walk+1529/2096]
[open_exec+42/192] [do_execve+30/492] [do_wp_page+969/1028]
[do_wp_page+985/1028]
Jul  6 06:15:31 yeti kernel:        [handle_mm_fault+153/200]
[do_page_fault+0/1164] [do_page_fault+383/1164] [do_page_fault+0/1164]
[rm_sig_from_queue+20/24] [tty_ioctl+899/920] [getname+93/156]
[sys_execve+47/96]
Jul  6 06:15:31 yeti kernel:        [system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          D E3437D1C     0 20744    392
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [generic_unplug_device+45/60]
[__lock_page+131/172] [lock_page+23/28] [read_cache_page+204/412]
[ext2_get_page+31/248] [ext2_readpage+0/20] [ext2_find_entry+119/312]
Jul  6 06:15:31 yeti kernel:        [ext2_inode_by_name+27/128]
[ext2_lookup+39/104] [real_lookup+122/284] [path_walk+1529/2096]
[open_exec+42/192] [do_execve+30/492] [do_wp_page+969/1028]
[do_wp_page+985/1028]
Jul  6 06:15:31 yeti kernel:        [handle_mm_fault+153/200]
[do_page_fault+0/1164] [do_page_fault+383/1164] [do_page_fault+0/1164]
[rm_sig_from_queue+20/24] [tty_ioctl+899/920] [getname+93/156]
[sys_execve+47/96]
Jul  6 06:15:31 yeti kernel:        [system_call+51/56]
Jul  6 06:15:31 yeti kernel: tcsh          D D37E047C     0 20745  15768
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__down+108/200]
[__down_failed+8/12] [stext_lock+9425/37756] [path_walk+1529/2096]
[open_exec+42/192] [do_execve+30/492] [do_wp_page+969/1028]
Jul  6 06:15:31 yeti kernel:        [do_wp_page+985/1028]
[handle_mm_fault+153/200] [do_page_fault+0/1164] [do_page_fault+383/1164]
[do_page_fault+0/1164] [rm_sig_from_queue+20/24] [tty_ioctl+899/920]
[getname+93/156]
Jul  6 06:15:31 yeti kernel:        [sys_execve+47/96] [system_call+51/56]
Jul  6 06:15:31 yeti kernel: smbd          S DD53DF2C     0 20758     98
(NOTLB)
Jul  6 06:15:31 yeti kernel: Call Trace: [__pollwait+136/144]
[schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516]
[sys_select+832/1148] [system_call+51/56]


________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

