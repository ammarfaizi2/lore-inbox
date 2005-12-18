Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965266AbVLRUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965266AbVLRUsI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLRUsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:48:08 -0500
Received: from cantor.suse.de ([195.135.220.2]:750 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932185AbVLRUsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:48:07 -0500
From: Neil Brown <neilb@suse.de>
To: "Szloboda Zsolt" <slobo@t-online.hu>
Date: Mon, 19 Dec 2005 07:47:58 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17317.51966.827057.524008@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: raid over sata - write barrier
In-Reply-To: message from Szloboda Zsolt on Friday December 16
References: <JDEMIGCBPIDENEAIIGKPAEBMCLAA.slobo@t-online.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 16, slobo@t-online.hu wrote:
> I've found that ext3 + sata + kernel 2.6.12 supports the write barrier mount
> option (-o barrier=1)
> (found it here: http://marc.10east.com/?l=linux-scsi&m=112019898711806)
> 
> is write barrier supported with RAID (md) over sata, with ext3? (which
> kernel version?)
> (or we have to disable write cache in HD in this case?)

 From 2.6.14 md has at least minimal support for write barriers.
 'Minimal support' means that it will tell the filesystem, that write
 barriers aren't supported so it should do explicit cache flushes
 (however I don't believe that all filesystems to the explicit cache
 flushes that they should).

 From 2.6.15, md/raid1 has better support for write barriers, in that
 if every underlying device supports them, it will preserve the
 write-barrier flag in requests passed down.

 So you should be ok with the write cache if you use raid1 and 2.6.15
 (which isn't out yet, I know, but a late -rc should be fine).  But if
 you want a different raid level, you should ask the ext3 developers
 if there is a reason they don't call blkdev_issue_flush if barriers
 aren't supported...

NeilBrown
