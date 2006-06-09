Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWFICtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWFICtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWFICtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:49:15 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63203 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751335AbWFICtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:49:14 -0400
Message-ID: <4488E1A4.20305@garzik.org>
Date: Thu, 08 Jun 2006 22:49:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: cmm@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao wrote:
> Current ext3 filesystem is limited to 8TB(4k block size), this is
> practically not enough for the increasing need of bigger storage as
> disks in a few years (or even now).
> 
> To address this need, there are co-effort from RedHat, ClusterFS, IBM
> and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
> expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
> ext3 is build on top of extent map changes for ext3, originally from
> Alex Tomas. In short, the new ext3 on-disk extents format is:

One of my common complaints about massive ext3 updates such as this is 
the ever-growing "which ext3 filesystem am I mounting?" problem.

I really think extents and 48bit-ness should imply
	cp -a fs/ext3 fs/ext4
and go from there.

IMHO the ext3 back-compat situation is already really hairy, with all 
the features added since the original ext3 release.

The alternative is continual bloating of ext3, and on filesystems, 
inodes which are progressively upgraded -- meaning any use of a prior 
kernel implies that you can only read a subset of your [meta]data, if 
the back-compat code doesn't block the mount entirely.

People (including me) still switch back and forth between ext2 and ext3 
mounts of the same filesystem on occasion.  I think creating an "ext4" 
would allow for greater developer flexibility in implementing new 
features and ditching old ones -- while also emphasizing to the user 
that switching back and forth between ext4 and ext[23] is a bad idea.

Overall, after applying extent (and 48bit) patches, I think it is wrong 
to keep calling it ext3.  That will break some existing user 
assumptions, and continue to restrict developers' freedom to implement 
nifty new features.

	Jeff



