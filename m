Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUCQAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUCQAK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:10:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:28057 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261860AbUCQAK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:10:56 -0500
Subject: Re: 2.6.4-mm2
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040316153900.1e845ba2.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	 <1079474312.4186.927.camel@watt.suse.com>
	 <20040316152106.22053934.akpm@osdl.org>
	 <20040316152843.667a623d.akpm@osdl.org>
	 <20040316153900.1e845ba2.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079482254.3100.17.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Mar 2004 16:10:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 15:39, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > I'm thinking that the right thing to do here is to change submit_bh()
> > > callers and ll_rw_block() to run set_page_writeback(bh->b_page) when they
> > > start the buffer writeout and to do the run-around-the-buffer_heads thing
> > > at I/O completion.
> > 
> > A page may have a mix of writeback and dirty+non-writeback buffers.  It
> > appears that the page-level writeback code will handle this correctly.  But
> > it requires that the page lock be held when we run set_page_writeback(), so
> > that tears that.  hmm.
> 
> I'll work this out yet.
> 
> We change the PageWriteback() predicate to go in and see if any of the
> buffer_heads are under I/O too.  And we change wait_on_page_writeback() to
> also wait on any buffer_heads.
> 
> That means two new silly address_space ops.  Or a new page flag which means
> "the thing at ->private is buffer_heads".  Probably the latter.


If buffer_heads are in flight and a SYNC_NONE writeback happens,
will checking the buffer_heads cause to writeback to block?

Daniel 

