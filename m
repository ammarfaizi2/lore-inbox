Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287607AbSBKI7s>; Mon, 11 Feb 2002 03:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSBKI7j>; Mon, 11 Feb 2002 03:59:39 -0500
Received: from angband.namesys.com ([212.16.7.85]:3456 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S287607AbSBKI7V>; Mon, 11 Feb 2002 03:59:21 -0500
Date: Mon, 11 Feb 2002 11:59:19 +0300
From: Oleg Drokin <green@namesys.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unix sockets problems in 2.5.4-pre6?
Message-ID: <20020211115919.A963@namesys.com>
In-Reply-To: <20020211111904.A955@namesys.com> <20020211.004953.74751936.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211.004953.74751936.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 11, 2002 at 12:49:53AM -0800, David S. Miller wrote:

> It doesn't help.  You need to find the backtrace of the other process
> holding the lock the AF_UNIX code wants as well, dumping just these
> few processes isn't enough.
Ok. I do not know how to find who is holding teh lock, so here is full list of
processes:

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S C2133F30    48     1      0   761               (NOTLB)
Call Trace: [__pollwait+142/160] [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] 
   [syscall_call+7/11] 
keventd       S C2139424    48     2      1             3       (L-TLB)
Call Trace: [context_thread+326/544] [kernel_thread+40/64] 
ksoftirqd_CPU S F7DEE000    48     3      1             4     2 (L-TLB)
Call Trace: [ksoftirqd+171/240] [kernel_thread+40/64] 
ksoftirqd_CPU S F7DEC000    48     4      1             5     3 (L-TLB)
Call Trace: [ksoftirqd+171/240] [kernel_thread+40/64] 
kswapd        S F7DDC000   816     5      1             6     4 (L-TLB)
Call Trace: [exit_files+49/64] [kswapd+137/196] [kernel_thread+40/64] 
bdflush       S 00000286    48     6      1             7     5 (L-TLB)
Call Trace: [interruptible_sleep_on+78/112] [bdflush+213/224] [kernel_thread+40/64] 
kupdated      S F7D99FCC    48     7      1             9     6 (L-TLB)
Call Trace: [__refile_buffer+84/96] [schedule_timeout+128/160] [process_timeout+0/16] [kupdate+243/384] [kernel_thread+40/64] 
khubd         S 00000286    48     9      1            11     7 (L-TLB)
Call Trace: [interruptible_sleep_on+78/112] [usb_hub_thread+79/176] [kernel_thread+40/64] 
kreiserfsd    S F776DFB4   688    11      1           108     9 (L-TLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [interruptible_sleep_on_timeout+82/128] [reiserfs_journal_commit_thread+261/368] [kernel_thread+40/64] 
scsi_eh_0     S F7349FDC    48   108      1           313    11 (L-TLB)
Call Trace: [__down_interruptible+138/256] [__down_failed_interruptible+7/12] [.text.lock.scsi_error+197/218] [kernel_thread+40/64] 
sshd          S 7FFFFFFF    48   313      1           329   108 (NOTLB)
Call Trace: [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
syslogd       S 7FFFFFFF    52   329      1           332   313 (NOTLB)
Call Trace: [datagram_poll+36/214] [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
klogd         R F7252000    48   332      1           379   329 (NOTLB)
Call Trace: [do_syslog+212/960] [kmsg_read+17/32] [sys_read+150/208] [syscall_call+7/11] 
atd           S F7247F8C   624   379      1           410   332 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [sys_nanosleep+282/481] [syscall_call+7/11] 
in.identd     S 7FFFFFFF    48   410      1   412     570   379 (NOTLB)
Call Trace: [schedule_timeout+20/160] [wait_for_connect+259/480] [tcp_accept+186/576] [inet_accept+44/448] [sys_accept+102/256] 
   [schedule+950/1024] [sys_socketcall+179/512] [syscall_call+7/11] 
in.identd     S F7289F2C    48   412    410   414               (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_poll+197/240] [sys_poll+477/742] [syscall_call+7/11] 
in.identd     S F722FFB0    48   413    412           414       (NOTLB)
Call Trace: [sys_rt_sigsuspend+282/320] [syscall_call+7/11] 
in.identd     S F722DFB0    48   414    412                 413 (NOTLB)
Call Trace: [sys_rt_sigsuspend+282/320] [syscall_call+7/11] 
pickup        Z C212E180    48   522    520           523       (L-TLB)
Call Trace: [do_exit+745/784] [sys_exit+14/16] [syscall_call+7/11] 
qmgr          S F70FBF30    48   523    520           524   522 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
tlsmgr        S F70F5F30  8944   524    520                 523 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
kdm           S F7085FB0   560   570      1   600     599   410 (NOTLB)
Call Trace: [sys_rt_sigsuspend+282/320] [syscall_call+7/11] 
X             S F708BF30    48   596    570           600       (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
ntpd          S 7FFFFFFF    48   599      1           615   570 (NOTLB)
Call Trace: [datagram_poll+36/214] [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
kdm           S F7066000    48   600    570   751           596 (NOTLB)
Call Trace: [pipe_wait+129/176] [pipe_read+179/512] [sys_read+150/208] [syscall_call+7/11] 
cron          S F7039F8C    48   615      1           662   599 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [sys_nanosleep+282/481] [syscall_call+7/11] 
gpm           S F6F69F30    48   662      1           742   615 (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
login         S 00000000    48   742      1   762     743   662 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   743      1   775     744   742 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   744      1   788     745   743 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   745      1   801     746   744 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   746      1   814     747   745 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
login         S 00000000    48   747      1   827     761   746 (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
kdm_greet     S F6E21F30    48   751    600                     (NOTLB)
Call Trace: [schedule_timeout+128/160] [process_timeout+0/16] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
xconsole      S 7FFFFFFF    48   761      1                 747 (NOTLB)
Call Trace: [__pollwait+142/160] [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
bash          S 00000000    48   762    742   840               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
bash          S 7FFFFFFF    48   775    743                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
bash          S 7FFFFFFF   496   788    744                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
bash          S 7FFFFFFF    48   801    745                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
bash          S 00000000    48   814    746   864               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
bash          S 00000000    48   827    747   878               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
su            S 00000000    48   840    762   841               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
bash          S 7FFFFFFF    48   841    840   900               (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
su            S 00000000    48   864    814   865               (NOTLB)
Call Trace: [sys_wait4+958/1024] [syscall_call+7/11] 
bash          S 7FFFFFFF    48   865    864                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [read_chan+892/1920] [read_chan+973/1920] [tty_read+220/320] [sys_read+150/208] 
   [syscall_call+7/11] 
slogin        S 7FFFFFFF    48   878    827                     (NOTLB)
Call Trace: [schedule_timeout+20/160] [do_select+470/544] [sys_select+832/1152] [syscall_call+7/11] 
strace        S 00000000    48   900    841   520               (NOTLB)
Call Trace: [sys_rt_sigaction+152/320] [sys_wait4+958/1024] [syscall_call+7/11] 
master        R F773F744    48   520    900   524               (NOTLB)
Call Trace: [__write_lock_failed+9/32] [.text.lock.open+71/137] [unix_create+92/112] [sock_map_fd+12/304] [select_bits_free+10/16] 
   [sys_socket+29/96] [sys_socket+48/96] [sys_socketcall+99/512] [syscall_call+7/11] 

BTW, this is on SMP.

Bye,
    Oleg
