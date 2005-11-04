Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbVKDE6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbVKDE6N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbVKDE6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:58:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161052AbVKDE6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:58:12 -0500
Date: Thu, 3 Nov 2005 20:58:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: zach.brown@oracle.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org,
       mark.fasheh@oracle.com
Subject: Re: [Patch] add AOP_TRUNCATED_PAGE, prepend AOP_ to
 WRITEPAGE_ACTIVATE
Message-Id: <20051103205802.31121fc4.akpm@osdl.org>
In-Reply-To: <20051103165306.GA4923@infradead.org>
References: <43667913.4030401@oracle.com>
	<20051103124536.0191bea6.akpm@osdl.org>
	<20051103074312.GQ11488@ca-server1.us.oracle.com>
	<20051103165306.GA4923@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Nov 02, 2005 at 11:43:12PM -0800, Joel Becker wrote:
> > > Looks sane to me.   Can you carry this in the ocfs2 tree?
> > 
> > 	No problem.  Give us a day or two to merge the changes to our
> > main trees.
> 
> I think I disagree with Andew here.  Having a core patch separate
> from a new drivers/filesystem/etc.. is always a good idea.  It makes
> reviewing a lot easier and allows independant handling, e.g. merging it
> earlier than the new driver for some reason - as happened for example
> with the clear_inode changes we needed earlier for ocfs or the pagevec
> exports that came in via the reiser4 patches but were needed in mainline
> for cifs now.

Yes, that's better from a code staging/reviewing pov.

But there's a practical problem: if I put the patch in -mm for testing, and
the ocfs2 guys put the patch into their git tree for their testing, I get
rejects.  So I drop the core patch from -mm again.  If the ocfs guys _dont_
put the patch into their tree, they need to add this additional patch for
their testing.  It's all screwed up.

So for both -mm and for the ocfs2 team, leaving the patch in the ocfs2 git
tree is the most convenient place for it.

Obviously, merging it into Linus's tree will fix up everyone's patching
problems, but it has no users at this time...
