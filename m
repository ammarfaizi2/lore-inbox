Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265039AbTGGP5x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267071AbTGGP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:57:53 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:41401 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265039AbTGGP5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:57:39 -0400
Date: Mon, 7 Jul 2003 18:14:27 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030707161427.GJ7233@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706210243.GA25645@lea.ulyssis.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I tried another time, and this time I have a trace really up close
and personal with the hangup.

Kernel is 2.4.19 (cause Joe has the same hardware running fine with
2.4.19), plain vanilla Linus kernel, using the same config as the 2.4.21
kernel that crashed.

These are the three stack traces leading to the hang:
All the stack traces I got before the crash is some 270K in text,
I added it gzipped in dmesg.gz, maybe it could provide more info.

Jul  7 17:52:52 kalimero kernel: SysRq : Show State
Jul  7 17:52:52 kalimero kernel:
Jul  7 17:52:52 kalimero kernel:                          free                        sibling
Jul  7 17:52:52 kalimero kernel:   task             PC    stack   pid father child younger older
Jul  7 17:52:52 kalimero kernel: init          S C02D0078  4120     1      0  1274               (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [__pollwait+62/176] [process_timeout+0/192] [do_select+276/544] [sys_select+794/1200] Jul  7 17:52:52 kalimero kernel:   [path_release+22/64] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: keventd       S 0006FA72  5216     2      1             3       (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [rest_init+0/144] [context_thread+380/672] [context_thread+0/672] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:52 kalimero kernel:   [context_thread+0/672]
Jul  7 17:52:52 kalimero kernel: ksoftirqd_CPU S F7EEFF8C  5736     3      1             4     2 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_hi_action+99/160] [ksoftirqd+175/256] [kernel_thread+46/64] [ksoftirqd+0/256]
Jul  7 17:52:52 kalimero kernel: ksoftirqd_CPU S F6F7A000  5736     4      1             5     3 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_action+99/160] [ksoftirqd+175/256] [kernel_thread+46/64] [ksoftirqd+0/256]
Jul  7 17:52:52 kalimero kernel: kswapd        S C013F199  5204     5      1             6     4 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [try_to_free_pages+57/96] [kswapd+134/192] [kswapd+0/192] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:52 kalimero kernel:   [kswapd+0/192]
Jul  7 17:52:52 kalimero kernel: bdflush       S 0098993E  6284     6      1             7     5 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/256] [bdflush+335/352] [rest_init+0/144] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:52 kalimero kernel:   [bdflush+0/352]
Jul  7 17:52:52 kalimero kernel: kupdated      D 00000001  5204     7      1             8     6 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__down+192/352] [log_start_commit+216/256] [__down_failed+11/20] [.text.lock.super+279/550] [sync_old_buffers+94/336]
Jul  7 17:52:52 kalimero kernel:   [kupdate+418/480] [kupdate+0/480] [rest_init+0/144] [rest_init+0/144] [kernel_thread+46/64] [kupdate+0/480]
Jul  7 17:52:52 kalimero kernel: scsi_eh_0     S 00000000  6080     8      1             9     7 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [vsnprintf+500/1056] [__down_interruptible+221/416] [__down_failed_interruptible+10/16] [.text.lock.scsi_error+229/290] [kernel_thread+46/64]
Jul  7 17:52:52 kalimero kernel:   [scsi_error_handler+0/608]
Jul  7 17:52:52 kalimero kernel: kjournald     S C94C1C28  4664     9      1            24     8 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [commit_timeout+0/16] [kernel_thread+46/64]
Jul  7 17:52:52 kalimero kernel:   [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel: devfsd        S 00000082  5452    24      1           122     9 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [devfsd_read+223/1040] [free_uid+32/128] [release_task+324/352] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: kjournald     D C02E4000  4624   122      1           123    24 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [journal_commit_transaction+1145/5360] [bh_action+132/224]
Jul  7 17:52:52 kalimero kernel:   [tasklet_hi_action+99/160] [kjournald+490/704] [ret_from_fork+6/32] [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel: kjournald     S 00002F99     4   123      1           124   122 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel: kjournald     S 00003044   484   124      1           125   123 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel: kjournald     S 000030EF     4   125      1           126   124 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel: kjournald     S F7EB8000     4   126      1           176   125 (L-TLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [commit_timeout+0/16]
Jul  7 17:52:52 kalimero kernel:   [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:52 kalimero kernel: portmap       S 00000246  2384   176      1           282   126 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:52 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: syslogd       R F7660914     0   282      1           285   176 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [journal_dirty_sync_data+0/128] [__find_lock_page+75/128] [generic_file_write+1005/1904] [do_readv_writev+691/816] [sys_select+794/1200]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: klogd         R F7666000     0   285      1           316   282 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [sock_sendmsg+115/176] [do_syslog+520/1664] [sock_write+153/176] [sys_read+150/448] [sys_time+29/96]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: 3dmd          S BFFFF9CC  2384   316      1   317     374   285 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+163/176] [sys_rt_sigaction+150/176] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: 3dmd          S C1C12000  2384   317    316   322               (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+88/176] [process_timeout+0/192] [do_poll+158/240] [sys_poll+336/704]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: 3dmd          S C01893EE  2384   318    317           320       (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [journal_dirty_metadata+462/608] [schedule_timeout+163/176] [journal_get_write_access+90/128] [wait_for_connect+576/624] [journal_get_write_access+90/128]
Jul  7 17:52:52 kalimero kernel:   [tcp_accept+490/848] [clean_inode+146/224] [inet_accept+48/640] [sock_alloc+11/192] [sys_accept+111/288] [check_pgt_cache+28/32]
Jul  7 17:52:52 kalimero kernel:   [clear_page_tables+153/176] [do_munmap+708/736] [sys_socketcall+198/576] [sys_munmap+66/96] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: 3dmd          D F7E3AE1C  2388   320    317           322   318 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [wait_for_completion+200/320] [scsi_wait_req+132/176] [scsi_wait_done+0/48] [scsi_allocate_request+71/128] [scsi_ioctl_send_command+556/816]
Jul  7 17:52:52 kalimero kernel:   [scsi_ioctl+317/944] [get_empty_filp+120/528] [sd_ioctl+216/1136] [filp_open+96/112] [blkdev_ioctl+59/64] [sys_ioctl+310/657]Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: 3dmd          S 00000246  2388   322    317                 320 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:52 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: automount     S C0132755  4968   374      1           402   316 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [handle_mm_fault+325/384] [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+163/176] [do_pollfd+92/160]
Jul  7 17:52:52 kalimero kernel:   [do_poll+158/240] [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: automount     S C0132755  2384   402      1           418   374 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [handle_mm_fault+325/384] [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+163/176] [do_pollfd+92/160]
Jul  7 17:52:52 kalimero kernel:   [do_poll+158/240] [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: cupsd         S C02D0078  5124   418      1           596   402 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [do_select+276/544] [sys_select+794/1200] [system_call+51/56] Jul  7 17:52:52 kalimero kernel: inetd         S C02D0078     4   596      1           600   418 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: lpd           S F7209F2C     0   600      1           697   596 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: master        S C02D0078  4496   697      1   701     703   600 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: pickup        S C1C12000  4620   700    697           701       (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/192] [sock_poll+44/64]
Jul  7 17:52:52 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: nqmgr         S F71C3F2C  4620   701    697                 700 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/192] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: nmbd          S C1C12000     0   703      1   704     706   697 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: nmbd          S F7D86430  4464   704    703                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: smbd          S C02D0078     0   706      1           712   703 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: sshd          S C02D0078     0   712      1           726   706 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: rpc.statd     S F6F3DF2C     4   726      1           729   712 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [sys_close+120/144] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: ntpd          S F6F2BF2C     0   729      1   734     732   726 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64]
Jul  7 17:52:52 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [restore_sigcontext+296/320] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: rpc.nfsd      S 00000246     0   732      1           735   729 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:52 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: ntpd          S C02E4000  5336   734    729                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [restore_i387+142/208] [restore_sigcontext+296/320] [sys_rt_sigsuspend+287/320] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: rpc.mountd    S 00000246     0   735      1           741   732 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:52 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: atd           S 00000000     0   741      1           744   735 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [dput+35/480] [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: cron          S F6EC7F1C     0   744      1           749   741 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: kdm           S F6E9BF2C     0   749      1   764     757   744 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S F6F0A000     0   757      1  1094     758   749 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S 00001947  4968   758      1  6471     759   757 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S 00000000  4968   759      1           760   758 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__global_cli+100/112] [schedule_timeout+163/176] [con_flush_chars+132/224] [write_chan+335/512] [read_chan+579/1600]
Jul  7 17:52:52 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S F6E66000  4836   760      1  6971     761   759 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S 00001A02  4968   761      1  6658     766   760 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: XFree86       S C02D0078  4464   762    749           764       (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [tty_ioctl+617/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: kdm           S F718F430     0   764    749  7032           762 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: miniserv.pl   S C02D0078     0   766      1           767   761 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: miniserv.pl   S C02D0078     0   767      1          1274   766 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:52 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: kdm_greet     S FFFFFFFF     0   772    764          7032       (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [do_readv_writev+329/816] [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S F664A000  4620  1094    757  5358               (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: bash          S F7D8C000     0  1274      1  7197           767 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: cp            D F7E3AE1C     0  5358   1094                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [bread+128/144] [read_block_bitmap+88/176]
Jul  7 17:52:52 kalimero kernel:   [__load_block_bitmap+261/400] [do_get_write_access+762/2032] [ext3_new_block+538/2864] [journal_dirty_metadata+462/608] [ext3_do_update_inode+375/1008] [journal_get_write_access+90/128]
Jul  7 17:52:52 kalimero kernel:   [ext3_reserve_inode_write+104/224] [ext3_alloc_block+54/64] [ext3_alloc_branch+74/720] [ext3_get_branch+114/224] [ext3_get_block_handle+369/816] [journal_dirty_metadata+462/608]
Jul  7 17:52:52 kalimero kernel:   [ext3_get_block+71/144] [__block_prepare_write+380/784] [__jbd_kmalloc+37/128] [block_prepare_write+54/144] [ext3_get_block+0/144] [ext3_prepare_write+241/768]
Jul  7 17:52:52 kalimero kernel:   [ext3_get_block+0/144] [add_to_page_cache_unique+178/240] [generic_file_write+1005/1904] [sys_write+150/448] [sys_fstat64+72/128] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: vmstat        S C01361AB    92  6471    758                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [__find_lock_page+75/128] [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: vmstat        S CB1F4000     0  6658    761                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: du            D F7E3AE1C     0  6971    760                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [ext3_bread+148/160] [ext3_readdir+140/992]
Jul  7 17:52:52 kalimero kernel:   [dput+35/480] [link_path_walk+1667/2080] [in_group_p+37/48] [permission+224/240] [cp_new_stat64+227/272] [vfs_readdir+198/336]
Jul  7 17:52:52 kalimero kernel:   [filldir64+0/272] [in_group_p+37/48] [sys_getdents64+83/176] [filldir64+0/272] [dput+35/480] [sys_fchdir+74/272]
Jul  7 17:52:52 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: kdm           D F7E3AE1C     0  7032    764                 772 (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [ext3_find_entry+745/816] [ext3_lookup+52/160]
Jul  7 17:52:52 kalimero kernel:   [real_lookup+262/384] [cached_lookup+27/96] [link_path_walk+1774/2080] [open_namei+1041/2080] [link_path_walk+1667/2080] [filp_open+65/112]
Jul  7 17:52:52 kalimero kernel:   [getname+138/192] [sys_open+77/192] [system_call+51/56]
Jul  7 17:52:52 kalimero kernel: sleep         S 00000000     0  7197   1274                     (NOTLB)
Jul  7 17:52:52 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:53 kalimero kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem showPc unRaw Sync showTasks Unmount
Jul  7 17:52:54 kalimero last message repeated 17 times
Jul  7 17:52:56 kalimero kernel: SysRq : Show State
Jul  7 17:52:56 kalimero kernel:
Jul  7 17:52:56 kalimero kernel:                          free                        sibling
Jul  7 17:52:56 kalimero kernel:   task             PC    stack   pid father child younger older
Jul  7 17:52:56 kalimero kernel: init          S C02D0078  4120     1      0  1274               (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [__pollwait+62/176] [process_timeout+0/192] [do_select+276/544] [sys_select+794/1200] Jul  7 17:52:56 kalimero kernel:   [path_release+22/64] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: keventd       S 0006FBDA  5216     2      1             3       (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [rest_init+0/144] [context_thread+380/672] [context_thread+0/672] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:56 kalimero kernel:   [context_thread+0/672]
Jul  7 17:52:56 kalimero kernel: ksoftirqd_CPU S F7EEFF8C  5736     3      1             4     2 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_hi_action+99/160] [ksoftirqd+175/256] [kernel_thread+46/64] [ksoftirqd+0/256]
Jul  7 17:52:56 kalimero kernel: ksoftirqd_CPU S F6F7A000  5736     4      1             5     3 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_action+99/160] [ksoftirqd+175/256] [kernel_thread+46/64] [ksoftirqd+0/256]
Jul  7 17:52:56 kalimero kernel: kswapd        S C013F199  5204     5      1             6     4 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [try_to_free_pages+57/96] [kswapd+134/192] [kswapd+0/192] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:56 kalimero kernel:   [kswapd+0/192]
Jul  7 17:52:56 kalimero kernel: bdflush       S 0098993E  6284     6      1             7     5 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/256] [bdflush+335/352] [rest_init+0/144] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:56 kalimero kernel:   [bdflush+0/352]
Jul  7 17:52:56 kalimero kernel: kupdated      D 00000001  5204     7      1             8     6 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__down+192/352] [log_start_commit+216/256] [__down_failed+11/20] [.text.lock.super+279/550] [sync_old_buffers+94/336]
Jul  7 17:52:56 kalimero kernel:   [kupdate+418/480] [kupdate+0/480] [rest_init+0/144] [rest_init+0/144] [kernel_thread+46/64] [kupdate+0/480]
Jul  7 17:52:56 kalimero kernel: scsi_eh_0     S 00000000  6080     8      1             9     7 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [vsnprintf+500/1056] [__down_interruptible+221/416] [__down_failed_interruptible+10/16] [.text.lock.scsi_error+229/290] [kernel_thread+46/64]
Jul  7 17:52:56 kalimero kernel:   [scsi_error_handler+0/608]
Jul  7 17:52:56 kalimero kernel: kjournald     S C69A5490  4664     9      1            24     8 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [commit_timeout+0/16] [kernel_thread+46/64]
Jul  7 17:52:56 kalimero kernel:   [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel: devfsd        S 00000082  5452    24      1           122     9 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [devfsd_read+223/1040] [free_uid+32/128] [release_task+324/352] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: kjournald     D C02E4000  4624   122      1           123    24 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [journal_commit_transaction+1145/5360] [bh_action+132/224]
Jul  7 17:52:56 kalimero kernel:   [tasklet_hi_action+99/160] [kjournald+490/704] [ret_from_fork+6/32] [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel: kjournald     S 00002F99     4   123      1           124   122 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel: kjournald     S 00003044   484   124      1           125   123 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel: kjournald     S 000030EF     4   125      1           126   124 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel: kjournald     S F7EB8000     4   126      1           176   125 (L-TLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [commit_timeout+0/16]
Jul  7 17:52:56 kalimero kernel:   [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:56 kalimero kernel: portmap       S 00000246  2384   176      1           282   126 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:56 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: syslogd       S F7667F2C     0   282      1           285   176 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+163/176] [datagram_poll+46/219] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1735712/128]
Jul  7 17:52:56 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: klogd         R F7EF0000     0   285      1           316   282 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [sock_sendmsg+115/176] [do_syslog+520/1664] [sock_write+153/176] [sys_read+150/448] [sys_time+29/96]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: 3dmd          S BFFFF9CC  2384   316      1   317     374   285 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+163/176] [sys_rt_sigaction+150/176] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: 3dmd          S C1C12000  2384   317    316   322               (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+88/176] [process_timeout+0/192] [do_poll+158/240] [sys_poll+336/704]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: 3dmd          S C01893EE  2384   318    317           320       (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [journal_dirty_metadata+462/608] [schedule_timeout+163/176] [journal_get_write_access+90/128] [wait_for_connect+576/624] [journal_get_write_access+90/128]
Jul  7 17:52:56 kalimero kernel:   [tcp_accept+490/848] [clean_inode+146/224] [inet_accept+48/640] [sock_alloc+11/192] [sys_accept+111/288] [check_pgt_cache+28/32]
Jul  7 17:52:56 kalimero kernel:   [clear_page_tables+153/176] [do_munmap+708/736] [sys_socketcall+198/576] [sys_munmap+66/96] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: 3dmd          D F7E3AE1C  2388   320    317           322   318 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [wait_for_completion+200/320] [scsi_wait_req+132/176] [scsi_wait_done+0/48] [scsi_allocate_request+71/128] [scsi_ioctl_send_command+556/816]
Jul  7 17:52:56 kalimero kernel:   [scsi_ioctl+317/944] [get_empty_filp+120/528] [sd_ioctl+216/1136] [filp_open+96/112] [blkdev_ioctl+59/64] [sys_ioctl+310/657]Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: 3dmd          S 00000246  2388   322    317                 320 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:56 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: automount     S C0132755  4968   374      1           402   316 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [handle_mm_fault+325/384] [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+163/176] [do_pollfd+92/160]
Jul  7 17:52:56 kalimero kernel:   [do_poll+158/240] [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: automount     S C0132755  2384   402      1           418   374 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [handle_mm_fault+325/384] [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+163/176] [do_pollfd+92/160]
Jul  7 17:52:56 kalimero kernel:   [do_poll+158/240] [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: cupsd         S C02D0078  5124   418      1           596   402 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [do_select+276/544] [sys_select+794/1200] [system_call+51/56] Jul  7 17:52:56 kalimero kernel: inetd         S C02D0078     4   596      1           600   418 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: lpd           S F7209F2C     0   600      1           697   596 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: master        S C02D0078  4496   697      1   701     703   600 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: pickup        S C1C12000  4620   700    697           701       (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/192] [sock_poll+44/64]
Jul  7 17:52:56 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: nqmgr         S F71C3F2C  4620   701    697                 700 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/192] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: nmbd          S C1C12000     0   703      1   704     706   697 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: nmbd          S F7D86430  4464   704    703                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: smbd          S C02D0078     0   706      1           712   703 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: sshd          S C02D0078     0   712      1           726   706 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: rpc.statd     S F6F3DF2C     4   726      1           729   712 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [sys_close+120/144] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: ntpd          S F6F2BF2C     0   729      1   734     732   726 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64]
Jul  7 17:52:56 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [restore_sigcontext+296/320] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: rpc.nfsd      S 00000246     0   732      1           735   729 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:56 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: ntpd          S C02E4000  5336   734    729                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [restore_i387+142/208] [restore_sigcontext+296/320] [sys_rt_sigsuspend+287/320] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: rpc.mountd    S 00000246     0   735      1           741   732 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:56 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: atd           S 00000000     0   741      1           744   735 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [dput+35/480] [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: cron          S F6EC7F1C     0   744      1           749   741 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: kdm           S F6E9BF2C     0   749      1   764     757   744 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S F6F0A000     0   757      1  1094     758   749 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S 00001947  4968   758      1  6471     759   757 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S 00000000  4968   759      1           760   758 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__global_cli+100/112] [schedule_timeout+163/176] [con_flush_chars+132/224] [write_chan+335/512] [read_chan+579/1600]
Jul  7 17:52:56 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S F6E66000  4836   760      1  6971     761   759 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S 00001A02  4968   761      1  6658     766   760 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: XFree86       S C02D0078  4464   762    749           764       (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [tty_ioctl+617/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: kdm           S F718F430     0   764    749  7032           762 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: miniserv.pl   S C02D0078     0   766      1           767   761 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: miniserv.pl   S C02D0078     0   767      1          1274   766 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:56 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: kdm_greet     S FFFFFFFF     0   772    764          7032       (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [do_readv_writev+329/816] [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S F664A000  4620  1094    757  5358               (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: bash          S F7D8C000     0  1274      1  7218           767 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: cp            D F7E3AE1C     0  5358   1094                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [bread+128/144] [read_block_bitmap+88/176]
Jul  7 17:52:56 kalimero kernel:   [__load_block_bitmap+261/400] [do_get_write_access+762/2032] [ext3_new_block+538/2864] [journal_dirty_metadata+462/608] [ext3_do_update_inode+375/1008] [journal_get_write_access+90/128]
Jul  7 17:52:56 kalimero kernel:   [ext3_reserve_inode_write+104/224] [ext3_alloc_block+54/64] [ext3_alloc_branch+74/720] [ext3_get_branch+114/224] [ext3_get_block_handle+369/816] [journal_dirty_metadata+462/608]
Jul  7 17:52:56 kalimero kernel:   [ext3_get_block+71/144] [__block_prepare_write+380/784] [__jbd_kmalloc+37/128] [block_prepare_write+54/144] [ext3_get_block+0/144] [ext3_prepare_write+241/768]
Jul  7 17:52:56 kalimero kernel:   [ext3_get_block+0/144] [add_to_page_cache_unique+178/240] [generic_file_write+1005/1904] [sys_write+150/448] [sys_fstat64+72/128] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: vmstat        S C01361AB    92  6471    758                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [__find_lock_page+75/128] [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: vmstat        S CB1F4000     0  6658    761                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: du            D F7E3AE1C     0  6971    760                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [ext3_bread+148/160] [ext3_readdir+140/992]
Jul  7 17:52:56 kalimero kernel:   [dput+35/480] [link_path_walk+1667/2080] [in_group_p+37/48] [permission+224/240] [cp_new_stat64+227/272] [vfs_readdir+198/336]
Jul  7 17:52:56 kalimero kernel:   [filldir64+0/272] [in_group_p+37/48] [sys_getdents64+83/176] [filldir64+0/272] [dput+35/480] [sys_fchdir+74/272]
Jul  7 17:52:56 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: kdm           D F7E3AE1C     0  7032    764                 772 (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [ext3_find_entry+745/816] [ext3_lookup+52/160]
Jul  7 17:52:56 kalimero kernel:   [real_lookup+262/384] [cached_lookup+27/96] [link_path_walk+1774/2080] [open_namei+1041/2080] [link_path_walk+1667/2080] [filp_open+65/112]
Jul  7 17:52:56 kalimero kernel:   [getname+138/192] [sys_open+77/192] [system_call+51/56]
Jul  7 17:52:56 kalimero kernel: sleep         S 00000000     0  7218   1274                     (NOTLB)
Jul  7 17:52:56 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: SysRq : Show State
Jul  7 17:52:58 kalimero kernel:
Jul  7 17:52:58 kalimero kernel:                          free                        sibling
Jul  7 17:52:58 kalimero kernel:   task             PC    stack   pid father child younger older
Jul  7 17:52:58 kalimero kernel: init          S C02D0078  4120     1      0  1274               (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [__pollwait+62/176] [process_timeout+0/192] [do_select+276/544] [sys_select+794/1200] Jul  7 17:52:58 kalimero kernel:   [path_release+22/64] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: keventd       S 0006FC2D  5216     2      1             3       (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [rest_init+0/144] [context_thread+380/672] [context_thread+0/672] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:58 kalimero kernel:   [context_thread+0/672]
Jul  7 17:52:58 kalimero kernel: ksoftirqd_CPU S F7EEFF8C  5736     3      1             4     2 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_hi_action+99/160] [ksoftirqd+175/256] [kernel_thread+46/64] [ksoftirqd+0/256]
Jul  7 17:52:58 kalimero kernel: ksoftirqd_CPU S F6F7A000  5736     4      1             5     3 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [bh_action+132/224] [tasklet_action+99/160] [ksoftirqd+175/256] [kernel_thread+46/64] [ksoftirqd+0/256]
Jul  7 17:52:58 kalimero kernel: kswapd        S C013F199  5204     5      1             6     4 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [try_to_free_pages+57/96] [kswapd+134/192] [kswapd+0/192] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:58 kalimero kernel:   [kswapd+0/192]
Jul  7 17:52:58 kalimero kernel: bdflush       S 0098993E  6284     6      1             7     5 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/256] [bdflush+335/352] [rest_init+0/144] [rest_init+0/144] [kernel_thread+46/64]
Jul  7 17:52:58 kalimero kernel:   [bdflush+0/352]
Jul  7 17:52:58 kalimero kernel: kupdated      D 00000001  5204     7      1             8     6 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__down+192/352] [log_start_commit+216/256] [__down_failed+11/20] [.text.lock.super+279/550] [sync_old_buffers+94/336]
Jul  7 17:52:58 kalimero kernel:   [kupdate+418/480] [kupdate+0/480] [rest_init+0/144] [rest_init+0/144] [kernel_thread+46/64] [kupdate+0/480]
Jul  7 17:52:58 kalimero kernel: scsi_eh_0     S 00000000  6080     8      1             9     7 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [vsnprintf+500/1056] [__down_interruptible+221/416] [__down_failed_interruptible+10/16] [.text.lock.scsi_error+229/290] [kernel_thread+46/64]
Jul  7 17:52:58 kalimero kernel:   [scsi_error_handler+0/608]
Jul  7 17:52:58 kalimero kernel: kjournald     S C69A5490  4664     9      1            24     8 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [commit_timeout+0/16] [kernel_thread+46/64]
Jul  7 17:52:58 kalimero kernel:   [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel: devfsd        S 00000082  5452    24      1           122     9 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [devfsd_read+223/1040] [free_uid+32/128] [release_task+324/352] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: kjournald     D C02E4000  4624   122      1           123    24 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [journal_commit_transaction+1145/5360] [bh_action+132/224]
Jul  7 17:52:58 kalimero kernel:   [tasklet_hi_action+99/160] [kjournald+490/704] [ret_from_fork+6/32] [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel: kjournald     S 00002F99     4   123      1           124   122 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel: kjournald     S 00003044   484   124      1           125   123 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel: kjournald     S 000030EF     4   125      1           126   124 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel:   [commit_timeout+0/16] [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel: kjournald     S F7EB8000     4   126      1           176   125 (L-TLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [release_console_sem+285/288] [interruptible_sleep_on+143/256] [kjournald+444/704] [ret_from_fork+6/32] [commit_timeout+0/16]
Jul  7 17:52:58 kalimero kernel:   [kernel_thread+46/64] [kjournald+0/704]
Jul  7 17:52:58 kalimero kernel: portmap       S 00000246  2384   176      1           282   126 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:58 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: syslogd       S F7667F2C     0   282      1           285   176 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+163/176] [datagram_poll+46/219] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1735712/128]
Jul  7 17:52:58 kalimero kernel:   [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: klogd         R 00000000     0   285      1           316   282 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [sock_sendmsg+115/176] [do_syslog+520/1664] [sock_write+153/176] [sys_read+150/448] [sys_time+29/96]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: 3dmd          S BFFFF9CC  2384   316      1   317     374   285 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+163/176] [sys_rt_sigaction+150/176] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: 3dmd          S C1C12000  2384   317    316   322               (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+88/176] [process_timeout+0/192] [do_poll+158/240] [sys_poll+336/704]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: 3dmd          S C01893EE  2384   318    317           320       (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [journal_dirty_metadata+462/608] [schedule_timeout+163/176] [journal_get_write_access+90/128] [wait_for_connect+576/624] [journal_get_write_access+90/128]
Jul  7 17:52:58 kalimero kernel:   [tcp_accept+490/848] [clean_inode+146/224] [inet_accept+48/640] [sock_alloc+11/192] [sys_accept+111/288] [check_pgt_cache+28/32]
Jul  7 17:52:58 kalimero kernel:   [clear_page_tables+153/176] [do_munmap+708/736] [sys_socketcall+198/576] [sys_munmap+66/96] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: 3dmd          D F7E3AE1C  2388   320    317           322   318 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [wait_for_completion+200/320] [scsi_wait_req+132/176] [scsi_wait_done+0/48] [scsi_allocate_request+71/128] [scsi_ioctl_send_command+556/816]
Jul  7 17:52:58 kalimero kernel:   [scsi_ioctl+317/944] [get_empty_filp+120/528] [sd_ioctl+216/1136] [filp_open+96/112] [blkdev_ioctl+59/64] [sys_ioctl+310/657]Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: 3dmd          S 00000246  2388   322    317                 320 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:58 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: automount     S C0132755  4968   374      1           402   316 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [handle_mm_fault+325/384] [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+163/176] [do_pollfd+92/160]
Jul  7 17:52:58 kalimero kernel:   [do_poll+158/240] [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: automount     S C0132755  2384   402      1           418   374 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [handle_mm_fault+325/384] [__get_free_pages+32/48] [__pollwait+62/176] [schedule_timeout+163/176] [do_pollfd+92/160]
Jul  7 17:52:58 kalimero kernel:   [do_poll+158/240] [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: cupsd         S C02D0078  5124   418      1           596   402 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [do_select+276/544] [sys_select+794/1200] [system_call+51/56] Jul  7 17:52:58 kalimero kernel: inetd         S C02D0078     4   596      1           600   418 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: lpd           S F7209F2C     0   600      1           697   596 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: master        S C02D0078  4496   697      1   701     703   600 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: pickup        S C1C12000  4620   700    697           701       (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/192] [sock_poll+44/64]
Jul  7 17:52:58 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [do_setitimer+215/256] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: nqmgr         S F71C3F2C  4620   701    697                 700 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+88/176] [process_timeout+0/192] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: nmbd          S C1C12000     0   703      1   704     706   697 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: nmbd          S F7D86430  4464   704    703                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: smbd          S C02D0078     0   706      1           712   703 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [do_select+276/544] [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: sshd          S C02D0078     0   712      1           726   706 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__pollwait+62/176] [schedule_timeout+163/176] [sock_poll+44/64] [do_select+276/544] [sys_select+794/1200]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: rpc.statd     S F6F3DF2C     4   726      1           729   712 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [sys_close+120/144] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: ntpd          S F6F2BF2C     0   729      1   734     732   726 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [__get_free_pages+32/48] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64]
Jul  7 17:52:58 kalimero kernel:   [do_select+276/544] [sys_select+794/1200] [restore_sigcontext+296/320] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: rpc.nfsd      S 00000246     0   732      1           735   729 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:58 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: ntpd          S C02E4000  5336   734    729                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [restore_i387+142/208] [restore_sigcontext+296/320] [sys_rt_sigsuspend+287/320] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: rpc.mountd    S 00000246     0   735      1           741   732 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [datagram_poll+46/219] [schedule_timeout+163/176] [sock_poll+44/64] [do_pollfd+92/160] [do_poll+158/240]
Jul  7 17:52:58 kalimero kernel:   [sys_poll+336/704] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: atd           S 00000000     0   741      1           744   735 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [dput+35/480] [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: cron          S F6EC7F1C     0   744      1           749   741 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: kdm           S F6E9BF2C     0   749      1   764     757   744 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__alloc_pages+75/416] [schedule_timeout+163/176] [datagram_poll+46/219] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S F6F0A000     0   757      1  1094     758   749 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S 00001947  4968   758      1  6471     759   757 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S 00000000  4968   759      1           760   758 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__global_cli+100/112] [schedule_timeout+163/176] [con_flush_chars+132/224] [write_chan+335/512] [read_chan+579/1600]
Jul  7 17:52:58 kalimero kernel:   [tty_read+352/416] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S F6E66000  4836   760      1  6971     761   759 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S 00001A02  4968   761      1  6658     766   760 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: XFree86       S C02D0078  4464   762    749           764       (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [af_packet:__insmod_af_packet_O/lib/modules/2.4.19/kernel/net/packet/a+-1740386/128] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [tty_ioctl+617/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: kdm           S F718F430     0   764    749  7032           762 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: miniserv.pl   S C02D0078     0   766      1           767   761 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: miniserv.pl   S C02D0078     0   767      1          1274   766 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [datagram_poll+46/219] [process_timeout+0/192] [sock_poll+44/64] [do_select+276/544]
Jul  7 17:52:58 kalimero kernel:   [sys_select+794/1200] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: kdm_greet     S FFFFFFFF     0   772    764          7032       (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [do_readv_writev+329/816] [pipe_wait+122/176] [pipe_read+178/496] [sys_read+150/448] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S F664A000  4620  1094    757  5358               (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: bash          S F7D8C000     0  1274      1  7233           767 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [tty_check_change+66/160] [sys_wait4+303/1056] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: cp            D F7E3AE1C     0  5358   1094                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [bread+128/144] [read_block_bitmap+88/176]
Jul  7 17:52:58 kalimero kernel:   [__load_block_bitmap+261/400] [do_get_write_access+762/2032] [ext3_new_block+538/2864] [journal_dirty_metadata+462/608] [ext3_do_update_inode+375/1008] [journal_get_write_access+90/128]
Jul  7 17:52:58 kalimero kernel:   [ext3_reserve_inode_write+104/224] [ext3_alloc_block+54/64] [ext3_alloc_branch+74/720] [ext3_get_branch+114/224] [ext3_get_block_handle+369/816] [journal_dirty_metadata+462/608]
Jul  7 17:52:58 kalimero kernel:   [ext3_get_block+71/144] [__block_prepare_write+380/784] [__jbd_kmalloc+37/128] [block_prepare_write+54/144] [ext3_get_block+0/144] [ext3_prepare_write+241/768]
Jul  7 17:52:58 kalimero kernel:   [ext3_get_block+0/144] [add_to_page_cache_unique+178/240] [generic_file_write+1005/1904] [sys_write+150/448] [sys_fstat64+72/128] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: vmstat        S C01361AB    92  6471    758                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [__find_lock_page+75/128] [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: vmstat        S CB1F4000     0  6658    761                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_rt_sigprocmask+81/576] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: du            D F7E3AE1C     0  6971    760                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [ext3_bread+148/160] [ext3_readdir+140/992]
Jul  7 17:52:58 kalimero kernel:   [dput+35/480] [link_path_walk+1667/2080] [in_group_p+37/48] [permission+224/240] [cp_new_stat64+227/272] [vfs_readdir+198/336]
Jul  7 17:52:58 kalimero kernel:   [filldir64+0/272] [in_group_p+37/48] [sys_getdents64+83/176] [filldir64+0/272] [dput+35/480] [sys_fchdir+74/272]
Jul  7 17:52:58 kalimero kernel:   [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: kdm           D F7E3AE1C     0  7032    764                 772 (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [generic_make_request+222/320] [submit_bh+94/128] [__wait_on_buffer+94/144] [ext3_find_entry+745/816] [ext3_lookup+52/160]
Jul  7 17:52:58 kalimero kernel:   [real_lookup+262/384] [cached_lookup+27/96] [link_path_walk+1774/2080] [open_namei+1041/2080] [link_path_walk+1667/2080] [filp_open+65/112]
Jul  7 17:52:58 kalimero kernel:   [getname+138/192] [sys_open+77/192] [system_call+51/56]
Jul  7 17:52:58 kalimero kernel: sleep         S 00000000     0  7233   1274                     (NOTLB)
Jul  7 17:52:58 kalimero kernel: Call Trace:    [schedule_timeout+88/176] [process_timeout+0/192] [sys_nanosleep+203/336] [system_call+51/56]
Jul  7 17:52:59 kalimero kernel: 3w-xxxx: scsi0: Unit #0: Command (0xf7dec200) timed out, resetting card.

Here the system hangs (note a lot of Ds ...)

thanks for any help provided.

regards,

Vincent Touquet
