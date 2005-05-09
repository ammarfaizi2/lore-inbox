Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVEIJ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVEIJ0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 05:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVEIJ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 05:26:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:36050 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261174AbVEIJZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 05:25:58 -0400
Date: Mon, 9 May 2005 11:25:45 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Cliff White <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com
Subject: Re: 2.6.12-rc2 + rc3: reaim with ext3 - system stalls.
Message-ID: <20050509092542.GD10739@atrey.karlin.mff.cuni.cz>
References: <20050421152345.6b87aeae@es175> <20050503144325.GF4501@atrey.karlin.mff.cuni.cz> <1115132463.26913.828.camel@dyn318077bld.beaverton.ibm.com> <E1DTMKq-00043x-BO@es175> <1115315827.26913.907.camel@dyn318077bld.beaverton.ibm.com> <20050506101434.GC25677@atrey.karlin.mff.cuni.cz> <1115392011.26913.930.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115392011.26913.930.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  <snip>
> >   Or rewrite __mpage_writepages() to lock a page range (e.g. lock pages
> > until we find some on which we'd block) and then call some filesystem
> > routine to write-out all the locked pages (which would start a
> > transaction and so on). But this is more work.
> 
> We are re-writing mpage_writepages() anyway for supporting delayed
> and multiblock allocation. So I will talk to Suparna and see if we
> can do this also. But this requires more calls to figure out, if we
> need block allocation and then start the transaction. (getblock(READ)
> followed by getblock(WRITE) after starting transaction). Isn't it ?
  If I'm not missing something, you could just start a transaction
everytime and do just getblock(WRITE) (which would not do anything if
the block is already allocated), couldn't you?. The only question is whether
getblock(READ) costs more than the possibly unnecessary start of a
transaction. I guess that's hard to say without some benchmarking.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
