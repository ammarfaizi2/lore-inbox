Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVHJHVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVHJHVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVHJHVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:21:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29399 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965028AbVHJHVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:21:53 -0400
Date: Wed, 10 Aug 2005 08:21:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Zach Brown <zab@zabbo.net>, David Teigland <teigland@redhat.com>,
       Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
Subject: Re: GFS
Message-ID: <20050810072121.GA2825@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>, Zach Brown <zab@zabbo.net>,
	David Teigland <teigland@redhat.com>,
	Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
	mark.fasheh@oracle.com
References: <20050802071828.GA11217@redhat.com> <84144f0205080203163cab015c@mail.gmail.com> <20050803063644.GD9812@redhat.com> <courier.42F768D5.000046F2@courier.cs.helsinki.fi> <42F7A557.3000200@zabbo.net> <1123598983.10790.1.camel@haji.ri.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123598983.10790.1.camel@haji.ri.fi>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 05:49:43PM +0300, Pekka Enberg wrote:
> On Mon, 2005-08-08 at 11:32 -0700, Zach Brown wrote:
> > > Sorry if this is an obvious question but what prevents another thread
> > > from doing mmap() before we do the second walk and messing up num_gh?
> > 
> > Nothing, I suspect.  OCFS2 has a problem like this, too.  It wants a way
> > for a file system to serialize mmap/munmap/mremap during file IO.  Well,
> > more specifically, it wants to make sure that the locks it acquired at
> > the start of the IO really cover the buf regions that might fault during
> > the IO.. mapping activity during the IO can wreck that.
> 
> In addition, the vma walk will become an unmaintainable mess as soon as
> someone introduces another mmap() capable fs that needs similar locking.

We already have OCFS2 in -mm that does similar things.  I think we need
to solve this in common code before either of them can be merged.

