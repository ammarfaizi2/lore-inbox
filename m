Return-Path: <linux-kernel-owner+w=401wt.eu-S1754987AbWL1VZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754987AbWL1VZX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755002AbWL1VZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:25:23 -0500
Received: from smtp7.orange.fr ([193.252.22.24]:25515 "EHLO smtp7.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987AbWL1VZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:25:14 -0500
X-ME-UUID: 20061228212512693.A92CD1800093@mwinf0702.orange.fr
Message-ID: <45943638.30705@free.fr>
Date: Thu, 28 Dec 2006 22:25:12 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Kernel development list <linux-kernel@vger.kernel.org>,
       Oliver Neukum <oliver@neukum.name>, Greg KH <greg@kroah.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc2-mm1: INFO: possible recursive locking detected in
 con_close
References: <20061228024237.375a482f.akpm@osdl.org>
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28.12.2006 11:42, Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/

Hello,

got this with 2.6.20-rc2-mm1, reverting 
gregkh-driver-driver-core-fix-race-in-sysfs-between-sysfs_remove_file-and-read-write.patch 
made it disappear.

=============================================
[ INFO: possible recursive locking detected ]
2.6.20-rc2-mm1 #51
---------------------------------------------
init/324 is trying to acquire lock:
(&sysfs_inode_imutex_key){--..}, at: [<c02b2c79>] mutex_lock+0x1c/0x1f

but task is already holding lock:
(&sysfs_inode_imutex_key){--..}, at: [<c02b2c79>] mutex_lock+0x1c/0x1f

other info that might help us debug this:
2 locks held by init/324:
#0:  (tty_mutex){--..}, at: [<c02b2c79>] mutex_lock+0x1c/0x1f
#1:  (&sysfs_inode_imutex_key){--..}, at: [<c02b2c79>] mutex_lock+0x1c/0x1f

stack backtrace:
[<c0104ea7>] show_trace_log_lvl+0x1a/0x2f
[<c010557a>] show_trace+0x12/0x14
[<c010562c>] dump_stack+0x16/0x18
[<c01314ad>] __lock_acquire+0x116/0xb33
[<c0132283>] lock_acquire+0x56/0x6f
[<c02b2ad3>] __mutex_lock_slowpath+0xdc/0x266
[<c02b2c79>] mutex_lock+0x1c/0x1f
[<c018b293>] sysfs_drop_dentry+0xb7/0x12b
[<c018b3d6>] sysfs_hash_and_remove+0x90/0x14a
[<c018b985>] sysfs_remove_file+0xd/0xf
[<c0235944>] device_remove_file+0x1f/0x2a
[<c02359bb>] device_del+0x31/0x1c4
[<c0235b59>] device_unregister+0xb/0x15
[<c0235bee>] device_destroy+0x8b/0x91
[<c022d7fc>] vcs_remove_sysfs+0x1a/0x36
[<c023254f>] con_close+0x4c/0x60
[<c0226b79>] release_dev+0x221/0x62a
[<c0226f94>] tty_release+0x12/0x1c
[<c015baf1>] __fput+0xb9/0x177
[<c015bc83>] fput+0x31/0x35
[<c015951c>] filp_close+0x54/0x5c
[<c011ac05>] put_files_struct+0x7c/0xb9
[<c011bcef>] do_exit+0x219/0x72f
[<c011c275>] sys_exit_group+0x0/0x11
[<c011c284>] sys_exit_group+0xf/0x11
[<c0103ed2>] sysenter_past_esp+0x5f/0x99
=======================


-- 
laurent
