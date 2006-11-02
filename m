Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752892AbWKBOG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbWKBOG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752891AbWKBOG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:06:29 -0500
Received: from kim.schedom-europe.net ([193.109.184.78]:40869 "HELO
	kim-out.schedom-europe.net") by vger.kernel.org with SMTP
	id S1752892AbWKBOG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:06:28 -0500
From: Jan De Luyck <ml_linuxkernel_20060528@kcore.org>
Subject: [2.6.18.1] possible recursive locking detected
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
X-Comes-From-Sentmails: YES
Date: Thu, 2 Nov 2006 15:04:23 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611021504.23384.ml_linuxkernel_20060528@kcore.org>
X-Antivirus: This mail has been scanned for viruses by schedom vof (http://www.dommel.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After rebuilding my kernel today to enable as much 
debugging options as possible in an attempt to try to debug
a full system freeze I'm seeing, I saw this in the log. 
No idea if it's bad or not, so I'll report it here.

Nov  2 11:05:48 rutabaga kernel: =============================================
Nov  2 11:05:48 rutabaga kernel: [ INFO: possible recursive locking detected ]
Nov  2 11:05:48 rutabaga kernel: ---------------------------------------------
Nov  2 11:05:48 rutabaga kernel: mount/1942 is trying to acquire lock:
Nov  2 11:05:48 rutabaga kernel:  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f76be>] xfs_ilock+0x7e/0xa0
Nov  2 11:05:48 rutabaga kernel: 
Nov  2 11:05:48 rutabaga kernel: but task is already holding lock:
Nov  2 11:05:48 rutabaga kernel:  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f76be>] xfs_ilock+0x7e/0xa0
Nov  2 11:05:48 rutabaga kernel: 
Nov  2 11:05:48 rutabaga kernel: other info that might help us debug this:
Nov  2 11:05:48 rutabaga kernel: 2 locks held by mount/1942:
Nov  2 11:05:48 rutabaga kernel:  #0:  (&inode->i_mutex){--..}, at: [<c035bc85>] mutex_lock+0x25/0x30
Nov  2 11:05:48 rutabaga kernel:  #1:  (&(&ip->i_lock)->mr_lock){----}, at: [<c01f76be>] xfs_ilock+0x7e/0xa0
Nov  2 11:05:48 rutabaga kernel: 
Nov  2 11:05:48 rutabaga kernel: stack backtrace:
Nov  2 11:05:48 rutabaga kernel:  [<c0103bf0>] show_trace_log_lvl+0x1b0/0x1d0
Nov  2 11:05:48 rutabaga kernel:  [<c010435b>] show_trace+0x1b/0x20
Nov  2 11:05:48 rutabaga kernel:  [<c0104444>] dump_stack+0x24/0x30
Nov  2 11:05:48 rutabaga kernel:  [<c013465b>] __lock_acquire+0x8db/0xd70
Nov  2 11:05:48 rutabaga kernel:  [<c0134e69>] lock_acquire+0x69/0x90
Nov  2 11:05:48 rutabaga kernel:  [<c0130b5c>] down_write+0x4c/0x70
Nov  2 11:05:48 rutabaga kernel:  [<c01f76be>] xfs_ilock+0x7e/0xa0
Nov  2 11:05:48 rutabaga kernel:  [<c01f831c>] xfs_iget+0x41c/0x61a
Nov  2 11:05:48 rutabaga kernel:  [<c0212e49>] xfs_trans_iget+0x119/0x190
Nov  2 11:05:48 rutabaga kernel:  [<c01fcf70>] xfs_ialloc+0xb0/0x550
Nov  2 11:05:48 rutabaga kernel:  [<c0213b28>] xfs_dir_ialloc+0x78/0x2e0
Nov  2 11:05:48 rutabaga kernel:  [<c021bceb>] xfs_create+0x39b/0x6f0
Nov  2 11:05:48 rutabaga kernel:  [<c022699e>] xfs_vn_mknod+0x2de/0x2f0
Nov  2 11:05:48 rutabaga kernel:  [<c0226a05>] xfs_vn_create+0x25/0x30
Nov  2 11:05:48 rutabaga kernel:  [<c01710ec>] vfs_create+0x9c/0xf0
Nov  2 11:05:48 rutabaga kernel:  [<c01746a2>] open_namei+0x632/0x710
Nov  2 11:05:48 rutabaga kernel:  [<c015fb38>] do_filp_open+0x38/0x60
Nov  2 11:05:48 rutabaga kernel:  [<c015fbab>] do_sys_open+0x4b/0xf0
Nov  2 11:05:48 rutabaga kernel:  [<c015fca7>] sys_open+0x27/0x30
Nov  2 11:05:48 rutabaga kernel:  [<c01032e7>] syscall_call+0x7/0xb
Nov  2 11:05:48 rutabaga kernel:  [<b7f1eb8d>] 0xb7f1eb8d

Kind regards,

Jan
-- 
The truth about a woman often lasts longer than the woman is true.
