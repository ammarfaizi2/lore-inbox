Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313496AbSC3NCc>; Sat, 30 Mar 2002 08:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312488AbSC3NCX>; Sat, 30 Mar 2002 08:02:23 -0500
Received: from www.wen-online.de ([212.223.88.39]:24592 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S312494AbSC3NCN>;
	Sat, 30 Mar 2002 08:02:13 -0500
Date: Sat, 30 Mar 2002 14:03:53 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alexander Viro <viro@math.psu.edu>
Subject: vfs_unlink() >=2.5.5-pre1 question
Message-ID: <Pine.LNX.4.10.10203301401550.991-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

d_delete() doesn't appear to ever create negative dentries when
called via vfs_unlink() due to the extra reference on the dentry.
In fact, a printk() in the d_delete() spot never ever triggers...

This could explain the behavior change, wherein rm -r on a large
directory no longer works in ramfs/tmpfs, because the dentries are
now destroyed instead of going negative. [1]  Is it intentional
that no negative dentries are created via vfs_unlink() method?

	-Mike

1. if that's true, memory pressure could make readdir fail too.

