Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWGYVTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWGYVTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWGYVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:19:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751595AbWGYVTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:19:10 -0400
Date: Tue, 25 Jul 2006 17:19:08 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: nfsd lockdep snafu
Message-ID: <20060725211908.GA3694@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From an rc2-git3 based kernel..

		Dave

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
nfsd/1932 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

other info that might help us debug this:
2 locks held by nfsd/1932:
 #0:  (hash_sem){----}, at: [<ccfc44e2>] exp_readlock+0xd/0xf [nfsd]
 #1:  (&inode->i_mutex){--..}, at: [<c06075f9>] mutex_lock+0x21/0x24

stack backtrace:
 [<c04051ea>] show_trace_log_lvl+0x54/0xfd
 [<c04057a6>] show_trace+0xd/0x10
 [<c04058bf>] dump_stack+0x19/0x1b
 [<c043b7ae>] __lock_acquire+0x773/0x997
 [<c043bf43>] lock_acquire+0x4b/0x6c
 [<c060748a>] __mutex_lock_slowpath+0xbc/0x20a
 [<c06075f9>] mutex_lock+0x21/0x24
 [<ccfc1d57>] nfsd_setattr+0x2fb/0x4aa [nfsd]
 [<ccfc31e3>] nfsd_create_v3+0x31c/0x48c [nfsd]
 [<ccfc7e12>] nfsd3_proc_create+0x125/0x135 [nfsd]
 [<ccfbe0d4>] nfsd_dispatch+0xc0/0x178 [nfsd]
 [<ccf077c3>] svc_process+0x3a4/0x5ee [sunrpc]
 [<ccfbe5f6>] nfsd+0x197/0x2e1 [nfsd]
 [<c0402005>] kernel_thread_helper+0x5/0xb


-- 
http://www.codemonkey.org.uk
