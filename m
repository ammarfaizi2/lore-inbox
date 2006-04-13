Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWDMPd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWDMPd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWDMPd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:33:26 -0400
Received: from pat.uio.no ([129.240.10.6]:63620 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750949AbWDMPd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:33:26 -0400
Subject: Re: lockd oopses continue with 2.6.16.1
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ryan Richter <ryan@tau.solarneutrino.net>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
In-Reply-To: <20060412172028.GA12637@tau.solarneutrino.net>
References: <20060412172028.GA12637@tau.solarneutrino.net>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 11:33:12 -0400
Message-Id: <1144942392.25298.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.551, required 12,
	autolearn=disabled, AWL 1.45, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 13:20 -0400, Ryan Richter wrote:
> I'm still seeing lockd oopses after server reboots:
> 
> Unable to handle kernel paging request at 00002b8134a867a0 RIP: 
> <ffffffff801bfdb1>{nlmclnt_mark_reclaim+67}
> PGD 0 
> Oops: 0000 [1] 
> CPU 0 
> Modules linked in:
> Pid: 1182, comm: lockd Not tainted 2.6.16.1 #2
> RIP: 0010:[<ffffffff801bfdb1>] <ffffffff801bfdb1>{nlmclnt_mark_reclaim+67}
> RSP: 0018:ffff81007dd25e70  EFLAGS: 00010206
> RAX: 00002b8134a86788 RBX: ffff81007d53e480 RCX: ffff81007e3807f8
> RDX: ffff81007e380800 RSI: 000000000000005f RDI: ffff81007d53e480
> RBP: ffff81007f265400 R08: 00000000fffffffa R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
> R13: 0000000000000004 R14: 0000000000000010 R15: ffffffff803c3e20
> FS:  00002ad3fb57a4a0(0000) GS:ffffffff80490000(0000) knlGS:00000000f6e519e0
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002b8134a867a0 CR3: 000000007e2e0000 CR4: 00000000000006e0
> Process lockd (pid: 1182, threadinfo ffff81007dd24000, task ffff81007f85e710)
> Stack: ffffffff801bfe68 ffff81007d53e480 ffffffff801c6601 3256cc844d030002 
>        0000000000000000 0000000000000004 ffff81007ec65000 ffff81007ec650a0 
>        ffffffff803c4ea0 ffff81007dd1f014 
> Call Trace: <ffffffff801bfe68>{nlmclnt_recovery+139}
>        <ffffffff801c6601>{nlm4svc_proc_sm_notify+188} <ffffffff80312a2b>{svc_process+871}
>        <ffffffff801c1a19>{lockd+344} <ffffffff801c18c1>{lockd+0}
>        <ffffffff801c18c1>{lockd+0} <ffffffff8010b01e>{child_rip+8}
>        <ffffffff801c18c1>{lockd+0} <ffffffff801c18c1>{lockd+0}
>        <ffffffff8010b016>{child_rip+0}
> 
> Code: 48 39 78 18 75 13 8b 81 8c 00 00 00 a8 01 74 09 83 c8 02 89 
> RIP <ffffffff801bfdb1>{nlmclnt_mark_reclaim+67} RSP <ffff81007dd25e70>
> CR2: 00002b8134a867a0
> 

Does the following patch (applies on top of 2.6.17-rc1) help?

http://client.linux-nfs.org/Linux-2.6.x/2.6.17-rc1/linux-2.6.17-010-fix_nlm_reclaim_races.dif

Cheers,
  Trond

