Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWCNEqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWCNEqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbWCNEqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:46:06 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2235 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932603AbWCNEqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:46:04 -0500
Date: Tue, 14 Mar 2006 10:16:00 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Nathan Scott <nathans@sgi.com>,
       Suzuki <suzuki@in.ibm.com>, linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060314044559.GA19382@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo> <20060309224219.GA6709@infradead.org> <20060309231422.GD1135@frodo> <20060310005020.GF1135@frodo> <20060310154925.GA5339@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310154925.GA5339@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 03:49:25PM +0000, Christoph Hellwig wrote:
> On Fri, Mar 10, 2006 at 11:50:20AM +1100, Nathan Scott wrote:
> > Something like this (works OK for me)...
> 
> Yeah, that should work for now.  But long-term we really need to redo
> direct I/O locking to have a common scheme for all filesystems.  I've heard
> birds whistling RH patches yet another scheme into RHEL4 for GFS an it's
> definitly already far too complex now.

Yup, getting rid of the need for all these confusing locking
modes was one of the objectives in mind for DIO simplification.
(http://www.kernel.org/pub/linux/kernel/people/suparna/DIO-simplify.txt)
Once we have an efficient range locking or similar mechanism in place
(Chris Mason is working on a patch), then it should be possible to push
out all of the i_mutex locking to higher level routines, outside of
direct-io.c.

Longer term, it would be nice to be able to rethink and further simplify
the whole _nolock equiv versions for VFS write methods. Especially the
percolation down to sync_page_range_nolock, etc.

Regards
Suparna

> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

