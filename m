Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUDMA06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 20:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUDMA05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 20:26:57 -0400
Received: from adsl-209-204-144-92.sonic.net ([209.204.144.92]:40093 "EHLO
	server.home") by vger.kernel.org with ESMTP id S263210AbUDMA0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 20:26:52 -0400
Date: Mon, 12 Apr 2004 17:26:51 -0700 (PDT)
From: Christoph Lameter <christoph@graphe.net>
X-X-Sender: christoph@server.home
To: linux-kernel@vger.kernel.org
Subject: CIFS/SMBFS failing under load in 2.6.X
Message-ID: <Pine.LNX.4.58.0404121721410.12918@server.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever I put a high load on CIFS or SMBFS requests timeout and then the
benchmark or whatever I run fails. I ran the same tests successfully with
a 2.4.25 kernel. This is a connection to a samba 3.0.2 server.

SMBFS logs the following:

Apr 12 15:59:25 testbox kernel: smb_add_request: request [ca7b7280,
mid=12891] timed out!
Apr 12 15:59:25 testbox kernel: smb_writepage_sync: failed write,
wsize=4096, result=-5
Apr 12 15:59:26 testbox kernel: smb_add_request: request [ca7b7080,
mid=13701] timed out!
Apr 12 15:59:26 testbox kernel: smb_writepage_sync: failed write,
wsize=4096, result=-5
Apr 12 16:00:08 testbox kernel: smb_add_request: request [ca7b7c80,
mid=47333] timed out!
Apr 12 16:00:08 testbox kernel: smb_writepage_sync: failed write,
wsize=2048, result=-5
Apr 12 16:00:10 testbox kernel: smb_add_request: request [ca7b7880,
mid=48900] timed out!
Apr 12 16:00:10 testbox kernel: smb_writepage_sync: failed write, wsize=1,
result=-5
Apr 12 16:00:13 testbox kernel: smb_add_request: request [ca7b7180,
mid=50657] timed out!
Apr 12 16:00:13 testbox kernel: smb_writepage_sync: failed write,
wsize=2048, result=-5
Apr 12 16:00:22 testbox kernel: smb_add_request: request [ca7b7e80,
mid=57576] timed out!
Apr 12 16:00:22 testbox kernel: smb_writepage_sync: failed write,
wsize=4096, result=-5
Apr 12 16:00:22 testbox kernel: smb_add_request: request [ca7b7d80,
mid=57900] timed out!
Apr 12 16:00:22 testbox kernel: smb_writepage_sync: failed write,
wsize=4096, result=-5
Apr 12 16:00:39 testbox kernel: smb_add_request: request [ca7b7b80,
mid=9411] timed out!
Apr 12 16:00:39 testbox kernel: smb_writepage_sync: failed write,
wsize=4096, result=-5
Apr 12 16:01:22 testbox kernel: smb_add_request: request [ca7b7980,
mid=40403] timed out!
Apr 12 16:01:22 testbox kernel: smb_writepage_sync: failed write, wsize=1,
result=-5
Apr 12 16:04:53 testbox kernel: smb_add_request: request [c9d25980,
mid=35372] timed out!
Apr 12 16:04:53 testbox kernel: smb_writepage_sync: failed write,
wsize=4096, result=-5
Apr 12 16:04:53 testbox kernel: smb_add_request: request [c9d25580,
mid=35548] timed out!
Apr 12 16:04:53 testbox kernel: smb_writepage_sync: failed write,
wsize=53, result=-5
Apr 12 16:05:32 testbox kernel: smb_add_request: request [c9d25b80,
mid=5926] timed out!
Apr 12 16:05:32 testbox kernel: smb_writepage_sync: failed write,
wsize=2048, result=-5
Apr 12 16:05:32 testbox kernel: smb_add_request: request [c9d25780,
mid=5993] timed out!
Apr 12 16:05:32 testbox kernel: smb_writepage_sync: failed write,
wsize=2048, result=-5
Apr 12 16:05:35 testbox kernel: smb_add_request: request [c9d25680,
mid=7816] timed out!
Apr 12 16:05:35 testbox kernel: smb_writepage_sync: failed write, wsize=1,
result=-5
Apr 12 16:05:38 testbox kernel: smb_add_request: request [c9d25c80,
mid=10166] timed out!
Apr 12 16:05:38 testbox kernel: smb_writepage_sync: failed write,
wsize=2048, result=-5
Apr 12 16:05:38 testbox kernel: smb_add_request: request [c9d25d80,
mid=10231] timed out!
Apr 12 16:05:38 testbox kernel: smb_writepage_sync: failed write,
wsize=2048, result=-5


CIFS logs:

Apr 12 17:02:00 testbox kernel:  CIFS VFS: Send error in write = -6
Apr 12 17:02:29 testbox kernel:  CIFS VFS: Send error in write = -5
Apr 12 17:02:29 testbox last message repeated 8 times
Apr 12 17:02:39 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:02:49 testbox last message repeated 10 times
Apr 12 17:02:49 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:02:59 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:02:59 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:09 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:09 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:14 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:19 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:19 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:20 testbox kernel:  CIFS VFS: Error 0xfffffffb or (-5
decimal) on cifs_get_inode_info in lookup
Apr 12 17:03:35 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:45 testbox kernel:  CIFS VFS: Need to reconnect after session
died to server
Apr 12 17:03:46 testbox kernel:  CIFS VFS: cifs_umount failed with return
code -5

Tests were run with Linux 2.6.5.

