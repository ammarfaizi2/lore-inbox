Return-Path: <linux-kernel-owner+w=401wt.eu-S1751139AbXAIHdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbXAIHdf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbXAIHdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:33:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:60779 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbXAIHde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:33:34 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mpLA7D9qjq3FAlK6mNdIxMGPvVjwokvHV2gOTFR8QQTBSQHif4clveqlHd0KVkgdv9YnQkurvjtqZadJcP06PtrM/Pkh7WaP8HJTyeC/OSZnLRTpckxjOF4Z43cbipyrRBy6M8DCsu+PJ2FvNCzC5LI6cULB1O0Jr7QL7p4vlrA=
Message-ID: <5157576d0701082333h276b99f3l7a785f6e2f250c27@mail.gmail.com>
Date: Tue, 9 Jan 2007 10:33:33 +0300
From: "Tomasz Kvarsin" <kvarsin@gmail.com>
To: linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
       shaggy@austin.ibm.com
Subject: JFS: possible recursive locking detected
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This I got during boot with 2.6.20-rc4:
=============================================
[ INFO: possible recursive locking detected ]
2.6.20-rc4 #3
---------------------------------------------
mount/5819 is trying to acquire lock:
 (&jfs_ip->commit_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30

but task is already holding lock:
 (&jfs_ip->commit_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30

other info that might help us debug this:
2 locks held by mount/5819:
 #0:  (&inode->i_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30
 #1:  (&jfs_ip->commit_mutex){--..}, at: [<c03395e1>] mutex_lock+0x21/0x30

stack backtrace:
 [<c010375a>] show_trace_log_lvl+0x1a/0x30
 [<c0103e62>] show_trace+0x12/0x20
 [<c0103f16>] dump_stack+0x16/0x20
 [<c0135e98>] __lock_acquire+0xa38/0xe00
 [<c01362cf>] lock_acquire+0x6f/0x90
 [<c033939a>] __mutex_lock_slowpath+0x6a/0x290
 [<c03395e1>] mutex_lock+0x21/0x30
 [<c01d64b0>] jfs_create+0x90/0x350
 [<c0169489>] vfs_create+0xa9/0xf0
 [<c016c5f7>] open_namei+0x5d7/0x630
 [<c01602fc>] do_filp_open+0x2c/0x60
 [<c0160377>] do_sys_open+0x47/0xe0
 [<c016044c>] sys_open+0x1c/0x20
 [<c0102f8e>] sysenter_past_esp+0x5f/0x99
 =======================
