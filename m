Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUKWWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUKWWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUKWWeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:34:09 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:33748 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261594AbUKWWd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:33:28 -0500
Date: Sun, 21 Nov 2004 19:22:59 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to find out it's a memory leak?
Message-ID: <20041122022259.GR1974@schnapps.adilger.int>
Mail-Followup-To: Christian Kujau <evil@g-house.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <41A11F50.6060501@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A11F50.6060501@g-house.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2004  00:05 +0100, Christian Kujau wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> during the last weeks i've encounterd some OOM situation here on my little
> server machine. that happened with some 2.6.9 and 2.6.10 kernels but i
> never found out what the reason was. the machine was running for 2 or 3
> weeks and constantly taking up more and more swap until the OOM killer did
> his job and killed some task. i decided to reboot then, once i *had* to
> reboot because the machine has locked up.
> so i suspect a "memory leak" somewhere. knowing nothing about VM and
> knowing the term "memory leak" only from hearsay, i just want to know
> 
> 1) does a memory leak always occur in kernel space? or could some
>    userspace application take up more and more swapspace too?
> 2) where can i look for the process to blame?
> 
> i've already thought about it and i really think a userspace app can also
> be the bad one here, but "top" and "ps" won't tell me who's to blame.
> perhaps somewhere under /proc, but i don't know where. can someone tell me
> where to look for?

If you run "top" and press 'M' it sorts processes by memory used.  The
other Mem numbers printed are also of interest, "active" and "inactive"
are cached data pages, "buff" are metadata buffers.  Also, /proc/slabinfo
will show memory allocated by kernel processes.  Any gigantic numbers in
there are generally a sign of memory leak or imbalance in the kernel.
Also include the output of /proc/meminfo if it isn't a user process.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

