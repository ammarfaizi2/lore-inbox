Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVDOIAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVDOIAu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 04:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVDOIAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 04:00:50 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:44931 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261763AbVDOIAk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 04:00:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BCfi/7a3x73/uYTqZG8wwdcQOc1+gV71FEwA8fHLUOw4mmsrc2gG3fWWJQEcEv9NbcwWJP57frEyvMZd0Vd4h4I/NAh1KaoVHAc/OSyZTVsSAND+ge+vjcqis1RNtjyuEo6mHRwRFqvwl4L8I7ks6KHBuhijmq7kp2KDqPgBfZo=
Message-ID: <30e555b5050415010015ddbcf4@mail.gmail.com>
Date: Fri, 15 Apr 2005 10:00:39 +0200
From: Eduard de Boer <elr.de.boer@gmail.com>
Reply-To: Eduard de Boer <elr.de.boer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: MD / RAID5: Memory leak?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been stumbling the last couple of weeks, getting a new box
working. The problem is that I have a Promise FastTrack SX4 with 512MB
cache and four 300GB Maxtor SATA drives connected to it. I've used
mdadm to create a RAID5 array, which is about 879G.

On this array, I've tried LVM (with ReiserFS, XFS, JFS, Ext2, Ext3 on
top of it) as well as creating the same kind of file systems without
LVM.

I use rsync to copy a bunch of files (several GB's) to the designated
filesystems. But after a while, all file systems get corrupted and
'dmesg' lists all kinds of memory corruptions in 'dm' and so on.
Hence, the file copying stops.

Kernels, I've tried, are:
 - 2.6.9-r1
 - 2.6.11-r4
 - 2.6.11-r5
 - 2.6.11.7
 - 2.6.12-rc2
... but the problem persists.

When I run 'top' in a separate window, I see the amount of physical
memory dropping and dropping from about 838MB free, down to about 8M
free. Then is when the problems arise.

So, I now tried several times to stop the file copying before it gets
too low. Then the amount of free physical memory remains constant
(instead of being freed).

Only when I umount the filesystem and remount it, the amount of free
memory is back to the 838MB and I can copy another bunch of files
(without any corruption).

Is this pointing to a memory leak problem in md, or is it a problem
with RAID5 on md?

Regards, Eduard.
