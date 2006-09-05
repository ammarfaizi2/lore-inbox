Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbWIEGUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWIEGUS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 02:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWIEGUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 02:20:18 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:53384 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S965166AbWIEGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 02:20:15 -0400
Subject: Re: 2.6.18rc5: NFSd possible recursive locking
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3slj8ae84.fsf@defiant.localdomain>
References: <m3slj8ae84.fsf@defiant.localdomain>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 08:12:13 +0200
Message-Id: <1157436733.14324.9.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-03 at 22:26 +0200, Krzysztof Halasa wrote:
> Hi,
> 
> another one (details available on request):
> 
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> nfsd/1566 is trying to acquire lock:
>  (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20
> 
> other info that might help us debug this:
> 2 locks held by nfsd/1566:
>  #0:  (hash_sem){..--}, at: [<c01b292d>] exp_readlock+0xd/0x10
>  #1:  (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20
> 
> stack backtrace:
>  [<c0103522>] show_trace+0x12/0x20
>  [<c0103b79>] dump_stack+0x19/0x20
>  [<c012dfab>] __lock_acquire+0x8db/0xd70
>  [<c012e7b6>] lock_acquire+0x76/0xa0
>  [<c0334c06>] __mutex_lock_slowpath+0x66/0x250
>  [<c0334e0c>] mutex_lock+0x1c/0x20
>  [<c01afd1d>] nfsd_setattr+0x46d/0x5b0
>  [<c01b12da>] nfsd_create_v3+0x4da/0x540
>  [<c01b6574>] nfsd3_proc_create+0x104/0x170
>  [<c01ab7d8>] nfsd_dispatch+0x88/0x1e0
>  [<c03248d4>] svc_process+0x3f4/0x6e0
>  [<c01abce1>] nfsd+0x191/0x300
>  [<c0100c85>] kernel_thread_helper+0x5/0x10

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/broken-out/nfsd-lockdep-annotation.patch
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc5/2.6.18-rc5-mm1/broken-out/knfsd-nfsd-lockdep-annotation-fix.patch

Do those patches fix it?

