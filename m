Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUBDT4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUBDT4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:56:44 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:56793 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263861AbUBDT4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:56:42 -0500
Subject: Re: Active Memory Defragmentation: Our implementation & problems
From: Dave Hansen <haveblue@us.ibm.com>
To: Alok Mooley <rangdi@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040204185446.91810.qmail@web9705.mail.yahoo.com>
References: <20040204185446.91810.qmail@web9705.mail.yahoo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075924593.27981.458.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Feb 2004 11:56:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 10:54, Alok Mooley wrote:
> --- Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> > The "work until we get interrupted and restart if
> > something changes
> > state" approach is very, very common.  Can you give
> > some more examples
> > of just how a page fault would ruin the defrag
> > process?
> > 
> 
> What I mean to say is that if we have identified some
> pages for movement, & we get preempted, the pages
> identified as movable may not remain movable any more
> when we are rescheduled. We are left with the task of
> identifying new movable pages.

Depending on the quantity of work that you're trying to do at once, this
might be unavoidable.  

I know it's a difficult thing to think about, but I still don't
understand the precise cases that you're concerned about.  Page faults
to me seem like the least of your problems.  A bigger issue would be if
the page is written to by userspace after you copy, but before you
install the new pte.  Did I miss the code in your patch that invalidated
the old tlb entries?

--dave

