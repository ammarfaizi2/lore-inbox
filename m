Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbVH2SOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbVH2SOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVH2SOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:14:11 -0400
Received: from cramus.icglink.com ([66.179.92.18]:43649 "EHLO mx03.icglink.com")
	by vger.kernel.org with ESMTP id S1751265AbVH2SOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:14:10 -0400
Date: Mon, 29 Aug 2005 13:14:03 -0500
From: Phil Dier <phil@icglink.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Holdren <scott@icglink.com>, ziggy <ziggy@icglink.com>,
       Jack Massari <jack@icglink.com>
Subject: Slow I/O with megaraid and u160 scsi jbod
Message-Id: <20050829131403.21138526.phil@icglink.com>
Organization: ICGLink
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.4.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've had luck with this patch[1] (it at least eliminated the oopses
I was getting), but now I'm having a different sort of problem with
my setup[2] (the 2.6.13 release exhibits this behaviour as well). I
have 2 u160 scsi jbods connected to this machine[3]. One is connected
to an Adaptec card, and the other is connected to the Fusion MPT card
(megaraid). All of the disks connected to the Adaptec card work fine,
but when doing I/O on disks 2 and 3 on the megaraid card, it stalls
considerably. When trying to sync a RAID1 device using the 4 148GB
disks, the sync speed never goes above 2KB/s. When they finally get
synched, IO stalls constantly. Watching with iostat confirms this. I've
formatted the disks in question with a single JFS partition and they
still exhibit this behaviour when used by themselves. I have verified
that this behaviour is not present up until at least 2.6.12.3. Let me
know what info I can collect that would be helpful.. Thanks.



[1] http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/1952.html
[2] http://www.icglink.com/debug-2.6.13-rc6.html
[3] Diagram:

+---------+
| Adaptec |
+---------+
     |
+-------+-------+-------+-------+-------+
| id: 0 | id: 1 | id: 2 | id: 3 | id: 4 |
| 73GB  | 73GB  | 148GB | 148GB | 73GB  |
+-------+-------+-------+-------+-------+

+----------+
| megaraid |
+----------+
     |
+-------+-------+-------+-------+-------+
| id: 0 | id: 1 | id: 2 | id: 3 | id: 4 |
| 73GB  | 73GB  | 148GB | 148GB | 73GB  |
+-------+-------+-------+-------+-------+

-- 

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
