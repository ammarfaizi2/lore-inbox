Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUHTIjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUHTIjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267900AbUHTIjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:39:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:49611 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267829AbUHTIid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:38:33 -0400
Date: Fri, 20 Aug 2004 01:36:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: filemap_fdatawait() wait_on_page_writeback_range(mapping, 0,
 -1)?
Message-Id: <20040820013639.2d9d2206.akpm@osdl.org>
In-Reply-To: <1092990808.20987.8.camel@imp.csi.cam.ac.uk>
References: <20040819201729.GC5278@logos.cnet>
	<20040819144947.7ad18256.akpm@osdl.org>
	<1092990808.20987.8.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> > >   */
>  > >  int filemap_fdatawait(struct address_space *mapping)
>  > >  
>  > > -       return wait_on_page_writeback_range(mapping, 0, -1);
>  > > +       return wait_on_page_writeback_range(mapping, 0, i_size_read(mapping->host));
>  > >  }
>  > 
>  > That would need a >> PAGE_CACHE_SHIFT
> 
>  Um, what happens to the last partial page?  Perhaps this is necessary:
> 
>  (i_size_read(mapping->host) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT

/*
 * Wait for writeback to complete against pages indexed by start->end
 * inclusive
 */
static int wait_on_page_writeback_range(struct address_space *mapping,
				pgoff_t start, pgoff_t end)


(start,end) is an inclusive range specifically because of the
do-it-for-the-whole-file requirement.

