Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278823AbRJaBMU>; Tue, 30 Oct 2001 20:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278818AbRJaBMB>; Tue, 30 Oct 2001 20:12:01 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:19128 "EHLO pltn13.pbi.net")
	by vger.kernel.org with ESMTP id <S278815AbRJaBL7>;
	Tue, 30 Oct 2001 20:11:59 -0500
Date: Tue, 30 Oct 2001 17:12:28 -0800 (PST)
From: Chris Rankin <rankinc@pacbell.net>
Subject: [TRACE] 2.4.13 DVD process stuck in uninterruptible sleep
To: linux-kernel@vger.kernel.org
Message-id: <200110310112.f9V1CS2g000520@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL6]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(My system is a dual 733 PIII with 1.2 GB RAM, devfs. The DVD ROM is
an IDE drive on /dev/hdc, and the ide-cd support is a module.)

Every now and again, my DVD player process (xine) gets stuck in an
uninterruptible sleep state when trying to access the DVD. This time,
I've managed to produce a couple of traces. This first trace is from
before I Ctrl-Alt-Bkspaced my X session:

Oct 30 16:29:33 twopit kernel: hdc: ATAPI 126X DVD-ROM drive, 256kB Cache, UDMA(66)
Oct 30 16:32:10 twopit kernel: SysRq : Show State
Oct 30 16:32:10 twopit kernel: 
Oct 30 16:32:10 twopit kernel:                          free                        sibling
Oct 30 16:32:10 twopit kernel:   task             PC    stack   pid father child younger older
Oct 30 16:32:10 twopit kernel: init          S C2413F2C  3888     1      0 19610       3       (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: keventd       S C2432660  5672     2      1            13       (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [context_thread+277/464] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: ksoftirqd_CPU S C2430000  5956     3      0             4     1 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [ksoftirqd+146/196] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: ksoftirqd_CPU S C242E000  6148     4      0             5     3 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [ksoftirqd+146/196] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: kswapd        S F7BFE000  6360     5      0             6     4 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [kswapd+130/188] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: bdflush       S 00000286  6312     6      0             7     5 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [interruptible_sleep_on+74/108] [bdflush+201/204] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: kupdated      S F7BD9FC8  5448     7      0                   6 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [ext2_update_inode+980/996] [schedule_timeout+122/156] [process_timeout+0/92] [kupdate+163/288] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: devfsd        S 00000000  5644    13      1 19644      95     2 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [sys_wait4+929/984] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: khubd         S 00000286     0    95      1           286    13 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-104664/96] [interruptible_sleep_on+74/108] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-111033/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-104660/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-104660/96] 
Oct 30 16:32:10 twopit kernel:    [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-137921/96] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: syslogd       S 7FFFFFFF  2400   285      1           290   288 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: klogd         R F77D4000  5192   286      1           288    95 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [do_syslog+196/932] [kmsg_read+17/24] [sys_read+143/196] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: rpc.portmap   S 7FFFFFFF     0   288      1           285   286 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/752] [sys_socketcall+484/512] 
Oct 30 16:32:10 twopit kernel:    [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: inetd         S 7FFFFFFF     0   290      1           292   285 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [tcp_poll+46/344] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: lpd           S 7FFFFFFF     0   292      1           295   290 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: rpc.mountd    S 7FFFFFFF  4784   295      1           299   292 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/752] [sys_socketcall+484/512] 
Oct 30 16:32:10 twopit kernel:    [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: nfsd          S 7FFFFFFF  5140   299      1           300   295 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [<f88ee11e>] [<f8906294>] [<f8915d80>] [<f8915d80>] 
Oct 30 16:32:10 twopit kernel:    [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: lockd         S 7FFFFFFF  6208   300      1   301     303   299 (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [reschedule+5/12] [<f88ee11e>] [<f88f9c69>] [kernel_thread+40/56] 
Oct 30 16:32:10 twopit kernel: rpciod        S 00000001  5796   301    300                     (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [<f88ea4f5>] [<f88eb064>] [<f88f4f9c>] [<f88f4f9c>] [<f88f4f94>] 
Oct 30 16:32:10 twopit kernel:    [<f88f4f94>] [kernel_thread+40/56] [<f88f4f9c>] [<f88f4fa8>] 
Oct 30 16:32:10 twopit kernel: rpc.statd     S 7FFFFFFF     0   303      1           305   300 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [tcp_poll+46/344] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: rpc.rquotad   S 7FFFFFFF     0   305      1           310   303 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/752] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: cron          S F7519F88  5088   310      1           316   305 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/92] [sys_nanosleep+272/484] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: sendmail      S F740DF2C     0   316      1           343   310 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [tcp_poll+46/344] [schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516] [sys_select+832/1148] 
Oct 30 16:32:10 twopit kernel:    [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: ntpd          S 7FFFFFFF     0   343      1           345   316 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: xdm           S F73C5FB0     0   345      1 19658     836   343 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [do_fork+1679/1856] [sys_rt_sigsuspend+251/280] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: bash          S 7FFFFFFF     0   852      1         23367   836 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [schedule_timeout+23/156] [con_flush_chars+58/64] [read_chan+942/1876] [tty_read+214/296] [sys_read+143/196] 
Oct 30 16:32:10 twopit kernel:    [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: xterm         D C023C560  5192 23367      1 23372   23375   852 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:32:10 twopit kernel:    [path_walk+26/28] [__user_walk+53/80] [sys_chown+25/72] [sys_close+91/112] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: bash          Z C2415BE0     0 23372  23367                     (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [do_exit+608/636] [do_signal+572/676] [ext2_discard_prealloc+89/144] [sys_rt_sigaction+159/324] [sys_sigreturn+206/248] 
Oct 30 16:32:10 twopit kernel:    [signal_return+20/24] 
Oct 30 16:32:10 twopit kernel: xterm         D C023C560     0 23375      1 23380   11312 23367 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:32:10 twopit kernel:    [path_walk+26/28] [__user_walk+53/80] [sys_chown+25/72] [sys_close+91/112] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: bash          Z F7B3DB20     0 23380  23375                     (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [do_exit+608/636] [do_signal+572/676] [ext2_discard_prealloc+89/144] [sys_rt_sigaction+159/324] [sys_sigreturn+206/248] 
Oct 30 16:32:10 twopit kernel:    [signal_return+20/24] 
Oct 30 16:32:10 twopit kernel: xterm         D C023C560  2404 11312      1 11317   19610 23375 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:32:10 twopit kernel:    [path_walk+26/28] [__user_walk+53/80] [sys_chown+25/72] [sys_close+91/112] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: bash          Z C2415560  2400 11317  11312                     (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [do_exit+608/636] [do_signal+572/676] [ext2_discard_prealloc+89/144] [sys_rt_sigaction+159/324] [sys_sigreturn+206/248] 
Oct 30 16:32:10 twopit kernel:    [signal_return+20/24] 
Oct 30 16:32:10 twopit kernel: xine          D C023C560   736 19610      1 19611         11312 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:32:10 twopit kernel:    [vfs_follow_link+307/408] [devfs_follow_link+70/108] [link_path_walk+1853/2128] [path_walk+26/28] [open_namei+131/1728] [filp_open+59/92] 
Oct 30 16:32:10 twopit kernel:    [sys_open+60/240] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: xine          Z E8096FA0     0 19611  19610                     (L-TLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [do_exit+608/636] [sys_exit+14/16] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: modprobe      D E3037DF8     0 19644     13                     (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [rwsem_down_write_failed+264/304] [stext_lock+14505/27799] [devfs_mk_symlink+54/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-455877/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-474485/96] 
Oct 30 16:32:10 twopit kernel:    [devfs_register+819/832] [<fb36aa53>] [<fb36e380>] [<fb36b49a>] [<fb36b894>] [sys_init_module+1317/1532] 
Oct 30 16:32:10 twopit kernel:    [<fb368060>] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: X             D C023C560  2400 19657    345         19658       (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+596/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:32:10 twopit kernel:    [path_walk+26/28] [open_namei+131/1728] [filp_open+59/92] [sys_open+60/240] [system_call+51/56] 
Oct 30 16:32:10 twopit kernel: xdm           S 7FFFFFFF     0 19658    345               19657 (NOTLB)
Oct 30 16:32:10 twopit kernel: Call Trace: [__pollwait+136/144] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 



This second one is from after I killed X:

Oct 30 16:34:14 twopit kernel: SysRq : Show State
Oct 30 16:34:14 twopit kernel: 
Oct 30 16:34:14 twopit kernel:                          free                        sibling
Oct 30 16:34:14 twopit kernel:   task             PC    stack   pid father child younger older
Oct 30 16:34:14 twopit kernel: init          S C2413F2C  3888     1      0 19610       3       (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: keventd       S C2432660  5672     2      1            13       (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [context_thread+277/464] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: ksoftirqd_CPU S C2430000  5956     3      0             4     1 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [ksoftirqd+146/196] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: ksoftirqd_CPU S C242E000  6148     4      0             5     3 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [ksoftirqd+146/196] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: kswapd        S F7BFE000  6360     5      0             6     4 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [kswapd+130/188] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: bdflush       S 00000286  6312     6      0             7     5 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [interruptible_sleep_on+74/108] [bdflush+201/204] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: kupdated      S F7BD9FC8  5448     7      0                   6 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [ext2_update_inode+980/996] [schedule_timeout+122/156] [process_timeout+0/92] [kupdate+163/288] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: devfsd        S 00000000  5644    13      1 19644      95     2 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [sys_wait4+929/984] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: khubd         S 00000286     0    95      1           286    13 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-104664/96] [interruptible_sleep_on+74/108] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-111033/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-104660/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-104660/96] 
Oct 30 16:34:14 twopit kernel:    [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-137921/96] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: syslogd       D 00000002  2400   285      1           290   288 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [__wait_on_buffer+111/148] [ext2_update_inode+909/996] [ext2_sync_inode+12/20] [ext2_fsync_inode+62/88] [ext2_sync_file+18/24] 
Oct 30 16:34:14 twopit kernel:    [sys_fsync+96/144] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: klogd         S 7FFFFFFF  5192   286      1           288    95 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [unix_wait_for_peer+166/204] [unix_dgram_sendmsg+815/1024] [sock_sendmsg+105/136] [sock_write+178/188] 
Oct 30 16:34:14 twopit kernel:    [sys_write+143/196] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: rpc.portmap   S 7FFFFFFF     0   288      1           285   286 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/752] [sys_socketcall+484/512] 
Oct 30 16:34:14 twopit kernel:    [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: inetd         S 7FFFFFFF     0   290      1           292   285 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [tcp_poll+46/344] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: lpd           S 7FFFFFFF     0   292      1           295   290 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: rpc.mountd    S 7FFFFFFF  4784   295      1           299   292 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/752] [sys_socketcall+484/512] 
Oct 30 16:34:14 twopit kernel:    [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: nfsd          S 7FFFFFFF  5140   299      1           300   295 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [<f88ee11e>] [<f8906294>] [<f8915d80>] [<f8915d80>] 
Oct 30 16:34:14 twopit kernel:    [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: lockd         S 7FFFFFFF  6208   300      1   301     303   299 (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [reschedule+5/12] [<f88ee11e>] [<f88f9c69>] [kernel_thread+40/56] 
Oct 30 16:34:14 twopit kernel: rpciod        S 00000001  5796   301    300                     (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [<f88ea4f5>] [<f88eb064>] [<f88f4f9c>] [<f88f4f9c>] [<f88f4f94>] 
Oct 30 16:34:14 twopit kernel:    [<f88f4f94>] [kernel_thread+40/56] [<f88f4f9c>] [<f88f4fa8>] 
Oct 30 16:34:14 twopit kernel: rpc.statd     S 7FFFFFFF     0   303      1           305   300 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [tcp_poll+46/344] [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: rpc.rquotad   S 7FFFFFFF     0   305      1           310   303 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_poll+134/220] [do_poll+187/220] [sys_poll+477/752] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: cron          S F7519F88  5088   310      1           316   305 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+122/156] [process_timeout+0/92] [sys_nanosleep+272/484] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: sendmail      S F740DF2C     0   316      1           343   310 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [tcp_poll+46/344] [schedule_timeout+122/156] [process_timeout+0/92] [do_select+458/516] [sys_select+832/1148] 
Oct 30 16:34:14 twopit kernel:    [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: ntpd          S 7FFFFFFF     0   343      1           345   316 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [do_select+458/516] [sys_select+832/1148] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: xdm           S F73C5FB0     0   345      1 19657     852   343 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [sys_wait4+972/984] [sys_rt_sigsuspend+251/280] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: bash          S 7FFFFFFF     0   852      1         23367   345 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [schedule_timeout+23/156] [con_flush_chars+58/64] [read_chan+942/1876] [tty_read+214/296] [sys_read+143/196] 
Oct 30 16:34:14 twopit kernel:    [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: xterm         D C023C560  5192 23367      1 23372   23375   852 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:34:14 twopit kernel:    [path_walk+26/28] [__user_walk+53/80] [sys_chown+25/72] [sys_close+91/112] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: bash          Z C2415BE0     0 23372  23367                     (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [do_exit+608/636] [do_signal+572/676] [ext2_discard_prealloc+89/144] [sys_rt_sigaction+159/324] [sys_sigreturn+206/248] 
Oct 30 16:34:14 twopit kernel:    [signal_return+20/24] 
Oct 30 16:34:14 twopit kernel: xterm         D C023C560     0 23375      1 23380   11312 23367 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:34:14 twopit kernel:    [path_walk+26/28] [__user_walk+53/80] [sys_chown+25/72] [sys_close+91/112] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: bash          Z F7B3DB20     0 23380  23375                     (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [do_exit+608/636] [do_signal+572/676] [ext2_discard_prealloc+89/144] [sys_rt_sigaction+159/324] [sys_sigreturn+206/248] 
Oct 30 16:34:14 twopit kernel:    [signal_return+20/24] 
Oct 30 16:34:14 twopit kernel: xterm         D C023C560  2404 11312      1 11317   19610 23375 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:34:14 twopit kernel:    [path_walk+26/28] [__user_walk+53/80] [sys_chown+25/72] [sys_close+91/112] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: bash          Z C2415560  2400 11317  11312                     (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [do_exit+608/636] [do_signal+572/676] [ext2_discard_prealloc+89/144] [sys_rt_sigaction+159/324] [sys_sigreturn+206/248] 
Oct 30 16:34:14 twopit kernel:    [signal_return+20/24] 
Oct 30 16:34:14 twopit kernel: xine          D C023C560   736 19610      1 19611         11312 (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+350/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:34:14 twopit kernel:    [vfs_follow_link+307/408] [devfs_follow_link+70/108] [link_path_walk+1853/2128] [path_walk+26/28] [open_namei+131/1728] [filp_open+59/92] 
Oct 30 16:34:14 twopit kernel:    [sys_open+60/240] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: xine          Z E8096FA0     0 19611  19610                     (L-TLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [do_exit+608/636] [sys_exit+14/16] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: modprobe      D E3037DF8     0 19644     13                     (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [rwsem_down_write_failed+264/304] [stext_lock+14505/27799] [devfs_mk_symlink+54/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-455877/96] [eepro100:__insmod_eepro100_O/lib/modules/2.4.13/kernel/drivers/net/e+-474485/96] 
Oct 30 16:34:14 twopit kernel:    [devfs_register+819/832] [<fb36aa53>] [<fb36e380>] [<fb36b49a>] [<fb36b894>] [sys_init_module+1317/1532] 
Oct 30 16:34:14 twopit kernel:    [<fb368060>] [system_call+51/56] 
Oct 30 16:34:14 twopit kernel: X             D C023C560  2400 19657    345                     (NOTLB)
Oct 30 16:34:14 twopit kernel: Call Trace: [wait_for_devfsd_finished+185/220] [devfs_d_revalidate_wait+226/304] [devfs_lookup+596/632] [real_lookup+122/284] [link_path_walk+1527/2128] 
Oct 30 16:34:14 twopit kernel:    [path_walk+26/28] [open_namei+131/1728] [filp_open+59/92] [sys_open+60/240] [system_call+51/56] 


I hope these traces help narrow down the problem,
Cheers,
Chris
