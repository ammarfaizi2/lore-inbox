Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUGILbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUGILbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUGILbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:31:41 -0400
Received: from cfcafw.SGI.COM ([198.149.23.1]:7039 "EHLO omx1.americas.sgi.com")
	by vger.kernel.org with ESMTP id S266021AbUGILbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:31:31 -0400
Date: Fri, 9 Jul 2004 06:31:25 -0500
From: Robin Holt <holt@sgi.com>
To: Lutz Vieweg <lkv@isg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to find out which pages were copied-on-write?
Message-ID: <20040709113125.GA8897@lnx-holt.americas.sgi.com>
References: <40EACC0C.6060606@isg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40EACC0C.6060606@isg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, now that I am considering this problem,  I am trying to figure out
what problem we are trying to solve.

By reading your email, I gather that you have a single threaded
application which is doing an mmap on a file as a MAP_PRIVATE mapping.
The memory area is then handed to a library which may modify some pages.
You want to decide after the return if you had success and thereby
control the writing of the updated data back to the file.  Because of
the size of the file, doing a second mapping and comparing/copying pages
is unreasonable and you would like to only modify the pages that have
actually changed.

If that is not what you are trying to do, please give me a similar
description of _WHAT_ you are trying to do and not the _HOW_ you think
the kernel can make this easier.


On Tue, Jul 06, 2004 at 05:58:04PM +0200, Lutz Vieweg wrote:
> Hi,
> 
> in an application that MAP_PRIVATEly mmap()s a file it would
> be quite helpful for me to find out which pages have been
> copied-on-write.
> 
> I found that mincore() does a similar thing by reporting which
> pages are currently residing in physical memory, but what
> I want to know is which pages differ from the original file
> image on disk.
> 
> Can you recommend a way to do that? (does not need to be
> portable beyond Linux)
> 
> Alternatively, it would be sufficient if I could turn
> a private mapping into a shared one (and possibly do an
> msync() afterwards if I need to make sure the changes
> have been written out). Would such a feature need a
> lot of effort to implement?
> 
> 
> Yet another feature that I could use if it were available:
> A "copy-on-read"-mapping. There, a page would become a private
> copy of a process once _another_ process wrote data to the
> corresponding file location. But I suspect that feature
> could be very hard to implement...

This is a different way of thinking of copy-on-write.  I believe you
are thinking of the time when there are two processes sharing the page.
When one process takes the write fault, the page is copied and the by that
process and the other process becomes the exclusive owner of the page.

Thanks,
Robin Holt
