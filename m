Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWHPAL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHPAL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWHPAL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:11:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42660 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750714AbWHPAL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:11:56 -0400
Date: Wed, 16 Aug 2006 10:11:22 +1000
From: Nathan Scott <nathans@sgi.com>
To: Martin Braun <mbraun@uni-hd.de>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: kernel BUG at <bad filename>:50307!
Message-ID: <20060816101122.E2740551@wobbly.melbourne.sgi.com>
References: <44E1D9CA.30805@uni-hd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44E1D9CA.30805@uni-hd.de>; from mbraun@uni-hd.de on Tue, Aug 15, 2006 at 04:27:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Tue, Aug 15, 2006 at 04:27:22PM +0200, Martin Braun wrote:
> ...
> What does this bug mean?
> ...
> Aug 15 15:01:02 pers109 kernel: Access to block zero: fs: <sdc1> inode:
> 254474718 start_block : 0 start_off : c0a0b0e8a099
> 0 blkcnt : 90000 extent-state : 0
> Aug 15 15:01:02 pers109 kernel: ------------[ cut here ]------------
> Aug 15 15:01:02 pers109 kernel: kernel BUG at <bad filename>:50307!

It means XFS detected ondisk corruption in inode# 254474718, and
paniced your system (stupidly; a fix for this is around, will be
merged with the next mainline update).  For me, a more interesting
question is how that inode got into this state... have you had any
crashes recently (i.e. has the filesystem journal needed to be
replayed recently?)  Can you send the output of:

	# xfs_db -c 'inode 254474718' -c print /dev/sdc1

You'll need to run xfs_repair on that filesystem to fix this up,
but please send us that output first.

thanks.

-- 
Nathan
