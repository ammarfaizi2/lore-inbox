Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVAJXto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVAJXto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVAJXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:44:50 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:55304 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262551AbVAJXl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:41:26 -0500
To: Robert Hardy <rhardy@webcon.ca>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vfat unlink latency 54.6ms for 128MB files
References: <20050110012330.GA10846@m.safari.iki.fi>
	<878y71xh7b.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.61.0501101703140.2235@vortex.int.webcon.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 11 Jan 2005 08:41:17 +0900
In-Reply-To: <Pine.LNX.4.61.0501101703140.2235@vortex.int.webcon.net> (Robert
 Hardy's message of "Mon, 10 Jan 2005 17:36:59 -0500 (EST)")
Message-ID: <87wtukx36q.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hardy <rhardy@webcon.ca> writes:

> Thanks for your patchset.tar (in another thread) from:
> Thu, 30 Dec 2004 12:02:14 +0900.
>
> Based on the patch above, is an additional cond_resched() call required
> somewhere in your 2004/12/30 patchset?
>
> In your 2004/12/30 patchset, if I am reading it correctly, fat_free seems to
> have moved from cache.c to file.c and the code isn't similar enough for me
> to see where a cond_resched() could be added.

Yes. For that patchset, need to add the similar code to
fat_free_cluster() in fs/fat/fatent.c.

		err = fat_write_entry(sb, &fatent, FAT_ENT_FREE);
		if (err)
			goto error;
		if (sbi->free_clusters != -1)
			sbi->free_clusters++;

                cond_resched();     <---  add this line
	} while (cluster != FAT_ENT_EOF);


> Perhaps you have already have a newer patchset?

Yes. I added the 8~10 patches to patchset. However, current patchset
can't compile temporarily.  Sorry. Please wait for next weekend.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
