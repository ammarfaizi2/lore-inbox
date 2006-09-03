Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWICU0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWICU0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 16:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWICU0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 16:26:38 -0400
Received: from khc.piap.pl ([195.187.100.11]:56487 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932099AbWICU0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 16:26:37 -0400
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.18rc5: NFSd possible recursive locking
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 03 Sep 2006 22:26:35 +0200
Message-ID: <m3slj8ae84.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

another one (details available on request):

[ INFO: possible recursive locking detected ]
---------------------------------------------
nfsd/1566 is trying to acquire lock:
 (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20

but task is already holding lock:
 (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20

other info that might help us debug this:
2 locks held by nfsd/1566:
 #0:  (hash_sem){..--}, at: [<c01b292d>] exp_readlock+0xd/0x10
 #1:  (&inode->i_mutex){--..}, at: [<c0334e0c>] mutex_lock+0x1c/0x20

stack backtrace:
 [<c0103522>] show_trace+0x12/0x20
 [<c0103b79>] dump_stack+0x19/0x20
 [<c012dfab>] __lock_acquire+0x8db/0xd70
 [<c012e7b6>] lock_acquire+0x76/0xa0
 [<c0334c06>] __mutex_lock_slowpath+0x66/0x250
 [<c0334e0c>] mutex_lock+0x1c/0x20
 [<c01afd1d>] nfsd_setattr+0x46d/0x5b0
 [<c01b12da>] nfsd_create_v3+0x4da/0x540
 [<c01b6574>] nfsd3_proc_create+0x104/0x170
 [<c01ab7d8>] nfsd_dispatch+0x88/0x1e0
 [<c03248d4>] svc_process+0x3f4/0x6e0
 [<c01abce1>] nfsd+0x191/0x300
 [<c0100c85>] kernel_thread_helper+0x5/0x10
-- 
Krzysztof Halasa

-- 
VGER BF report: U 0.502044
