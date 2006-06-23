Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWFWQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWFWQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWFWQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:01:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751713AbWFWQBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:01:24 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060623155444.GA5504@infradead.org>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <20060623145409.GB32694@infradead.org>
	 <1151078044.3856.1595.camel@quoit.chygwyn.com>
	 <20060623155444.GA5504@infradead.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 23 Jun 2006 17:09:31 +0100
Message-Id: <1151078971.3856.1601.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-06-23 at 16:54 +0100, Christoph Hellwig wrote:
> On Fri, Jun 23, 2006 at 04:54:04PM +0100, Steven Whitehouse wrote:
> > with just calling permission directly... we need to call it mainly because
> > the VFS only does locking within a single node and we recheck the permissions
> > in a few places after we've taken the glocks which provide cluster-wide
> > exclusion.
> 
> ->permission must give correct answers.  So I think the answer to your question
> is that you need to do the right thing there and get rid of the additional
> calls.
> 

It does give correct answers. The point is that the answer might change
between ->permission dropping its lock and the actual operation taking
place since there is a time for which the lock is not held where other
nodes might race. To get around this we recheck the permissions in GFS2
to ensure that nothing has changed,

Steve.


