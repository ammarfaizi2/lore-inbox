Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265094AbUD3QGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265094AbUD3QGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3QGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:06:20 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:61618 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265099AbUD3QGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:06:09 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: More on 2.6.6-rc* boot failure
Date: Fri, 30 Apr 2004 18:06:16 +0200
User-Agent: KMail/1.5
References: <20040430152733.26569.qmail@lwn.net>
In-Reply-To: <20040430152733.26569.qmail@lwn.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301806.16643.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 of April 2004 17:27, Jonathan Corbet wrote:
> For those who missed the first episode: my x86_64 system goes into a mad
> oops frenzy as soon as it tries to run init.  Having discovered
> panic_on_oops, I can now actually read the system's complaint.  As it turns
> out, the actual process and call chain is different every time.  The common
> factors, however, are:
>
> 	General protection fault: 0000 [1]
> 	RIP: __switch_to+51
> 	Call trace ends with thread_return+0
>
> Might that ring any bells with anybody, or suggest areas for further
> investigation?
>

I can only confirm this.  On a dual-Opteron box, I always get the following 
call trace for the 2.6.6-rc2-mm2, 2.6.6-rc3 and 2.6.6-rc3-mm1 kernels:

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 176k freed
general protection fault: 0000 [1] SMP
CPU 1
Pid: 1, comm: init Not tainted 2.6.6-rc3
RIP: 0010:[<ffffffff8010cf66>] <ffffffff8010cf66>{__switch_to+86}
RSP: 0000:000001001fdd5da8  EFLAGS: 00010002
RAX: 000001003ff96000 RBX: 000001003fe65598 RCX: 0000000000000100
RDX: 0000000000000001 RSI: 000001003fe65118 RDI: 000001000171f058
RBP: 000001000171f4d8 R08: 000000003ccbf700 R09: 0000000000000000
R10: 00000000002953f8 R11: 0000000000000000 R12: 000001002073c400
R13: 000001003fe65118 R14: 000001000171f058 R15: ffffffff80468340
FS:  0000000000000000(0000) GS:ffffffff8046c480(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004112e0 CR3: 000000003ff95000 CR4: 00000000000006e0
Process init (pid: 1, stackpage=10001720058)
Stack: 0000000100000000 000001003fe65118 000001003fe65118 000001002073c400
       000001002070f5e0 000001003fe65118 0000000376b1cb9b ffffffff80308cf0
       000001001fdd5e78 0000000000000046
Call Trace:<ffffffff80308cf0>{thread_return+0} 
<ffffffff801443a4>{worker_thread+276}
       <ffffffff8012ffe0>{default_wake_function+0} 
<ffffffff8012ffe0>{default_wake_function+0}
       <ffffffff80144290>{worker_thread+0} <ffffffff801481e9>{kthread+217}
       <ffffffff8010ee37>{child_rip+8} 
<ffffffff80148090>{keventd_create_kthread+0}
       <ffffffff80148110>{kthread+0} <ffffffff8010ee2f>{child_rip+0}


Code: 0f ae 87 00 05 00 00 db e2 83 60 14 fe 0f 20 c0 48 83 c8 08
RIP <ffffffff8010cf66>{__switch_to+86} RSP <000001001fdd5da8>
 <0>Kernel panic: Attempted to kill init!
NMI Watchdog detected LOCKUP on CPU1, registers:
CPU 1
Pid: 1, comm: init Not tainted 2.6.6-rc3
RIP: 0010:[<ffffffff80131f68>] <ffffffff80131f68>{.text.lock.sched+170}
RSP: 0000:000001001fdd5998  EFLAGS: 00000086
RAX: 0000000000000080 RBX: 000001001fd7d158 RCX: 000001003fe2bef0
RDX: ffffffff8049c4c0 RSI: 0000000000000007 RDI: 0000000000000000
RBP: 000001001fdd59c8 R08: 0000000000000000 R09: 0000000000000000
R10: 000001001fdd59f8 R11: 0000000000000140 R12: 000001002070f5e0
R13: 000001001fdd59a0 R14: 000001000171f058 R15: ffffffff80468340
FS:  0000000000000000(0000) GS:ffffffff8046c480(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004112e0 CR3: 000000003ff95000 CR4: 00000000000006e0
Process init (pid: 1, stackpage=10001720058)
Stack: ffffffff8043fea0 0000000000000002 0000000000000000 000001000171f058
       000000000000000b 000001000171f058 000000008010e8f7 ffffffff801589e1
       0000000000000001 0000000000000282
Call Trace:<ffffffff801589e1>{pdflush_operation+145} 
<ffffffff8015837f>{wakeup_bdflush+47}
       <ffffffff8017369b>{do_sync+11} <ffffffff8017370e>{sys_sync+14}
       <ffffffff801347b6>{panic+262} <ffffffff8013701d>{do_exit+93}
       <ffffffff8010f8e3>{oops_end+35} <ffffffff801101e5>{die+69}
       <ffffffff801102f7>{do_general_protection+263} 
<ffffffff8010ec81>{error_exit+0}
       <ffffffff8010cf66>{__switch_to+86} <ffffffff80308cf0>{thread_return+0}
       <ffffffff801443a4>{worker_thread+276} 
<ffffffff8012ffe0>{default_wake_function+0}
       <ffffffff8012ffe0>{default_wake_function+0} 
<ffffffff80144290>{worker_thread+0}
       <ffffffff801481e9>{kthread+217} <ffffffff8010ee37>{child_rip+8}
       <ffffffff80148090>{keventd_create_kthread+0} 
<ffffffff80148110>{kthread+0}
       <ffffffff8010ee2f>{child_rip+0}

Code: 41 80 3c 24 00 7e f7 e9 5e de ff ff f3 90 80 3b 00 7e f9 e9
console shuts up ...

This particular one is from 2.6.6-rc3 and I can't get any call traces from the 
-mm kernels, because the _serial_ _console_ _does_ _not_ _work_ there, 
apparently.

The 2.6.6-rc2 and 2.6.6-rc2-mm1 kernels run happily on my box, so the problem 
must have been introduced between 2.6.6-rc2-mm1 and 2.6.6-rc2-mm2 (any ideas, 
patches to test/revert, please?).

Yours,
RJW


