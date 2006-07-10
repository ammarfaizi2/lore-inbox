Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161280AbWGJAiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbWGJAiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161283AbWGJAiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:38:06 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5332 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161280AbWGJAiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:38:05 -0400
Date: Mon, 10 Jul 2006 10:37:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Masayuki Saito <m-saito@tnes.nec.co.jp>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
Message-ID: <20060710103740.B1674239@wobbly.melbourne.sgi.com>
References: <20060704204145.GU15160733@melbourne.sgi.com> <20060707214131m-saito@mail.aom.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060707214131m-saito@mail.aom.tnes.nec.co.jp>; from m-saito@tnes.nec.co.jp on Fri, Jul 07, 2006 at 09:41:31PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 09:41:31PM +0900, Masayuki Saito wrote:
> Thank you for comments.
> 
> >You'd be talking about xfs_iunpin(), wouldn't you ;)
> Yes, of course.
> 
> >http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=714250879ea61cdb1a39bb96fe9d934ee0c669a2
> >
> >This fixed the reproducable test case I had for the problem.
> >Can you see if it fixes your problem as well?
> We applied the above TAKE to linux-2.6.17.1 and tested it.
> However, we confirm the case that i_state of the inode was changed
> when the inode was freed in xfs filesystem.
> 
> We think that the TAKE reduces the occurrence only.
> And we think that our patch fixes the problem.
> 
> Could you review our patch again?

I'll leave it to Dave to comment more later (he's travelling at the
moment), since he's had his head deep in this area of the code most
recently - but my first thoughts on your patch are that its solving
the problem incorrectly.  We should not be in the destroy_inode code
if the inode reference counting is correct everywhere - I would have
expected the fix to be a get/put style change, rather than adding an
inode lock and new lock/unlock semantics around an individual field;
... and if that cannot be done to fix this (eh?), then some comments
as to why refcounting didn't solve the problem here.

cheers.

-- 
Nathan
