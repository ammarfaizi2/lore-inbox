Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUHJU5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUHJU5b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267744AbUHJU5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:57:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267743AbUHJU53
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:57:29 -0400
Date: Tue, 10 Aug 2004 16:50:10 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] reserved buffers only for PF_MEMALLOC
Message-ID: <20040810195009.GC13509@logos.cnet>
References: <Pine.LNX.4.44.0408101310580.7156-100000@dhcp83-102.boston.redhat.com> <20040810190455.GA13349@logos.cnet> <20040810204232.GA2528@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810204232.GA2528@lists.us.dell.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:42:32PM -0500, Matt Domsch wrote:
> On Tue, Aug 10, 2004 at 04:04:55PM -0300, Marcelo Tosatti wrote:
> > On Tue, Aug 10, 2004 at 01:20:24PM -0400, Rik van Riel wrote:
> > > 
> > > The buffer allocation path in 2.4 has a long standing bug,
> > > where non-PF_MEMALLOC tasks can dig into the reserved pool
> > > in get_unused_buffer_head().  The following patch makes the
> > > reserved pool only accessible to PF_MEMALLOC tasks.
> > 
> > Out of curiosity: Do you actually seen any practical problem due to 
> > get_unused_buffer_head() calls eating into the reserved pool?
> > 
> > Or have any testcase which would trigger a problem (OOM) due to it? 
> 
> My team has seen an application which mallocs as much memory as
> possible, up to 95% of system RAM, using multiple processes as
> necessary, and then has threads which touch all the malloc'd bytes and
> threads which touch all the malloc'd pages.  It keeps kswapd pretty
> busy, such that you can get down to zero free and inactive clean
> ZONE_NORMAL pages from which to allocate additional buffer_heads for
> swapout, deadlocking the system.
> 
> We believe that by limiting the use of the reserved buffer_head pool
> to PF_MEMALLOC tasks like kswapd, kswapd can make forward progress
> even in extremely low memory situations.

OK, makes sense. I assume Rik's patch fixes the deadlock you are seeing?

Have you tested it?

