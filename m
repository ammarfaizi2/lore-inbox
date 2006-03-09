Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751967AbWCIXSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbWCIXSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWCIXSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:18:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56249 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751954AbWCIXSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:18:20 -0500
Date: Fri, 10 Mar 2006 10:14:22 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Suzuki <suzuki@in.ibm.com>, linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060309231422.GD1135@frodo>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309224219.GA6709@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 10:42:19PM +0000, Christoph Hellwig wrote:
> On Fri, Mar 10, 2006 at 09:30:42AM +1100, Nathan Scott wrote:
> > Not for reads AFAICT - __generic_file_aio_read + own-locking
> > should always have released i_mutex at the end of the direct
> > read - are you thinking of writes or have I missed something?
> 
> if an error occurs before a_ops->direct_IO is called __generic_file_aio_read
> will return with i_mutex still locked.  Note that checking for negative
> return values is not enough as __blockdev_direct_IO can return errors
> aswell.

*groan* - right you are.  Another option may be to have the
generic dio+own-locking case reacquire i_mutex if it drops
it, before returning... thoughts?  Seems alot less invasive
than the filemap.c code dup'ing thing.

cheers.

-- 
Nathan
