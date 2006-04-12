Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWDLRUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWDLRUh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWDLRUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:20:37 -0400
Received: from solarneutrino.net ([66.199.224.43]:6660 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932269AbWDLRUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:20:36 -0400
Date: Wed, 12 Apr 2006 13:20:29 -0400
To: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: lockd oopses continue with 2.6.16.1
Message-ID: <20060412172028.GA12637@tau.solarneutrino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still seeing lockd oopses after server reboots:

Unable to handle kernel paging request at 00002b8134a867a0 RIP: 
<ffffffff801bfdb1>{nlmclnt_mark_reclaim+67}
PGD 0 
Oops: 0000 [1] 
CPU 0 
Modules linked in:
Pid: 1182, comm: lockd Not tainted 2.6.16.1 #2
RIP: 0010:[<ffffffff801bfdb1>] <ffffffff801bfdb1>{nlmclnt_mark_reclaim+67}
RSP: 0018:ffff81007dd25e70  EFLAGS: 00010206
RAX: 00002b8134a86788 RBX: ffff81007d53e480 RCX: ffff81007e3807f8
RDX: ffff81007e380800 RSI: 000000000000005f RDI: ffff81007d53e480
RBP: ffff81007f265400 R08: 00000000fffffffa R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
R13: 0000000000000004 R14: 0000000000000010 R15: ffffffff803c3e20
FS:  00002ad3fb57a4a0(0000) GS:ffffffff80490000(0000) knlGS:00000000f6e519e0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b8134a867a0 CR3: 000000007e2e0000 CR4: 00000000000006e0
Process lockd (pid: 1182, threadinfo ffff81007dd24000, task ffff81007f85e710)
Stack: ffffffff801bfe68 ffff81007d53e480 ffffffff801c6601 3256cc844d030002 
       0000000000000000 0000000000000004 ffff81007ec65000 ffff81007ec650a0 
       ffffffff803c4ea0 ffff81007dd1f014 
Call Trace: <ffffffff801bfe68>{nlmclnt_recovery+139}
       <ffffffff801c6601>{nlm4svc_proc_sm_notify+188} <ffffffff80312a2b>{svc_process+871}
       <ffffffff801c1a19>{lockd+344} <ffffffff801c18c1>{lockd+0}
       <ffffffff801c18c1>{lockd+0} <ffffffff8010b01e>{child_rip+8}
       <ffffffff801c18c1>{lockd+0} <ffffffff801c18c1>{lockd+0}
       <ffffffff8010b016>{child_rip+0}

Code: 48 39 78 18 75 13 8b 81 8c 00 00 00 a8 01 74 09 83 c8 02 89 
RIP <ffffffff801bfdb1>{nlmclnt_mark_reclaim+67} RSP <ffff81007dd25e70>
CR2: 00002b8134a867a0

-ryan
