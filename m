Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265446AbUFCCSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbUFCCSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265454AbUFCCSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:18:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:36563 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265446AbUFCCS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:18:29 -0400
Subject: Re: ext3_orphan_del may double-decrement bh->b_count
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jeffm@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040602180032.6c96268c.akpm@osdl.org>
References: <40BE3235.5060906@suse.com>
	 <20040602150614.005e939f.akpm@osdl.org>
	 <1086219035.22636.3524.camel@watt.suse.com>
	 <20040602180032.6c96268c.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086229128.22636.3540.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 02 Jun 2004 22:18:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 21:00, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
>  
> > > What was the "other bug"?
> > 
> > We've got many names for it, but none that could be posted here ;-)
> 
> intrigued.
> 
Nah, just a string of curses unfit for the general public, or even lkml.

> > Looks like HP came up with a simplified test case:
> > 
> > http://sourceforge.net/mailarchive/forum.php?thread_id=4536665&forum_id=6379
> 
> hm, I never received that.  If I'd known I wouldn't have removed the
> buffer_error() stuff.
> 
I've been trying to blame this one on various other bugs until
recently.  The test case posted above is the first simple test that is
supposed to be able to reproduce.  Since ext2 also sees data corruption
issues, it's either not ext3 specific or two different bugs.

> > I've got machines trying to reproduce now.
> 
> You need the buffer-tracing patch.  This is against 2.6.7-rc2.  It should
> spit a nice trace when you hit the problem.  It'll tell us how that buffer
> got itself not uptodate.

Thanks.  jeffm had worked out something similar that stored the EIP of
each bit operation, the uptodate bit seems to have turned off all on its
own.  Once we can reproduce reliably on local boxes, we'll start
layering on the debugging code.  

No triggers yet, I might have to grab a bigger machine in the morning.

-chris

