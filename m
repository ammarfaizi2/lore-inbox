Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbWHJSWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbWHJSWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHJSWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:22:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751186AbWHJSWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:22:37 -0400
Date: Thu, 10 Aug 2006 11:18:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
Message-Id: <20060810111839.51c73911.akpm@osdl.org>
In-Reply-To: <44DB61D7.1000109@us.ibm.com>
References: <1155172622.3161.73.camel@localhost.localdomain>
	<20060809233914.35ab8792.akpm@osdl.org>
	<44DB61D7.1000109@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 09:41:59 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> Andrew Morton wrote:
> 
> > On Wed, 09 Aug 2006 18:17:02 -0700
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > 
> > 
> >>Fork(copy) ext4 filesystem from ext3 filesystem. Rename all functions in ext4 from ext3_xxx() to ext4_xxx().
> > 
> > 
> > It would have been nice to spend a few hours cleaning up ext3 and JBD
> > before doing this.  The code isn't toooo bad, but there are number of
> > coding style problems, whitespace screwups, incorrect comments, missing
> > comments, poorly-chosen variable names and all of that sort of thing.
> >
> > One the fs has been copied-and-pasted, it's much harder to address these
> > things: either need to do it twice, or allow the filesystems to diverge, or
> > not do it.
> >
> Andrew, thanks for taking a close look this series of changes.
> 
> I agree with you that the timing is right, to do the clean up now rather 
> than later. I would give it a try. If I could get more help from more 
> code reviewer, it probably makes the effort a lot easier. For those 
> issues you pointed out : coding style problem___incorrect comments, 
> poorly-named variables  -- do you have any specific examples in your mind?

Not really, apart from the few things I identified elsewhere (such as the
brelse thing).

It's just that now is the right time for a general spring-cleaning, if we
ever want to do that.

> > Also, -mm presently has two patches pending against fs/jbd/ and nine pending
> > against fs/ext3/.  We should get all those things merged before taking the
> > copy.
> > 
> So probably the right thing to do is keep the ext4 patches against mm 
> tree instead of rc three?

That would drive everyone nuts, I think.  What I would suggest is:

- get ext3 into a ready-to-copy state (merge bugfixes, spring-clean, etc)

- do the big copy-n-rename operation in Linus's tree.

- run a quilt or git tree against the resulting Linus tree.

