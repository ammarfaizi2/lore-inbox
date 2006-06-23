Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751770AbWFWQsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbWFWQsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWFWQsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:48:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25742 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751770AbWFWQsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:48:32 -0400
Date: Fri, 23 Jun 2006 17:48:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060623164823.GA12480@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Teigland <teigland@redhat.com>,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623150040.GA1197@infradead.org> <1151080174.3856.1606.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151080174.3856.1606.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 05:29:34PM +0100, Steven Whitehouse wrote:
> Hi,
> 
> On Fri, 2006-06-23 at 16:00 +0100, Christoph Hellwig wrote:
> > On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > > Hi,
> > > 
> > > Linus, Andrew suggested to me to send this pull request to you directly.
> > > Please consider merging the GFS2 filesystem and DLM from (they are both
> > > in the same tree for ease of testing):
> > 
> > A new normal filesystem (aka everything but procfs) shouldn't implement
> > ->readlink but use generic_readlink instead.
> > 
> 
> The comment above generic_readlink has this to say:
> 
> /*
>  * A helper for ->readlink().  This should be used *ONLY* for symlinks that
>  * have ->follow_link() touching nd only in nd_set_link().  Using (or not
>  * using) it for any given inode is up to filesystem.
>  */
> 
> which appears, at least, to contradict what you are saying. I'll put it
> on my list to look at again, but a straight substitution of
> generic_readlink() does not work, so I'd prefer to leave it as it is for
> the moment,

The above is the common and preffered case.  The only intree filesystem
not doing it is procfs.

