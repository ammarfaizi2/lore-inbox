Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUDILiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 07:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUDILiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 07:38:55 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:39690 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S261204AbUDILix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 07:38:53 -0400
Date: Fri, 9 Apr 2004 13:38:51 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: fledely <fledely@bgumail.bgu.ac.il>
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs
 dirty volume marking)
In-Reply-To: <001601c41db7$aa0a02e0$0100000a@p667>
Message-ID: <Pine.LNX.4.21.0404091247430.22481-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Apr 2004, fledely wrote:

> TODO.ntfsprogs conatins the following TODO item under mkntfs:
>  - We don't know what the real last sector is, thus we mark the volume
> dirty and the subsequent chkdsk (which will happen on reboot into
> Windows automatically) recreates the backup boot sector if the Linux
> kernel lied to us about the number of sectors.

ntfsresize, ntfsclone and others have the same problem due to this kernel
limitation.

>  Now that we know about the extended/legacy BIOS geometry, and
> assuming kernel version 2.6.5+ Is it possible to finally get fixed, or
> totally unrelated?

I'm afraid unrelated. There are two main issues two consider if you want
to fix this:

 1) You must know the exact, _real_ partition size.

 2) You must be able to access it.

Firstly, I don't think EDD tells anything about the partitions but maybe
I'm wrong, I didn't have time to check it out.

Secondly the kernel doesn't always allow access to the last sector via the
partition (longstanding kernel bug). We could access it via the full
device (e.g. /dev/hda, etc) but that's quite messy, error-prone and this
should be fixed in the _kernel_.

Other people are also disturbed by this for a long time,

 - they can't make a full partition backup (dd)
	
 - just like NTFS, the new partitioning format, GPT, also stores
   backup data in the last sectors. 

There were attempts to fix this in 2.6 but I don't know if it was
completed. Maybe somebody knows or have the time to investigate it?

	Szaka

