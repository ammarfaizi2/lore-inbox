Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWARAqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWARAqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWARAqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:46:23 -0500
Received: from solarneutrino.net ([66.199.224.43]:18437 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S964773AbWARAqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:46:22 -0500
Date: Tue, 17 Jan 2006 19:02:54 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20060118000254.GA821@tau.solarneutrino.net>
References: <20051217055907.GC20539@tau.solarneutrino.net> <1134801822.7946.4.camel@lade.trondhjem.org> <20051217070222.GD20539@tau.solarneutrino.net> <1134847699.7950.25.camel@lade.trondhjem.org> <20051217194553.GE20539@tau.solarneutrino.net> <1134894836.7931.17.camel@lade.trondhjem.org> <20051218180150.GF20539@tau.solarneutrino.net> <1134934267.7966.37.camel@lade.trondhjem.org> <20051218200052.GA21665@tau.solarneutrino.net> <1134944665.11596.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134944665.11596.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 05:24:24PM -0500, Trond Myklebust wrote:
> On Sun, 2005-12-18 at 15:00 -0500, Ryan Richter wrote:
> > On Sun, Dec 18, 2005 at 02:31:07PM -0500, Trond Myklebust wrote:
> > > On Sun, 2005-12-18 at 13:01 -0500, Ryan Richter wrote:
> > > > Code: 48 39 78 18 75 1c 8b 86 8c 00 00 00 a8 01 74 12 83 c8 02 89 
> > > > RIP <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62} RSP <ffff81007dfade70>
> > > > CR2: 0000000000000018
> > > 
> > > Looks like the global lock list is corrupted. Could you cat the contents
> > > of /proc/locks?
> > 
> > $ cat /proc/locks
> > 1: POSIX  ADVISORY  WRITE 1657 00:0e:1771273 0 EOF
> > 2: FLOCK  ADVISORY  WRITE 1486 00:0e:1770759 0 EOF
> > 3: FLOCK  ADVISORY  WRITE 1478 00:0e:1770399 0 EOF
> 
> OK. I think this client patch ought to fix the Oopses. It should apply
> to a 2.6.14 kernel as well as 2.6.15-rc5.
> 
> Cheers,
>   Trond
> 

> NLM: Fix Oops in nlmclnt_mark_reclaim()

This is still a problem with 2.6.15.

Unable to handle kernel paging request at 000000000000d08c RIP: 
<ffffffff801c3538>{nlmclnt_mark_reclaim+67}
PGD 7c4af067 PUD 7d194067 PMD 0 
Oops: 0000 [1] 
CPU 0 
Modules linked in:
Pid: 1222, comm: lockd Not tainted 2.6.15 #5
RIP: 0010:[<ffffffff801c3538>] <ffffffff801c3538>{nlmclnt_mark_reclaim+67}
RSP: 0018:ffff81007ddf9e70  EFLAGS: 00010206
RAX: 000000000000d074 RBX: ffff81007f365240 RCX: ffff81007f973e80
RDX: ffff81007f973e88 RSI: 000000000000003b RDI: ffff81007f365240
RBP: ffff81007ecaec00 R08: 00000000fffffffa R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000010 R15: ffffffff803bb5e0
FS:  00002aaaab00c4a0(0000) GS:ffffffff80489800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000000000d08c CR3: 000000007c4eb000 CR4: 00000000000006e0
Process lockd (pid: 1222, threadinfo ffff81007ddf8000, task ffff81007ed341c0)
Stack: ffffffff801c35ef ffff81007f365240 ffffffff801ca2ba 3256cc8460030002 
       0000000000000000 0000000000000004 ffff81007f34b000 ffff81007f34b0a0 
       ffffffff803bc660 ffff81007ddf0014 
Call Trace:<ffffffff801c35ef>{nlmclnt_recovery+139} <ffffffff801ca2ba>{nlm4svc_proc_sm_notify+188}
       <ffffffff80314b07>{svc_process+871} <ffffffff801c519d>{lockd+344}
       <ffffffff801c5045>{lockd+0} <ffffffff801c5045>{lockd+0}
       <ffffffff8010dfaa>{child_rip+8} <ffffffff801c5045>{lockd+0}
       <ffffffff801c5045>{lockd+0} <ffffffff8010dfa2>{child_rip+0}
       

Code: 48 39 78 18 75 13 8b 81 8c 00 00 00 a8 01 74 09 83 c8 02 89 
RIP <ffffffff801c3538>{nlmclnt_mark_reclaim+67} RSP <ffff81007ddf9e70>
CR2: 000000000000d08c

And another machine

Unable to handle kernel paging request at 0000000000009090 RIP: 
<ffffffff801c3538>{nlmclnt_mark_reclaim+67}
PGD 7bc89067 PUD 7bc8a067 PMD 0 
Oops: 0000 [1] 
CPU 0 
Modules linked in:
Pid: 1220, comm: lockd Not tainted 2.6.15 #5
RIP: 0010:[<ffffffff801c3538>] <ffffffff801c3538>{nlmclnt_mark_reclaim+67}
RSP: 0018:ffff81007de17e70  EFLAGS: 00010206
RAX: 0000000000009078 RBX: ffff810079e35f00 RCX: ffff81007f979e80
RDX: ffff81007f979e88 RSI: 000000000000003b RDI: ffff810079e35f00
RBP: ffff81007eca9200 R08: 00000000fffffffa R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000010 R15: ffffffff803bb5e0
FS:  00002aaaab00c4a0(0000) GS:ffffffff80489800(0000) knlGS:0000000056701920
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000009090 CR3: 000000007bc7e000 CR4: 00000000000006e0
Process lockd (pid: 1220, threadinfo ffff81007de16000, task ffff81007ed261c0)
Stack: ffffffff801c35ef ffff810079e35f00 ffffffff801ca2ba 3256cc8473030002 
       0000000000000000 0000000000000004 ffff81007f0e3000 ffff81007f0e30a0 
       ffffffff803bc660 ffff81007ddf8014 
Call Trace:<ffffffff801c35ef>{nlmclnt_recovery+139} <ffffffff801ca2ba>{nlm4svc_proc_sm_notify+188}
       <ffffffff80314b07>{svc_process+871} <ffffffff801c519d>{lockd+344}
       <ffffffff801c5045>{lockd+0} <ffffffff801c5045>{lockd+0}
       <ffffffff8010dfaa>{child_rip+8} <ffffffff801c5045>{lockd+0}
       <ffffffff801c5045>{lockd+0} <ffffffff8010dfa2>{child_rip+0}
       

Code: 48 39 78 18 75 13 8b 81 8c 00 00 00 a8 01 74 09 83 c8 02 89 
RIP <ffffffff801c3538>{nlmclnt_mark_reclaim+67} RSP <ffff81007de17e70>
CR2: 0000000000009090

Lockd is no longer running etc.

-ryan
