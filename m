Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWFRJqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFRJqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 05:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWFRJqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 05:46:05 -0400
Received: from mail.gmx.de ([213.165.64.21]:5102 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750774AbWFRJqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 05:46:04 -0400
X-Authenticated: #14349625
Subject: Re: [RFC] CPU controllers?
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org,
       mingo@elte.hu, pwil3058@bigpond.net.au, sekharan@us.ibm.com,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
In-Reply-To: <20060618020932.5947a7dc.akpm@osdl.org>
References: <20060615134632.GA22033@in.ibm.com>
	 <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com>
	 <4494DF50.2070509@yahoo.com.au> <4494EA66.8030305@vilain.net>
	 <4494EE86.7090209@yahoo.com.au> <20060617234259.dc34a20c.akpm@osdl.org>
	 <1150616176.7985.50.camel@Homer.TheSimpsons.net>
	 <20060618020932.5947a7dc.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 11:49:29 +0200
Message-Id: <1150624169.9324.12.camel@Homer.TheSimpsons.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 02:09 -0700, Andrew Morton wrote:
> On Sun, 18 Jun 2006 09:36:16 +0200
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > as
> > evolution mail demonstrates to me every time it's GUI hangs and I see
> > that a nice 19 find is running, eating very little CPU, but effectively
> > DoSing evolution nonetheless (journal).
> 
> eh?  That would be an io scheduler bug, wouldn't it?
> 
> Tell us more.

The trace below was done with a nice -n 19 bonnie -s 2047 running, but
the same happens with the find that SuSE starts at annoying times.
Scheduler is cfq, but changing schedulers doesn't help.

Place a shell window over the evolution window, start io, then click on
the evolution window, and see how long it takes to be able to read mail.
Here, it's a couple forevers.

evolution     D 00000001     0  9324   6938          9333  7851 (NOTLB)
       ef322dec 00000000 00000000 00000001 00000003 93a3f580 000f44c2 ef322000 
       ef322000 ef314030 93a3f580 000f44c2 ef322000 001fb058 ef24d980 ef322000 
       ef322e50 b10bcb57 00000000 b1399998 ef322e3c 00000001 ef24d9c0 ef24d9d0 
Call Trace:
 [<b10bcb57>] log_wait_commit+0x139/0x1f1
 [<b10b6000>] journal_stop+0x239/0x350
 [<b10b6dc8>] journal_force_commit+0x1d/0x1f
 [<b10ae32a>] ext3_force_commit+0x24/0x26
 [<b10a83a0>] ext3_write_inode+0x34/0x7b
 [<b107fa79>] __writeback_single_inode+0x2e8/0x3c9
 [<b10803f1>] sync_inode+0x15/0x2f
 [<b10a426b>] ext3_sync_file+0xc3/0xc8
 [<b10600fc>] do_fsync+0x68/0xb3
 [<b1060167>] __do_fsync+0x20/0x2f
 [<b1060195>] sys_fsync+0xd/0xf
 [<b1002e1b>] syscall_call+0x7/0xb


