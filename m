Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754857AbWKPWdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbWKPWdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754876AbWKPWdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:33:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38853 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754857AbWKPWdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:33:50 -0500
Message-ID: <455CE74A.9010206@redhat.com>
Date: Thu, 16 Nov 2006 16:33:46 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@jeffreymahoney.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ext4@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
Subject: Re: [PATCH] ext3: htree entry integrity checking
References: <455C96DC.4060907@jeffreymahoney.com> <20061116222747.GT6012@schatzie.adilger.int>
In-Reply-To: <20061116222747.GT6012@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Nov 16, 2006  11:50 -0500, Jeff Mahoney wrote:
>>  Currently, if a corrupted directory entry with rec_len=0 is encountered,
>>  we still trust that the data is valid. This can cause an infinite loop
>>  in htree_dirblock_to_tree() since the iteration loop will never make any
>>  progress.
> 
> Actually, I think Eric Sandeen was working on similar fixes already, and
> instead of doing a per-item check each time we look at the entry it does
> a full-block check the first time it is read (as ext2 does).
> 
>>  This fixes the problem described at:
>>  http://projects.info-pull.com/mokb/MOKB-10-11-2006.html
> 
> Would also be good to CC linux-ext4, where the ext3 maintainers live.
> Hmm, maybe we need to update MAINTAINERS with the new list address?

This should already be fixed, in some fashion, in -mm:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/broken-out/handle-ext3-directory-corruption-better.patch

I have been looking at doing a check only when the block is first read,
but other things have come up & taken some time, and that is a bit on
the back burner now...

-Eric
