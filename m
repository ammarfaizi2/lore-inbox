Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbVLGMDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbVLGMDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVLGMDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:03:52 -0500
Received: from sa6.bezeqint.net ([192.115.104.20]:53989 "EHLO sa6.bezeqint.net")
	by vger.kernel.org with ESMTP id S1750908AbVLGMDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:03:51 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: XFS Mount Hangs the Partition (on latest kernel + many old 2.6.x ones)
Date: Wed, 7 Dec 2005 13:57:38 +0200
User-Agent: KMail/1.8.2
Cc: "Linux-IL" <linux-il@linux.org.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512071357.39121.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

(Please CC me on replies)

I encountered a problem with the Linux kernel handling of XFS, in which
attempting to mount a certain XFS partition (but not a different one on the
same hard-disk) caused the mount process to hang, and all other XFS-aware
apps (like "xfs_check" or "xfs_repair") to hang too. However, running 
xfs_check
or xfs_repair before the first mount (after a reboot) worked, and eventually
resolved this problem.

I blogged about it (relatively incoherently) here:

http://www.livejournal.com/~shlomif/7182.html?mode=reply
http://www.livejournal.com/~shlomif/7547.html?mode=reply

It all happened after I detected some problems on my Mandriva 2006 system 
(that was using kernel 2.4.15-rc2 from Linus), and then rebooted twice, 
thinking something went wrong. Then a loadlin-booted kernel was unable to 
load the kernel. 

Knoppix ran fine, but it also hang up on attempting to mount the XFS 
partition. It used a much older kernel. I then tried to boot Kubuntu (which
was on another XFS partition on the same disk) and it booted fine. Still, it
was unable to mount the partition. (It too had an older kernel). 

After I compiled a 2.6.14.3 kernel, and booted Kubuntu with it, it again
could not mount the XFS partition, and after doing that xfs_check and 
xfs_repair both hanged up as well. After a reboot, I tried running xfs_check
right away on that partition and it worked. So I ran xfs_repair, and after it
finished, tried to mount the partition it worked. Then Mandriva booted fine.

I did not had any problems since then (I have an uptime of 11 days now using
kernel 2.6.14.3), and so it doesn't seem like a hard disk problem. Something
using kernel 2.6.15-rc2 caused the XFS partition to become defected, and 
worse - something in all the kernels starting from that of the first official
Kubuntu release, (or the Knoppix I had), caused an attempt to mount the 
Mandriva partition to hang the process, and subsequent accesses to the 
partition by xfs_check and xfs_repair to fail as well.

I can no longer reproduce the problem, but it might be worth going over the 
code. If it helps I can privately send a dump of the first 131,072,000 bytes
of the XFS partition to someone trustworthy. 

Regards,

    Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

95% of the programmers consider 95% of the code they did not write, in the
bottom 5%.
