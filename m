Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUJYMVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUJYMVt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUJYMVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:21:49 -0400
Received: from dns1.seagha.com ([217.66.0.18]:6619 "EHLO ndns1.seagha.com")
	by vger.kernel.org with ESMTP id S261745AbUJYMVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:21:47 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E133601A68E80@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 reservation strangeness?!
Date: Mon, 25 Oct 2004 14:21:29 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When copying a file on 2.6.9-mm1 with the ext3 reservation code,
I noticed that there were a lot of fragments. Doing the same when
the filesystem is mounted with 'noreservation' seems to produce
better results?! Or am I interpreting this incorrectly?

Example:

[root@kvo kvo]# ls -l t
-rw-r--r--  1 root root 8228490 Oct 23 14:45 t

Copying this file with reservation code active:

[root@kvo kvo]# mount -t ext3 -o commit=60,reservation /dev/sda1 /mnt
[root@kvo kvo]# cp t /mnt
[root@kvo kvo]# filefrag /mnt/t
/mnt/t: 129 extents found, perfection would be 1 extent
[root@kvo kvo]# rm -f /mnt/t
[root@kvo kvo]# umount /mnt

While doing the same with 'noreservation' produces only 2 extents:

[root@kvo kvo]# mount -t ext3 -o commit=60,noreservation /dev/sda1 /mnt
[root@kvo kvo]# cp t /mnt
[root@kvo kvo]# filefrag /mnt/t
/mnt/t: 2 extents found, perfection would be 1 extent
[root@kvo kvo]# rm -f /mnt/t


There was enough free diskspace available:

[root@kvo kvo]# df /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1             76904352  25383252  47614496  35% /mnt

