Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUFCSUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUFCSUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbUFCSUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 14:20:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:33200 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264198AbUFCSUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 14:20:44 -0400
Subject: Re: ext3_orphan_del may double-decrement bh->b_count
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jeffm@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040602194330.1a04badc.akpm@osdl.org>
References: <40BE3235.5060906@suse.com>
	 <20040602150614.005e939f.akpm@osdl.org>
	 <1086219035.22636.3524.camel@watt.suse.com>
	 <20040602180032.6c96268c.akpm@osdl.org>
	 <1086229128.22636.3540.camel@watt.suse.com>
	 <20040602194330.1a04badc.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086286864.22636.3567.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 03 Jun 2004 14:21:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-02 at 22:43, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> >
> > > You need the buffer-tracing patch.  This is against 2.6.7-rc2.  It should
> >  > spit a nice trace when you hit the problem.  It'll tell us how that buffer
> >  > got itself not uptodate.
> > 
> >  Thanks.  jeffm had worked out something similar that stored the EIP of
> >  each bit operation, the uptodate bit seems to have turned off all on its
> >  own.  Once we can reproduce reliably on local boxes, we'll start
> >  layering on the debugging code.  
> 
> buffer-trace code is what you need - it records the bh's internal state in
> its trace buffer too, replays it all when you hit an assertion failure.
> 
I think the buffers are just victims of slab corruption.  With slab
poisoning on I managed to get proof that 128 byte slabs are getting
stomped on.  I'm still searching for a reliable trigger though, tests
after that haven't failed at all.

> >  No triggers yet, I might have to grab a bigger machine in the morning.
> 
> Is direct-io involved?  I just discovered that clean_blockdev_aliases() is
> invalidating too many blocks.  It tends to munch those indirect blocks. 
> (What does bonnie++'s -f option do?)
> 
skips the per char test.  There's no O_DIRECT.  Thanks for the patch
though ;-)

-chris


