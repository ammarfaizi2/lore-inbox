Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWFWUrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWFWUrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 16:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWFWUrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 16:47:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32690 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751550AbWFWUrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 16:47:09 -0400
Date: Fri, 23 Jun 2006 13:46:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: swhiteho@redhat.com, torvalds@osdl.org, teigland@redhat.com,
       pcaulfie@redhat.com, kanderso@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-Id: <20060623134648.a7d56d1e.akpm@osdl.org>
In-Reply-To: <20060623144928.GA32694@infradead.org>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	<20060623144928.GA32694@infradead.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 15:49:28 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, Andrew suggested to me to send this pull request to you directly.
> > Please consider merging the GFS2 filesystem and DLM from (they are both
> > in the same tree for ease of testing):
> 
> The code uses GFP_NOFAIL for slab allocator calls.

All existing users of GFP_NOFAIL are lame and should be fixed to handle
ENOMEM.  We shouldn't add new ones.

And we shouldn't open-code the retry loops to avoid attracting attention,
either ;)

>  It's been pointed out
> here numerous times that this can't work.  Andrew, what about adding
> a check to slab.c to bail out if someone passes it?

Is there anything special about slab which makes the use of GFP_NOFAIL
worse when called from the slab code?
