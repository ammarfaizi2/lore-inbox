Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289326AbSBKNiO>; Mon, 11 Feb 2002 08:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289321AbSBKNiF>; Mon, 11 Feb 2002 08:38:05 -0500
Received: from angband.namesys.com ([212.16.7.85]:1152 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289326AbSBKNhu>; Mon, 11 Feb 2002 08:37:50 -0500
Date: Mon, 11 Feb 2002 16:37:40 +0300
From: Oleg Drokin <green@namesys.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unix sockets problems in 2.5.4-pre6?
Message-ID: <20020211163740.A867@namesys.com>
In-Reply-To: <20020211111904.A955@namesys.com> <20020211.004953.74751936.davem@redhat.com> <20020211115919.A963@namesys.com> <20020211.050233.41629715.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211.050233.41629715.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 11, 2002 at 05:02:33AM -0800, David S. Miller wrote:

>    Ok. I do not know how to find who is holding teh lock, so here is
>    full list of processes: 
> Looks like memory corruption.
This is 100% reproducible, so I doubt it is harware problem.
The moment I start fetchmail, master process hangs.
Tried on 2.5.4-pre6 (2.5.4 cannot be compiled for me).
This is another list of processes.
It differs in the respect that some mail arrived, so local
delivery agents started and waiting for some locks, too,
so it may be of some interest.

Bye,
    Oleg

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C2135F30    48     1      0   763               (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
keventd       S C2139424    48     2      1             3       (L-TLB)
Call Trace: [context_thread+326/544] [kernel_thread+40/64] 
ksoftirqd_CPU S F7DEE000    48     3      1             4     2 (L-TLB)
Call Trace: [ksoftirqd+171/240] [kernel_thread+40/64] 
ksoftirqd_CPU S F7DEC000    48     4      1             5     3 (L-TLB)
Call Trace: [ksoftirqd+171/240] [kernel_thread+40/64] 
kswapd        S F7DDE000   816     5      1             6     4 (L-TLB)
Call Trace: [exit_files+49/64] [kswapd+137/196] [kernel_thread+40/64] 
bdflush       S 00000286    48     6      1             7     5 (L-TLB)
Call Trace: [interruptible_sleep_on+78/112] [bdflush+213/224] [kernel_thread+40/64] 
kupdated      D 00000002    48     7      1             9     6 (L-TLB)
Call Trace: [__wait_on_buffer+120/160] [flush_commit_list+951/1248] [do_journal_end+2334/3120] [flush_old_commits+292/320] [reiserfs_write_super+59/128] 
   [sync_supers+216/272] [sync_old_buffers+53/176] [block_prepare_write+80/128] [kupdate+365/384] [kernel_thread+40/64] 
khubd         S 00000286    48     9      1            11     7 (L-TLB)
Call Trace: [interruptible_sleep_on+78/112] [usb_hub_thread+79/176] [kernel_thread+40/64] 
kreiserfsd    S F7771FB4   688    11      1           108     9 (L-TLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [interruptible_sleep_on_timeout+82/128] [reiserfs_journal_commit_thread+261/368] [kernel_thread+40/64] 
scsi_eh_0     S F735BFDC    48   108      1           313    11 (L-TLB)
Call Trace: [__down_interruptible+138/256] [__down_failed_interruptible+7/12] [.text.lock.scsi_error+197/218] [kernel_thread+40/64] 
sshd          S 7FFFFFFF    48   313      1           329   108 (NOTLB)
Call Trace: [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
syslogd       S 7FFFFFFF    48   329      1           332   313 (NOTLB)
Call Trace: [datagram_poll+36/214] [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
klogd         R F7268000    48   332      1           379   329 (NOTLB)
Call Trace: [do_syslog+212/960] [kmsg_read+17/32] [sys_read+150/208] [syscall_call+7/11] 
atd           S F725FF8C   624   379      1           410   332 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [sys_nanosleep+282/481] [syscall_call+7/11] 
in.identd     S 7FFFFFFF    48   410      1   412     520   379 (NOTLB)
Call Trace: [schedule_timeout+20/160] [wait_for_connect+259/480] [tcp_accept+186/576] [inet_accept+44/448] [sys_accept+102/256] 
   [get_empty_filp+212/304] [schedule+950/1024] [sys_socketcall+179/512] [syscall_call+7/11] 
in.identd     S F7245F2C    48   412    410   414               (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_poll+197/240] [sys_poll+477/742] [schedule+950/1024] 
   [syscall_call+7/11] 
in.identd     S F723FFB0    48   413    412           414       (NOTLB)
Call Trace: [sys_rt_sigsuspend+282/320] [syscall_call+7/11] 
in.identd     S F723DFB0    48   414    412                 413 (NOTLB)
Call Trace: [sys_rt_sigsuspend+282/320] [syscall_call+7/11] 
master        R F7246C84    48   520      1   855     571   410 (NOTLB)
Call Trace: [__write_lock_failed+7/32] [.text.lock.open+71/137] [unix_create+92/112] [sock_map_fd+12/304] [select_bits_free+10/16] 
   [sys_socket+29/96] [sys_socket+48/96] [sys_socketcall+99/512] [syscall_call+7/11] 
pickup        S F710BF30     0   522    520           523       (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
qmgr          S F7105F30    48   523    520           524   522 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
tlsmgr        S F70FFF30   544   524    520           563   523 (NOTLB)
Call Trace: [__pollwait+142/160] [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] 
   [syscall_call+7/11] 
trivial-rewri S 7FFFFFFF    48   563    520           564   524 (NOTLB)
Call Trace: [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
smtp          S F70DBF30    48   564    520           849   563 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
kdm           S F7073FB0    48   571      1   602     601   520 (NOTLB)
Call Trace: [sys_rt_sigsuspend+282/320] [syscall_call+7/11] 
X             S F7065F30    48   597    571           602       (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
ntpd          S 7FFFFFFF    48   601      1           617   571 (NOTLB)
Call Trace: [datagram_poll+36/214] [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
kdm           S F707C000    48   602    571   753           597 (NOTLB)
Call Trace: [pipe_wait+129/176] [pipe_read+179/512] [sys_read+150/208] [syscall_call+7/11] 
cron          S F7031F8C   752   617      1   826     664   601 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [sys_nanosleep+282/481] [syscall_call+7/11] 
gpm           S F6F53F30    48   664      1           744   617 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
login         S 00000000    48   744      1   764     745   664 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   745      1   777     746   744 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   746      1   810     747   745 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
mingetty      S 7FFFFFFF    48   747      1           748   746 (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
mingetty      S 7FFFFFFF    48   748      1           749   747 (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
mingetty      S 7FFFFFFF    48   749      1           763   748 (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
kdm_greet     S F6DF7F30    48   753    602                     (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
xconsole      S 7FFFFFFF    48   763      1                 749 (NOTLB)
Call Trace: [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
bash          S 00000000    48   764    744   790               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
bash          S 00000000    48   777    745   805               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
su            S 00000000    48   790    764   791               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
bash          S 7FFFFFFF    48   791    790                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
mutt          S F6B23F30   496   805    777                     (NOTLB)
Call Trace: [normal_poll+259/287] [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] 
   [syscall_call+7/11] 
bash          S 7FFFFFFF    48   810    746                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
cron          Z C212F180    48   825    617           826       (L-TLB)
Call Trace: [do_exit+745/784] [sys_exit+14/16] [syscall_call+7/11] 
cron          Z C212F180   432   826    617                 825 (L-TLB)
Call Trace: [do_exit+745/784] [sys_exit+14/16] [syscall_call+7/11] 
smtpd         S F69A3F30    48   849    520           850   564 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
cleanup       S F6943F30    48   850    520           851   849 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
local         S F690BF50    48   851    520           852   850 (NOTLB)
Call Trace: [interruptible_sleep_on_locked+120/208] [locks_block_on+28/48] [flock_lock_file+242/384] [sys_flock+195/272] [syscall_call+7/11] 
local         S F68E7F30    48   852    520           855   851 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
local         S F68D9F50    48   855    520                 852 (NOTLB)
Call Trace: [interruptible_sleep_on_locked+120/208] [locks_block_on+28/48] [flock_lock_file+242/384] [sys_flock+195/272] [syscall_call+7/11] 
