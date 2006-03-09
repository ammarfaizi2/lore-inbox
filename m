Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWCIWei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWCIWei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCIWei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:34:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33458 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751136AbWCIWeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:34:37 -0500
Date: Fri, 10 Mar 2006 09:30:42 +1100
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060309223042.GC1135@frodo>
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309120306.GA26682@infradead.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 12:03:06PM +0000, Christoph Hellwig wrote:
> On Thu, Mar 09, 2006 at 01:24:38PM +0530, Suzuki wrote:
> > 
> > Missed out linux-aio & linux-fs-devel lists. Forwarding.
> > 
> > Comments ?
> 
> I've seen this too.  The problem is that __generic_file_aio_read can return
> with or without the i_mutex locked in the direct I/O case for filesystems
> that set DIO_OWN_LOCKING.

Not for reads AFAICT - __generic_file_aio_read + own-locking
should always have released i_mutex at the end of the direct
read - are you thinking of writes or have I missed something?

> It's a nasty one and I haven't found a better solution
> than copying lots of code from filemap.c into xfs.

Er, eek?  Hopefully thats not needed - from my reading of the
code, all the i_mutex locking for direct reads lives inside
direct-io.c, not filemap.c -- is the solution from my other
mail not workable?  (isn't it only writes that has the wierd
buffered I/O fallback + i_sem/i_mutex locking interaction?).

thanks.

-- 
Nathan
