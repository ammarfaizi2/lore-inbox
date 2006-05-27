Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWE0WOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWE0WOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 18:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWE0WOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 18:14:15 -0400
Received: from mx5.redainternet.nl ([82.98.244.137]:64516 "EHLO
	mx5.redainternet.nl") by vger.kernel.org with ESMTP id S964998AbWE0WOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 18:14:15 -0400
Message-ID: <4478CF33.80609@inn.nl>
Date: Sun, 28 May 2006 00:14:11 +0200
From: Arend Freije <afreije@inn.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.1) Gecko/20060418 SeaMonkey/1.0
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RAID-1 and Reiser4 issue: umount hangs
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using Reiser4 for my filesystems on disk (/dev/sda) , and it works
just fine. Recently I bought a second disk (/dev/sdb) for RAID-1
mirroring. With mdadm I created a degraded raid-1 array  on /dev/md/0,
devices missing,/dev/sdb1. After that I created a Reiser4 filesystem on
/dev/md/0 and mounted it at /mnt. Then I copied the data from /dev/sda1
to /mnt.
All goes well until I umount /mnt, umount simply hangs without any
error. Syslog doesn't report any error. In /proc/mdstat, the array
remains "active sync". Shutting down linux fails because the umount is
still waiting and seems to block other umounts. The umount process
cannot be killed by the root. A hard reset is the only resolution to get
my system functioning normally, but without the raid-1 of course.
The problem seems to emerge only with the combination of RAID and
Reiser4.  I've created an ext-2 filesystem on /dev/md/0, and after that
mount ; cp -ax ; umount works without  a problem, and the hanging umount
re-appears when using Reiser4 again.

My questions:
- how can I find the cause of the hanging umount?
- how can I fix it?

A few details of my linux-box:

Gentoo Linux, 2.6.16 kernel with Reiser4-for-2.6.16-2.patch.gz
i686 AMD Athlon(tm) XP 2400+
DC4300 SATA-II controller (Silicon Image 3124, libata + sata_sil24 drivers)
2 x Samsung SP2504C hard disk

Thanx in advance,

Arend
