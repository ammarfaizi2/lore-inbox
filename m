Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbUKPN6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUKPN6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUKPN6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:58:33 -0500
Received: from danga.com ([66.150.15.140]:26041 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S261735AbUKPN4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:56:48 -0500
Date: Tue, 16 Nov 2004 05:56:46 -0800 (PST)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Lisa Phillips <lisa@danga.com>, Mark Smith <marksmith@danga.com>
Subject: Re: 2.6.9: unkillable processes during heavy IO
In-Reply-To: <Pine.LNX.4.58.0411141403040.22805@danga.com>
Message-ID: <Pine.LNX.4.58.0411160549070.7904@danga.com>
References: <Pine.LNX.4.58.0411141403040.22805@danga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the information requested regarding the regular lockup we're
seeing (details in original post at bottom)

# killall -9 mysqld
# killall -9 mysqld
# killall -9 mysqld

  PID WIDE-WCHAN-COLUMN COMMAND
    1 -                 init [2]
    2 migration_thread  [migration/0]
    3 ksoftirqd         [ksoftirqd/0]
    4 migration_thread  [migration/1]
    5 ksoftirqd         [ksoftirqd/1]
    6 worker_thread     [events/0]
    8 worker_thread      \_ [khelper]
    9 worker_thread      \_ [kacpid]
   39 worker_thread      \_ [kblockd/0]
   40 worker_thread      \_ [kblockd/1]
   52 pdflush            \_ [pdflush]
   53 pdflush            \_ [pdflush]
   56 worker_thread      \_ [aio/0]
   57 worker_thread      \_ [aio/1]
    7 worker_thread     [events/1]
 1154 worker_thread      \_ [xfslogd/0]
 1155 worker_thread      \_ [xfslogd/1]
 1156 worker_thread      \_ [xfsdatad/0]
 1157 worker_thread      \_ [xfsdatad/1]
   41 hub_thread        [khubd]
   54 kswapd            [kswapd1]
   55 kswapd            [kswapd0]
  639 serio_thread      [kseriod]
  726 -                 [scsi_eh_0]
  733 -                 [scsi_eh_1]
 1158 -                 [xfsbufd]
 1159 1109149712136     [xfssyncd]
 1160 1109149728520     [xfssyncd]
 1161 kjournald         [kjournald]
 1162 1109157093128     [xfssyncd]
 1163 1109157166856     [xfssyncd]
 1164 1109172895496     [xfssyncd]
 2931 -                 /sbin/syslogd
 2934 syslog            /sbin/klogd
 2942 -                 /usr/sbin/inetd
 3035 -                 /usr/lib/postfix/master
 3040 -                  \_ qmgr -l -t fifo -u -c
 8534 -                  \_ pickup -l -t fifo -u -c
 3045 -                 /usr/sbin/snmpd -Lsd -Lf /dev/null -p /var/run/snmpd.pid
 3051 -                 /usr/sbin/sshd
 6952 -                  \_ sshd: root@pts/1
 6954 -                  |   \_ -bash
 8569 -                  \_ sshd: root@pts/0
 8571 wait                   \_ -bash
 8671 -                          \_ ps afx -o pid,wchan=WIDE-WCHAN-COLUMN,command
 3057 -                 /usr/sbin/atd
 3060 -                 /usr/sbin/cron
 3074 -                 /sbin/getty 38400 tty1
 3076 -                 /sbin/getty 38400 tty2
 3077 -                 /sbin/getty 38400 tty3
 3078 -                 /sbin/getty 38400 tty4
 3079 -                 /sbin/getty 38400 tty5
 3080 -                 /sbin/getty 38400 tty6
 5390 -                 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
 7663 -                 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
 8657 -                 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
 8658 exit               \_ [mysqld] <defunct>


And sysrq t:

 SysRq : Show State

                                                        sibling
   task                 PC          pid father child younger older
 init          S 0000000000000400     0     1      0     2               (NOTLB)
 00000101450bdd88 0000000000000006 0000000000000256 0000010140000700
        0000010140021480 0000000000000000 0000000000000007 ffffffff8015ae20
        0000000000000216 0000000100000246
 Call Trace:<ffffffff8015ae20>{buffered_rmqueue+432} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff8018c170>{sys_select+960} <ffffffff8011195a>{system_call+126}

 migration/0   S 000001000c004720     0     2      1             3       (L-TLB)
 000001000c03bee8 0000000000000046 0000010143860760 0000000000000012
        0000007300000002 ffffffff801335c0 0000010211120810 0000000000000073
        000001000c004740 0000000000000001
 Call Trace:<ffffffff801335c0>{try_to_wake_up+528} <ffffffff8013624a>{migration_thread+202}
        <ffffffff80136180>{migration_thread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff80136180>{migration_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 ksoftirqd/0   S 0000000000000000     0     3      1             4     2 (L-TLB)
 000001023ff93f08 0000000000000046 0000000000000009 ffffffff804079e0
        000000000000000a 0000000000000212 0000000000000212 0000000000000000
        000001000c006940 00000000802f4e80
 Call Trace:<ffffffff8013deb1>{__do_softirq+113} <ffffffff8013e3a0>{ksoftirqd+0}
        <ffffffff8013e3df>{ksoftirqd+63} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8013e3a0>{ksoftirqd+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 migration/1   S 00000101438619a0     0     4      1             5     3 (L-TLB)
 000001023ff95ee8 0000000000000046 000001000c0034e0 0000000000000016
        0000007300000002 ffffffff801335c0 0000010211120810 0000000000000073
        00000101438619c0 0000000100000001
 Call Trace:<ffffffff801335c0>{try_to_wake_up+528} <ffffffff8013624a>{migration_thread+202}
        <ffffffff80136180>{migration_thread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff80136180>{migration_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 ksoftirqd/1   S 0000000000000000     0     5      1             6     4 (L-TLB)
 000001023ffa7f08 0000000000000046 0000000000000212 0000000000000000
        0000000000000000 ffffffff8024cc49 0000000000000000 0000010143863bc0
        0000000000000006 000000018025c186
 Call Trace:<ffffffff8024cc49>{dst_destroy+169} <ffffffff8013deb1>{__do_softirq+113}
        <ffffffff8013e3a0>{ksoftirqd+0} <ffffffff8013e3df>{ksoftirqd+63}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff8013e3a0>{ksoftirqd+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 events/0      S ffffffff801607e0     0     6      1     8       7     5 (L-TLB)
 000001000c08be58 0000000000000046 000001000c08bd88 0000000000000256
        0000007380396e68 0000000000000256 0000000000000212 00000100fbf622c0
        00000100fbf622c0 0000000000000212
 Call Trace:<ffffffff801350f3>{__wake_up+67} <ffffffff801607e0>{cache_reap+0}
        <ffffffff801497ae>{worker_thread+270} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 events/1      S ffffffff801607e0     0     7      1  1154      41     6 (L-TLB)
 000001023fe4de58 0000000000000046 000001013fffee80 ffffffff8015eda7
        0000007700000000 0000000000000012 0000000000000012 000001013fffee80
        0000000000000003 0000000100000212
 Call Trace:<ffffffff8015eda7>{slab_destroy+151} <ffffffff801350f3>{__wake_up+67}
        <ffffffff801607e0>{cache_reap+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 khelper       S 000001023fe26828     0     8      6             9       (L-TLB)
 000001000c08fe58 0000000000000046 00000100ad17dd88 0000000000000212
        0000006a80149390 ffffffff80112446 0000010088e3e810 000000000000006a
        000001000c004740 000000003fe26800
 Call Trace:<ffffffff80112446>{kernel_thread+130} <ffffffff801350f3>{__wake_up+67}
        <ffffffff801124a3>{child_rip+0} <ffffffff80149390>{__call_usermodehelper+0}
        <ffffffff801497ae>{worker_thread+270} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 kacpid        S ffffffff8014de80     0     9      6            39     8 (L-TLB)
 000001014515fe58 0000000000000046 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000100000000
 Call Trace:<ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 kblockd/0     S ffffffff80225400     0    39      6            40     9 (L-TLB)
 000001013fe51e58 0000000000000046 000000000000007a ffffffffa00355b2
        0000000000000212 0000000000000000 000000004520e800 0000010140009400
        0000000000000000 0000000045281b40
 Call Trace:<ffffffffa00355b2>{:mptscsih:mptscsih_qcmd+770} <ffffffff801350f3>{__wake_up+67}
        <ffffffff80225400>{as_work_handler+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 kblockd/1     S ffffffff8021e180     0    40      6            52    39 (L-TLB)
 0000010145193e58 0000000000000046 0000000000000216 0000000000000000
        000000004520e800 0000010140009400 0000000000000000 0000010145281b40
        0000010145216000 0000000180224858
 Call Trace:<ffffffff801350f3>{__wake_up+67} <ffffffff8021e180>{blk_unplug_work+0}
        <ffffffff801497ae>{worker_thread+270} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 khubd         S 0000000000000000     0    41      1            54     7 (L-TLB)
 00000101451a5ec8 0000000000000046 00000300801c1ad0 0000000000000001
        000001013ff78400 0000000000000300 000001023fe30600 0000000000000000
        000001013ff78400 000000018022bad6
 Call Trace:<ffffffff8022bdf8>{hub_events+56} <ffffffff8022c1ce>{hub_thread+206}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80133a40>{finish_task_switch+64}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80133aa1>{schedule_tail+17}
        <ffffffff801124ab>{child_rip+8} <ffffffff8022c100>{hub_thread+0}
        <ffffffff801124a3>{child_rip+0}
 pdflush       S ffffffff8014de80     0    52      6            53    40 (L-TLB)
 000001013fe83eb8 0000000000000046 0000000000000000 000000002faef350
        0000006c00000000 0000000000ff347f 000001023fe25810 000000000000006c
        000001000c004740 0000000000ff347f
 Call Trace:<ffffffff801335c0>{try_to_wake_up+528} <ffffffff80132d0a>{task_rq_lock+74}
        <ffffffff8015d220>{pdflush+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8015d0ea>{__pdflush+170} <ffffffff8015d23c>{pdflush+28}
        <ffffffff8015d220>{pdflush+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8015d220>{pdflush+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 pdflush       S ffffffff8014de80     0    53      6            56    52 (L-TLB)
 000001013fe85eb8 0000000000000046 0000000000000216 ffffffff801417ef
        00000000fffffffc 00000000000011bc 000001013fe85e48 000000010794cb83
        00000000fffffffc 0000000100000212
 Call Trace:<ffffffff801417ef>{__mod_timer+303} <ffffffff8015d220>{pdflush+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff8015d0ea>{__pdflush+170}
        <ffffffff8015d23c>{pdflush+28} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8015d220>{pdflush+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 aio/0         S 000001013fe4a028     0    56      6            57    53 (L-TLB)
 000001013fe89e58 0000000000000046 0000000000000000 0000000000000000
        0000006c00000000 0000000000000000 000001014518d810 000000000000006c
        000001000c004740 0000000000000000
 Call Trace:<ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 kswapd1       S 0000010140001798     0    54      1            55    41 (L-TLB)
 000001013fe87eb8 0000000000000046 ffffffff802f5f48 ffffffff80162255
        000000790000000c 0000000000000001 00000101cb7ef7d0 0000000000000079
        00000101438619c0 00000001000f5995
 Call Trace:<ffffffff80162255>{shrink_slab+341} <ffffffff80163692>{balance_pgdat+2}
        <ffffffff80163ad5>{kswapd+261} <ffffffff80136a00>{autoremove_wake_function+0}
        <ffffffff80133a40>{finish_task_switch+64} <ffffffff80136a00>{autoremove_wake_function+0}
        <ffffffff80133aa1>{schedule_tail+17} <ffffffff801124ab>{child_rip+8}
        <ffffffff801639d0>{kswapd+0} <ffffffff801124a3>{child_rip+0}

 kswapd0       S 0000000000000000     0    55      1           639    54 (L-TLB)
 00000101451b9eb8 0000000000000046 ffffffff802f5f48 ffffffff80162255
        0000008600000004 0000000000000000 000001014000d070 0000000000000086
        000001000c004740 0000000000000b40
 Call Trace:<ffffffff80162255>{shrink_slab+341} <ffffffff80163ad5>{kswapd+261}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80133a40>{finish_task_switch+64}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80133aa1>{schedule_tail+17}
        <ffffffff801124ab>{child_rip+8} <ffffffff801639d0>{kswapd+0}
        <ffffffff801124a3>{child_rip+0}
 aio/1         S ffffffff8014de80     0    57      6                  56 (L-TLB)
 000001013fe8be58 0000000000000046 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000100000000
 Call Trace:<ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 kseriod       S 00000100fbc3df08     0   639      1           726    55 (L-TLB)
 00000100fbc3dec8 0000000000000046 0000003000000008 00000100fbc3ded8
        00000077fbc3de18 ffffffff8013311c 00000100fbd177d0 0000000000000077
        000001000c004740 00000000000927c0
 Call Trace:<ffffffff8013311c>{deactivate_task+44} <ffffffff8020f7b6>{serio_thread+246}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80133a40>{finish_task_switch+64}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80133aa1>{schedule_tail+17}
        <ffffffff801124ab>{child_rip+8} <ffffffff8020f6c0>{serio_thread+0}
        <ffffffff801124a3>{child_rip+0}
 scsi_eh_0     S 000001014527ff18     0   726      1           733   639 (L-TLB)
 000001014527fe48 0000000000000046 0000000000000000 0000000000000000
        0000007500000000 00000100fbc44baa 000001000565c810 0000000000000075
        00000101438619c0 0000000100000000
 Call Trace:<ffffffff8029b521>{__down_interruptible+209} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8029cab5>{__down_failed_interruptible+53}
        <ffffffffa000d143>{:scsi_mod:.text.lock.scsi_error+45}
        <ffffffff801124ab>{child_rip+8} <ffffffffa000cd80>{:scsi_mod:scsi_error_handler+0}
        <ffffffff801124a3>{child_rip+0}
 scsi_eh_1     S 000001013fd47f18     0   733      1          1158   726 (L-TLB)
 000001013fd47e48 0000000000000046 0000000000000000 0000000000000000
        0000007700000000 000001000565c44a 000001000565c810 0000000000000077
        000001000c004740 0000000000000000
 Call Trace:<ffffffff8029b521>{__down_interruptible+209} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8029cab5>{__down_failed_interruptible+53}
        <ffffffffa000d143>{:scsi_mod:.text.lock.scsi_error+45}
        <ffffffff801124ab>{child_rip+8} <ffffffffa000cd80>{:scsi_mod:scsi_error_handler+0}
        <ffffffff801124a3>{child_rip+0}
 xfslogd/0     S ffffffffa013c820     0  1154      7          1155       (L-TLB)
 00000100fbc41e58 0000000000000046 000001023e911740 ffffffffa01232e0
        000001013dcc1090 000001023ee5a458 000001023e90c800 000001023e547040
        0000000000000212 00000000801c574e
 Call Trace:<ffffffffa01232e0>{:xfs:xfs_log_move_tail+80} <ffffffff801350f3>{__wake_up+67}
        <ffffffffa013c820>{:xfs:pagebuf_iodone_work+0} <ffffffffa013c820>{:xfs:pagebuf_iodone_work+0}
        <ffffffff801497ae>{worker_thread+270} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 xfslogd/1     S ffffffffa013c820     0  1155      7          1156  1154 (L-TLB)
 000001023e915e58 0000000000000046 000001023e911b00 ffffffffa01232e0
        000001023de55050 000001023ee5a668 000001023e90c880 000001023e547580
        0000000000000212 00000001801c574e
 Call Trace:<ffffffffa01232e0>{:xfs:xfs_log_move_tail+80} <ffffffff801350f3>{__wake_up+67}
        <ffffffffa013c820>{:xfs:pagebuf_iodone_work+0} <ffffffffa013c820>{:xfs:pagebuf_iodone_work+0}
        <ffffffff801497ae>{worker_thread+270} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff8014de42>{kthread+146} <ffffffff801124ab>{child_rip+8}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014ddb0>{kthread+0} <ffffffff801124a3>{child_rip+0}

 xfsdatad/0    S ffffffff8014de80     0  1156      7          1157  1155 (L-TLB)
 000001013ff61e58 0000000000000046 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000
 Call Trace:<ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 xfsdatad/1    S 000001023e90c0a8     0  1157      7                1156 (L-TLB)
 000001000c3f1e58 0000000000000046 0000000000000010 0000000000000000
        0000006d00000008 0000000000000000 000001023f64a7d0 000000000000006d
        00000101438619c0 0000000100002620
 Call Trace:<ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801497ae>{worker_thread+270}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff801496a0>{worker_thread+0}
        <ffffffff8014de80>{keventd_create_kthread+0} <ffffffff8014de42>{kthread+146}
        <ffffffff801124ab>{child_rip+8} <ffffffff8014de80>{keventd_create_kthread+0}
        <ffffffff801496a0>{worker_thread+0} <ffffffff8014ddb0>{kthread+0}
        <ffffffff801124a3>{child_rip+0}
 xfsbufd       S 0000000000508ae0     0  1158      1          1159   733 (L-TLB)
 0000010005645e98 0000000000000046 000001013ff8ca80 0000010145216330
        000001014000ae00 0000000000000000 00000000000000dd ffffffffa00355b2
        0000000000000212 0000000100000000
 Call Trace:<ffffffffa00355b2>{:mptscsih:mptscsih_qcmd+770} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffffa013d5f4>{:xfs:pagebuf_daemon+148} <ffffffff801124ab>{child_rip+8}
        <ffffffffa013d560>{:xfs:pagebuf_daemon+0} <ffffffff801124a3>{child_rip+0}

 xfssyncd      S 0000000000007530     0  1159      1          1160  1158 (L-TLB)
 000001023e797e88 0000000000000046 0000010140009e50 ffffffffffffff00
        000000748029cc23 0000000000000010 000001023d921070 0000000000000074
        00000101438619c0 00000001a0125b3e
 Call Trace:<ffffffff801417ef>{__mod_timer+303} <ffffffff8029c7ed>{schedule_timeout+173}
        <ffffffff801423c0>{process_timeout+0} <ffffffffa01427be>{:xfs:xfssyncd+142}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffff801124ab>{child_rip+8}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffffa0142730>{:xfs:xfssyncd+0}
        <ffffffff801124a3>{child_rip+0}
 xfssyncd      S 0000000000007530     0  1160      1          1161  1159 (L-TLB)
 000001023e79be88 0000000000000046 000000003ffe3400 000001023ffe3400
        000001013fcb1200 000001023ffe3450 0000000000000002 00000ad900000af6
        0000000000000002 00000001a0125b3e
 Call Trace:<ffffffff801417ef>{__mod_timer+303} <ffffffff8029c7ed>{schedule_timeout+173}
        <ffffffff801423c0>{process_timeout+0} <ffffffffa01427be>{:xfs:xfssyncd+142}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffff801124ab>{child_rip+8}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffffa0142730>{:xfs:xfssyncd+0}
        <ffffffff801124a3>{child_rip+0}
 kjournald     S 000001023ffe4e98     0  1161      1          1162  1160 (L-TLB)
 000001023f6e9e58 0000000000000046 00000101bab75a28 00000101bab75a80
        00000101bab75be0 00000101bab75f50 00000101bab758c8 00000101bab75b88
        00000101bab75d98 00000001bab756b8
 Call Trace:<ffffffff801350f3>{__wake_up+67} <ffffffffa005b2f4>{:jbd:kjournald+532}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80136a00>{autoremove_wake_function+0}
        <ffffffffa005b0c0>{:jbd:commit_timeout+0} <ffffffff801124ab>{child_rip+8}
        <ffffffffa005b0e0>{:jbd:kjournald+0} <ffffffff801124a3>{child_rip+0}

 xfssyncd      S 0000000000007530     0  1162      1          1163  1161 (L-TLB)
 000001023eea1e88 0000000000000046 000001023ffe4c50 ffffffffffffff00
        ffffffffa01259ca 0000000000000010 0000000000000246 000001023eea1df8
        0000000000000018 00000001a0125b3e
 Call Trace:<ffffffffa01259ca>{:xfs:xlog_state_sync_all+90} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffffa01427be>{:xfs:xfssyncd+142} <ffffffffa0142f30>{:xfs:linvfs_fill_super+0}
        <ffffffff801124ab>{child_rip+8} <ffffffffa0142f30>{:xfs:linvfs_fill_super+0}
        <ffffffffa0142730>{:xfs:xfssyncd+0} <ffffffff801124a3>{child_rip+0}

 xfssyncd      S 0000000000007530     0  1163      1          1164  1162 (L-TLB)
 000001023eeb3e88 0000000000000046 000000003ffe4a00 000001023ffe4a00
        000001023e911d40 000001023ffe4a50 0000000000000002 0000000e000041da
        0000000000000002 00000000a0125b3e
 Call Trace:<ffffffff801417ef>{__mod_timer+303} <ffffffff8029c7ed>{schedule_timeout+173}
        <ffffffff801423c0>{process_timeout+0} <ffffffffa01427be>{:xfs:xfssyncd+142}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffff801124ab>{child_rip+8}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffffa0142730>{:xfs:xfssyncd+0}
        <ffffffff801124a3>{child_rip+0}
 xfssyncd      S 0000000000007530     0  1164      1          2931  1163 (L-TLB)
 000001023fdb3e88 0000000000000046 000000003ffe4800 000001023ffe4800
        000001023e911b00 000001023ffe4850 0000000000000002 00000008000068f5
        0000000000000002 00000001a0125b3e
 Call Trace:<ffffffff801417ef>{__mod_timer+303} <ffffffff8029c7ed>{schedule_timeout+173}
        <ffffffff801423c0>{process_timeout+0} <ffffffffa01427be>{:xfs:xfssyncd+142}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffff801124ab>{child_rip+8}
        <ffffffffa0142f30>{:xfs:linvfs_fill_super+0} <ffffffffa0142730>{:xfs:xfssyncd+0}
        <ffffffff801124a3>{child_rip+0}
 syslogd       S 000001013ff51c80     0  2931      1          2934  1164 (NOTLB)
 000001013fa61d88 0000000000000006 0000000100000000 000001023fd5bb50
        000000743e7d0468 0000000000000067 000001000c3a7030 0000000000000074
        000001000c004740 0000000000000246
 Call Trace:<ffffffff8015b19f>{__alloc_pages+831} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff80245bf5>{datagram_poll+21}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff8018c170>{sys_select+960} <ffffffff8011195a>{system_call+126}

 klogd         R  running task       0  2934      1          2942  2931 (NOTLB)
 inetd         S 000001023ef77180     0  2942      1          3035  2934 (NOTLB)
 000001023eb73d88 0000000000000002 0000000000000000 00000000000004f4
        0000007600000007 ffffffff8015ae20 000001023f38c7d0 0000000000000076
        00000101438619c0 0000000140000700
 Call Trace:<ffffffff8015ae20>{buffered_rmqueue+432} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff802640b1>{tcp_poll+33}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff8018c170>{sys_select+960} <ffffffff8011195a>{system_call+126}

 master        S 0000000000036db6     0  3035      1  3040    3045  2942 (NOTLB)
 000001013fa75d88 0000000000000006 0000000000000256 000001013ff84a18
        000001013ff84bf0 0000000100000000 0000000000000007 ffffffff8015ae20
        0000000800000001 0000000000000246
 Call Trace:<ffffffff8015ae20>{buffered_rmqueue+432} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff801350f3>{__wake_up+67} <ffffffff8018c170>{sys_select+960}
        <ffffffff8011195a>{system_call+126}
 qmgr          S 0000000000000060     0  3040   3035          8534       (NOTLB)
 000001023e6bbd88 0000000000000002 0000000000000216 ffffffff802425b4
        000000743e8a95ec 000001023e8a95ec 00000100fbc0f030 0000000000000074
        000001000c004740 0000000000000246
 Call Trace:<ffffffff802425b4>{sock_def_readable+68} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff8018c170>{sys_select+960} <ffffffff8011195a>{system_call+126}

 snmpd         S 00000000000001a8     0  3045      1          3051  3035 (NOTLB)
 000001023e3c1d88 0000000000000006 00000000419a0429 000001023e3c1d78
        000000743e64aa40 000001023e3c1ec8 000001013ff837d0 0000000000000074
        00000101438619c0 0000000100000246
 Call Trace:<ffffffff8029c765>{schedule_timeout+37} <ffffffff8013676c>{add_wait_queue+28}
        <ffffffff8017937b>{fget+91} <ffffffff8018bd33>{do_select+819}
        <ffffffff8018b840>{__pollwait+0} <ffffffff8018c170>{sys_select+960}
        <ffffffff8011195a>{system_call+126}
 sshd          S 000001013f805ac0     0  3051      1  6952    3057  3045 (NOTLB)
 000001023df63d88 0000000000000002 0000000000000256 0000010140000700
        0000007400000007 ffffffff8015ae20 0000010060518070 0000000000000074
        00000101438619c0 0000000140000700
 Call Trace:<ffffffff8015ae20>{buffered_rmqueue+432} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff802640b1>{tcp_poll+33}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff80191b89>{clear_inode+9} <ffffffff8018c170>{sys_select+960}
        <ffffffff8011195a>{system_call+126}
 atd           S 0000000000000000     0  3057      1          3060  3051 (NOTLB)
 000001023e6d7ee8 0000000000000006 0000000000000216 000001023de5d138
        000001023e6d7ef8 ffffffff8018fb11 000001023e6d7e68 000001023e6d7ef8
        0000000000000000 0000000180181ce9
 Call Trace:<ffffffff8018fb11>{dput+33} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffff801424b1>{sys_nanosleep+193} <ffffffff8011195a>{system_call+126}

 cron          S 0000000000000000     0  3060      1          3074  3057 (NOTLB)
 000001023deb7ee8 0000000000000002 0000000000000216 00000101e0d4b3f0
        000001023deb7ef8 ffffffff8018fb97 000001023deb7e68 000001023deb7ef8
        0000007fbffffc70 0000000180181ce9
 Call Trace:<ffffffff8018fb97>{dput+167} <ffffffff801417ef>{__mod_timer+303}
        <ffffffff8029c7ed>{schedule_timeout+173} <ffffffff801423c0>{process_timeout+0}
        <ffffffff801424b1>{sys_nanosleep+193} <ffffffff8011195a>{system_call+126}

 getty         S 000001013fa2cd28     0  3074      1          3076  3060 (NOTLB)
 000001023e59dd78 0000000000000006 000000000000001c ffffffff801575ea
        0000000000000019 000000000000001b 0000000000000000 0000000000000000
        000001023da29348 0000000180157610
 Call Trace:<ffffffff801575ea>{do_generic_mapping_read+1034} <ffffffff80208469>{do_con_write+1657}
        <ffffffff8029c765>{schedule_timeout+37} <ffffffff801d12f2>{vgacon_cursor+242}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff801fcece>{read_chan+926}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff801f6a75>{tty_ldisc_deref+117} <ffffffff801f7870>{tty_read+256}
        <ffffffff80178377>{vfs_read+199} <ffffffff80178623>{sys_read+83}
        <ffffffff8011195a>{system_call+126}
 getty         S 000001023e0fcd28     0  3076      1          3077  3074 (NOTLB)
 000001023d835d78 0000000000000002 000000000000001c ffffffff801575ea
        000001023e0fc000 000000000000001b 0000000000000000 0000000000000000
        000001023da29348 0000000180157610
 Call Trace:<ffffffff801575ea>{do_generic_mapping_read+1034} <ffffffff80208469>{do_con_write+1657}
        <ffffffff8029c765>{schedule_timeout+37} <ffffffff8013676c>{add_wait_queue+28}
        <ffffffff801fcece>{read_chan+926} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff801f6a75>{tty_ldisc_deref+117}
        <ffffffff801f7870>{tty_read+256} <ffffffff80178377>{vfs_read+199}
        <ffffffff80178623>{sys_read+83} <ffffffff8011195a>{system_call+126}

 getty         S 00000100fbca2d28     0  3077      1          3078  3076 (NOTLB)
 000001023d859d78 0000000000000002 000000000000001c ffffffff801575ea
        00000074fbca2000 000000000000001b 000001023d8047d0 0000000000000074
        00000101438619c0 0000000180157610
 Call Trace:<ffffffff801575ea>{do_generic_mapping_read+1034} <ffffffff8013975a>{release_console_sem+138}
        <ffffffff80208469>{do_con_write+1657} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff801fcece>{read_chan+926}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff801f6a75>{tty_ldisc_deref+117} <ffffffff801f7870>{tty_read+256}
        <ffffffff80178377>{vfs_read+199} <ffffffff80178623>{sys_read+83}
        <ffffffff8011195a>{system_call+126}
 getty         S 000001023e7c2d28     0  3078      1          3079  3077 (NOTLB)
 000001023d86bd78 0000000000000002 000000000000001c ffffffff801575ea
        000000743e7c2000 000000000000001b 000001023d804030 0000000000000074
        00000101438619c0 0000000180157610
 Call Trace:<ffffffff801575ea>{do_generic_mapping_read+1034} <ffffffff8013975a>{release_console_sem+138}
        <ffffffff80208469>{do_con_write+1657} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff801fcece>{read_chan+926}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff801f6a75>{tty_ldisc_deref+117} <ffffffff801f7870>{tty_read+256}
        <ffffffff80178377>{vfs_read+199} <ffffffff80178623>{sys_read+83}
        <ffffffff8011195a>{system_call+126}
 getty         S 000001023df85d28     0  3079      1          3080  3078 (NOTLB)
 000001023d88dd78 0000000000000006 000000000000001c ffffffff801575ea
        000000743df85000 000000000000001b 000001023d877810 0000000000000074
        00000101438619c0 0000000180157610
 Call Trace:<ffffffff801575ea>{do_generic_mapping_read+1034} <ffffffff8013975a>{release_console_sem+138}
        <ffffffff80208469>{do_con_write+1657} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff801fcece>{read_chan+926}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff801f6a75>{tty_ldisc_deref+117} <ffffffff801f7870>{tty_read+256}
        <ffffffff80178377>{vfs_read+199} <ffffffff80178623>{sys_read+83}
        <ffffffff8011195a>{system_call+126}
 getty         S 000001023e770d28     0  3080      1          5390  3079 (NOTLB)
 000001023d8a1d78 0000000000000002 000000000000001c ffffffff801575ea
        000001023e770000 000000000000001b 0000000000000000 0000000000000000
        000001023da29348 0000000180157610
 Call Trace:<ffffffff801575ea>{do_generic_mapping_read+1034} <ffffffff80208469>{do_con_write+1657}
        <ffffffff8029c765>{schedule_timeout+37} <ffffffff8013676c>{add_wait_queue+28}
        <ffffffff801fcece>{read_chan+926} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80135030>{default_wake_function+0} <ffffffff801f6a75>{tty_ldisc_deref+117}
        <ffffffff801f7870>{tty_read+256} <ffffffff80178377>{vfs_read+199}
        <ffffffff80178623>{sys_read+83} <ffffffff8011195a>{system_call+126}

 mysqld        D 000001023e034d80     0  5390      1          7663  3080 (NOTLB)
 0000010211817c88 0000000000000002 0000010211817c98 000000003b98c02b
        0000007400000000 0000000000000000 000001023f7d87d0 0000000000000074
        00000101438619c0 0000000100000001
 Call Trace:<ffffffff801335c0>{try_to_wake_up+528} <ffffffff8029c9f4>{__down_write+132}
        <ffffffffa011aaac>{:xfs:xfs_ilock+44} <ffffffffa0141742>{:xfs:xfs_write+594}
        <ffffffff8015b19f>{__alloc_pages+831} <ffffffffa013dc05>{:xfs:linvfs_write+101}
        <ffffffff8017847d>{do_sync_write+173} <ffffffff80167b04>{handle_mm_fault+260}
        <ffffffff801c31fd>{__up_read+29} <ffffffff8029c1fe>{thread_return+41}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80178577>{vfs_write+199}
        <ffffffff801787f8>{sys_pwrite64+104} <ffffffff8011195a>{system_call+126}

 sshd          S 0000000000000198     0  6952   3051  6954    8569       (NOTLB)
 00000101ed1e5d88 0000000000000002 00000101ed1e5ce8 0000010191826278
        000000000055ba80 00000000659d37d0 0000000000000007 ffffffff8015ae20
        00000101ed1e5de8 0000000000000246
 Call Trace:<ffffffff8015ae20>{buffered_rmqueue+432} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffffa0002cf5>{:unix:unix_poll+21}
        <ffffffff8018bd33>{do_select+819} <ffffffff8018b840>{__pollwait+0}
        <ffffffff8018c170>{sys_select+960} <ffffffff8011195a>{system_call+126}

 bash          S 00000100dbcffd28     0  6954   6952                     (NOTLB)
 000001007b57dd78 0000000000000002 000000003ff0da00 00000100000129d0
        000000740000000f 0000010000012700 00000101fd69a070 0000000000000074
        000001000c004740 000000008015a913
 Call Trace:<ffffffff8015a5d7>{free_pages_bulk+663} <ffffffff8029c765>{schedule_timeout+37}
        <ffffffff8013676c>{add_wait_queue+28} <ffffffff801fcece>{read_chan+926}
        <ffffffff80135030>{default_wake_function+0} <ffffffff80135030>{default_wake_function+0}
        <ffffffff80136829>{remove_wait_queue+25} <ffffffff801f7870>{tty_read+256}
        <ffffffff80178377>{vfs_read+199} <ffffffff80178623>{sys_read+83}
        <ffffffff8011195a>{system_call+126}
 mysqld        D 000001022b239db8     0  7663      1          8657  5390 (NOTLB)
 000001009c017ae8 0000000000000002 00000102297ae070 0000000000000001
        000000743ff0d180 00000102297ae070 00000101a76b4030 0000000000000074
        00000101438619c0 00000001297ae070
 Call Trace:<ffffffff8029b3d8>{__down+152} <ffffffff80135030>{default_wake_function+0}
        <ffffffff8029c952>{__down_read+130} <ffffffff8029ca7b>{__down_failed+53}
        <ffffffff8019c6c8>{.text.lock.direct_io+15} <ffffffff801417ef>{__mod_timer+303}
        <ffffffffa013b22a>{:xfs:linvfs_direct_IO+186} <ffffffffa013b150>{:xfs:linvfs_get_blocks_direct+0}
        <ffffffffa0139ee0>{:xfs:linvfs_unwritten_convert_direct+0}
        <ffffffff80266402>{cleanup_rbuf+242} <ffffffff801592e4>{generic_file_direct_IO+100}
        <ffffffff80157816>{__generic_file_aio_read+214} <ffffffff801c31fd>{__up_read+29}
        <ffffffffa014103f>{:xfs:xfs_read+447} <ffffffffa013db23>{:xfs:linvfs_read+99}
        <ffffffff8011115f>{setup_rt_frame+143} <ffffffff8017827d>{do_sync_read+173}
        <ffffffff80133a40>{finish_task_switch+64} <ffffffff8029c1fe>{thread_return+41}
        <ffffffff80136a00>{autoremove_wake_function+0} <ffffffff80178377>{vfs_read+199}
        <ffffffff80178758>{sys_pread64+104} <ffffffff8011195a>{system_call+126}

 pickup        S 0000000000000060     0  8534   3035                3040 (NOTLB)
 00000100b49e5d88 0000000000000002 0000000000000216 ffffffff802425b4
        000001013ff84c2c 000001013ff84c2c 0000000000000007 ffffffff8015ae20
        0000000800000007 0000000100000246
 Call Trace:<ffffffff802425b4>{sock_def_readable+68} <ffffffff8015ae20>{buffered_rmqueue+432}
        <ffffffff801417ef>{__mod_timer+303} <ffffffff8029c7ed>{schedule_timeout+173}
        <ffffffff801423c0>{process_timeout+0} <ffffffff8018bd33>{do_select+819}
        <ffffffff8018b840>{__pollwait+0} <ffffffff8018c170>{sys_select+960}
        <ffffffff8011195a>{system_call+126}
 sshd          S 0000000000000198     0  8569   3051  8571          6952 (NOTLB)
 000001015cffbd88 0000000000000006 000001015cffbce8 0000010005848778
        0000007300573390 0000000011120810 0000010211120810 0000000000000073
        00000101438619c0 0000000100000246
 Call Trace:<ffffffff8029c765>{schedule_timeout+37} <ffffffff8013676c>{add_wait_queue+28}
        <ffffffffa0002cf5>{:unix:unix_poll+21} <ffffffff8018bd33>{do_select+819}
        <ffffffff8018b840>{__pollwait+0} <ffffffff8018c170>{sys_select+960}
        <ffffffff8011195a>{system_call+126}
 bash          R  running task       0  8571   8569                     (NOTLB)
 mysqld        D 0000000000000000     0  8657      1  8658          7663 (NOTLB)
 0000010146e07e80 0000000000000006 0000010146e07e18 0000010146e07e08
        000001023f6c33c0 0000000000000101 000001022b22ac18 0000010146e07e18
        ffffffff8018fb11 0000000100000000
 Call Trace:<ffffffff8018fb11>{dput+33} <ffffffff801859a5>{permission+37}
        <ffffffff801876af>{may_open+95} <ffffffff8029b3d8>{__down+152}
        <ffffffff80135030>{default_wake_function+0} <ffffffff8029ca7b>{__down_failed+53}
        <ffffffff80179053>{.text.lock.read_write+5} <ffffffff80178052>{vfs_llseek+50}
        <ffffffff801780b2>{sys_lseek+82} <ffffffff8011195a>{system_call+126}

 mysqld        Z 000001005b0edf58     0  8658   8657                     (L-TLB)
 000001005b0edde8 0000000000000046 0000000000000001 0000000000000010
        0000007a0c3d7070 0000000000000010 000001007f5c4030 000000000000007a
        00000101438619c0 0000000100000001
 Call Trace:<ffffffff8013b937>{exit_notify+2039} <ffffffff8013bd9b>{do_exit+1003}
        <ffffffff8013bf3c>{do_group_exit+252} <ffffffff801453aa>{get_signal_to_deliver+1082}
        <ffffffff801119e3>{sysret_signal+28} <ffffffff801116ce>{do_signal+142}
        <ffffffff8018b82c>{poll_freewait+76} <ffffffff8018c6ce>{sys_poll+526}
        <ffffffff8018b840>{__pollwait+0} <ffffffff80111ccf>{ptregscall_common+103}






On Sun, 14 Nov 2004, Brad Fitzpatrick wrote:

> We have two database servers which freeze up during heavy IO load.  The
> machines themselves are responsible, but the mysqld processes are forever
> locked, unkillable with even kill -9.  I can't restart with MySQL without
> rebooting the machines.
>
> I can reasonable rule out hardware, since this is happening in the
> same way on two identical machines.
>
> I'd like to know how I can debug this, to file a proper bug report.
>
> The hardware/software stack is:
>
>   - Dual Opteron 246, SMP kernel, w/ NUMA
>   - 9 GB of memory (4GB in one zone, 5GB in the other)
>   - MySQL, running mostly InnoDB, but some MyISAM
>   - MegaRAID raid-10
>   - device mapper
>   - XFS (used as both O_DIRECT from InnoDB and regularly from MyISAM)
>
> At this point I'm going to try changing different variables on
> different machines in order to try and isolate it, but it's a slow
> process.
>
>   - on raw partions, instead of device mapper
>   - ext3 instead of XFS
>   - not using O_DIRECT
>
> "Screenshot":
>
> roast:~# killall -9 mysqld
> roast:~# killall -9 mysqld
> roast:~# ps afx | grep mysqld
> 31495 ?        D      0:08 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root
> --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
> 32391 ?        D      0:01 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root
> --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
>   515 ?        D      0:00 /usr/local/mysql/bin/mysqld --defaults-extra-file=/usr/local/mysql/data/my.cnf --basedir=/usr/local/mysql/ --datadir=/data/mydb --user=root
> --pid-file=/var/run/mysqld/mysqld.pid --skip-locking --port=3306 --socket=/var/run/mysqld/mysqld.sock
>   517 ?        Z      0:00  \_ [mysqld] <defunct>
>
> Next time it hangs like this, how can I get a kernel backtrace or other useful information
> for a certain process?
>
> Thanks!
>
> - Brad
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
