Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUIIU32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUIIU32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIIU0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:26:00 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:13003 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264881AbUIIUYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:24:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Date: Thu, 9 Sep 2004 22:24:49 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Christoph Hellwig <hch@infradead.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Scott Wood <scott@timesys.com>,
       Arjan van de Ven <arjanv@redhat.com>
References: <20040908120613.GA16916@elte.hu> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu>
In-Reply-To: <20040908211415.GA20168@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092224.49690.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of September 2004 23:14, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > latest patch attached - this should compile on every architecture.
> > It's basically what Christoph suggested first time around :-)
> > Compiles/boots on x86. Any other observations?
> 
> i've attached generic-hardirqs-2.6.9-rc1-mm4.patch which is a merge
> against -mm4. x86 and x64 compiles & boots fine. Since there are zero
> changes to non-x86 architectures it should build fine on all platforms.

I've got this trace (on x86-64):

general protection fault: 0000 [1] PREEMPT
CPU 0
Modules linked in: usbserial parport_pc lp parport joydev sg st sd_mod sr_mod 
scsi_mod snd_seq_oss snd_seq_midi_evend
Pid: 694, comm: kjournald Not tainted 2.6.9-rc1-mm4
RIP: 0010:[<ffffffff802ac605>] 
<ffffffff802ac605>{__journal_clean_checkpoint_list+389}
RSP: 0018:000001001f589b08  EFLAGS: 00010202
RAX: 0000000000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000000000000
RDX: 0000010001b2c4d8 RSI: 000001001fd2e150 RDI: 000001001fbab628
RBP: 00000100110c0708 R08: 000001001fd2e050 R09: 00000100110c0708
R10: 0000000000000000 R11: 0000000000000000 R12: 00000100110c0708
R13: 000001000b4345c8 R14: 000000000000007f R15: 0000010001ae8d70
FS:  0000002a9afefa80(0000) GS:ffffffff805f3580(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000002a95654000 CR3: 0000000000101000 CR4: 00000000000006e0
Process kjournald (pid: 694, threadinfo 000001001f588000, task 
0000010001ad9270)
Stack: 000001001f589b48 000001001fd2bc58 0000010001b2c4d8 0000010001b2c4d8
       0000000000000001 0000000000000000 0000010001b2c4d8 000001000bc1f910
       0000000000000000 ffffffff802a9039
Call Trace:<ffffffff802a9039>{journal_commit_transaction+2329}
       <ffffffff8042f730>{thread_return+41} <ffffffff802b3465>{kjournald+725}
       <ffffffff8015ece0>{autoremove_wake_function+0} 
<ffffffff8015ece0>{autoremove_wake_function+0}
       <ffffffff802b3a30>{commit_timeout+0} <ffffffff80111afb>{child_rip+8}
       <ffffffff802b3190>{kjournald+0} <ffffffff80111af3>{child_rip+0}


Code: 48 8b 43 48 49 89 45 48 48 8b 54 24 10 4c 8b aa b8 00 00 00
RIP <ffffffff802ac605>{__journal_clean_checkpoint_list+389} RSP 
<000001001f589b08>

with the patch applied.  I don't know if the patch is the reason, but I 
haven't got anything like that without it (please let me know if you 
need .config etc.).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
