Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264272AbUFGAUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbUFGAUH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 20:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUFGAUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 20:20:07 -0400
Received: from shua3622.serverfarm.hu ([195.70.43.230]:15624 "EHLO korus.hu")
	by vger.kernel.org with ESMTP id S264261AbUFGATu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 20:19:50 -0400
Message-ID: <40C3B49A.5DEF7D47@engard.hu>
Date: Mon, 07 Jun 2004 02:19:38 +0200
From: Ferenc Engard <ferenc@engard.hu>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 errors
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1BX7j9-00064Z-00*vamUDfgV1ew* (korus.hu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have installed a new server, and created ext3 (data=ordered)
filesystems on RAID1 partitions. I finished the installation a few weeks
ago, and today I tried to install in in the place of the old one.

I have worked a few hours on the server, mainly in the /etc directory,
and copied a few gig's to the /home dir, which was on a separate
partition than root. After that I have rebooted, to check that
everything going up OK. Well, nothing was OK.

The fsck failed with many "Freeing blocks not in datazone" and "Journal
aborting" errors, and I came up with a read-only root partition. I
manually e2fsck'd it, saying yes to all questions, and rebooted again.
Next time it was the same story: fsck always failed, found many errors,
the lost+found growed... 

AND, the real interesting story: all of my modifications in the /etc
directory, which I made at least an hour or more, was lost! Just as if
nothing has been written to the disk from the journal for at least an
hour. Also, there were some corrupted files, and also, some obvious fs
errors after an fsck, for example, accessing /etc/apache-ssl/apache.conf
resulted some errors like this:

Jun  6 21:56:25 zeratul kernel: attempt to access beyond end of device
Jun  6 21:56:25 zeratul kernel: 09:01: rw=0, want=1085624632,
limit=20972736

The end of the story: I booted from CD, copied the whole root
partition's contents off-disk, reformatted the RAID1 partition with
mke2fs -j, copied back the contents, and it seems that now everything is
good (so far). I don't think that the problem is in hardware, because of
the RAID1, and also, these are brand-new 80G Maxtor SCSI drives.

What can cause an error like this? This is a linux 2.4.26 on a PIV-2666,
debian testing dist.

Thanks,
Ferenc Engard

