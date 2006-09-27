Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWI0AVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWI0AVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 20:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWI0AVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 20:21:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750781AbWI0AVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 20:21:46 -0400
Date: Tue, 26 Sep 2006 17:21:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       ext2-devel@lists.sourceforge.net, reiserfs-dev@namesys.com
Subject: Re: [2.6.18-rc7-mm1] slow boot
Message-Id: <20060926172124.0c0ee5f6.akpm@osdl.org>
In-Reply-To: <4519BC3C.1040700@imap.cc>
References: <4516B966.3010909@imap.cc>
	<20060924145337.ae152efd.akpm@osdl.org>
	<4519BC3C.1040700@imap.cc>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 01:48:12 +0200
Tilman Schmidt <tilman@imap.cc> wrote:

> On 24.09.2006 23:53, Andrew Morton wrote:
> > make-ext3-mount-default-to-barrier=1.patch takes my laptop's bootup time
> > from 53 seconds to 68, which is rather painful.  In fact I'm inclined to
> > drop the patch because of this, and I'd also be quite concerned about the
> > similar reiserfs patch, make-reiserfs-default-to-barrier=flush.patch.
> [...]
> > Do you have the time to go through the
> > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> > process?
> 
> Ok, so far I've narrowed it down to the section between
> #X64_64-START
> and
> #X64_64-END

argh.

> which I guess lets make-{ext3-mount,reiserfs}-default-to-barrier=1.patch
> off the hook for now.
> 
> Trying to bisect further into that section now,

Thanks.  You may find that none of it compiles, and you'll need to take the
four or five patches immediately after #X64_64-END (ie: fixes against the
x86_64 tree) and place them at the appropriate places immediately after the
x86_64-mm-<whatever>.patch which they fix.

Specifically, put fix-x86_64-mm-i386-pda-smp-processorid.patch immediately
after x86_64-mm-i386-pda-smp-processorid.patch and put
fix-x86_64-mm-spinlock-cleanup.patch immediately after
x86_64-mm-spinlock-cleanup.patch.

> but perhaps that'll
> already trigger some thoughts?

Nope, there's a huge amount of stuff in there.  And it's pretty much all in
mainline as of a couple of hours ago, so bisecting the tree which you have
there is increasingly valuable.

Thanks for persisting with this.
