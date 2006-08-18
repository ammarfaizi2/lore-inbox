Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWHRFe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWHRFe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 01:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWHRFe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 01:34:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30950 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964787AbWHRFez (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 01:34:55 -0400
Date: Thu, 17 Aug 2006 22:34:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow
 writeback.
Message-Id: <20060817223446.10ef5e8e.akpm@osdl.org>
In-Reply-To: <1155831532.5620.12.camel@localhost>
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<17635.59821.21444.287979@cse.unsw.edu.au>
	<1155820912.5662.39.camel@localhost>
	<20060817083035.8b775b12.akpm@osdl.org>
	<1155831532.5620.12.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 12:18:52 -0400
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Thu, 2006-08-17 at 08:30 -0700, Andrew Morton wrote:
> > On Thu, 17 Aug 2006 09:21:51 -0400
> > Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> > > Exactly how would a request limit help? All that boils down to is having
> > > the VM monitor global_page_state(NR_FILE_DIRTY) versus monitoring
> > > global_page_state(NR_FILE_DIRTY)+global_page_state(NR_WRITEBACK).
> > > 
> > 
> > I assume that if NFS is not limiting its NR_WRITEBACK consumption and block
> > devices are doing so, we could get in a situation where NFS hogs all of the
> > fixed-size NR_DIRTY+NR_WRITEBACK resource at the expense of concurrent
> > block-device-based writeback.
> 
> Since NFS has no control over NR_DIRTY, how does controlling
> NR_WRITEBACK help? The only resource that NFS shares with the block
> device writeout queues is memory.

Block devices have a limit on the amount of IO which they will queue.  NFS
doesn't.

> IOW: The resource that needs to be controlled is the dirty pages, not
> the write-out queue. Unless you can throttle back on the creation of
> dirty NFS pages in the first place, then the potential for unfairness
> will exist.

Please read the whole thread - we're violently agreeing.
