Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbULPWvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbULPWvY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbULPWte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:49:34 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45242 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262058AbULPWqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:46:05 -0500
Subject: Re: [patch] [RFC] move 'struct page' into its own header
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20041216222513.GA15451@infradead.org>
References: <E1Cf3jM-00034h-00@kernel.beaverton.ibm.com>
	 <20041216222513.GA15451@infradead.org>
Content-Type: text/plain
Message-Id: <1103237161.13614.2388.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Dec 2004 14:46:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 14:25, Christoph Hellwig wrote:
> On Thu, Dec 16, 2004 at 02:04:15PM -0800, Dave Hansen wrote:
> > So, put 'struct page' into structpage.h, along with a nasty comment
> > telling everyone to keep their grubby mitts out of the file.

> What about calling it page.h?  structfoo.h sounds like a really strange
> name.

The only reason I didn't do that is that there is already an
asm/page.h.  But, linux/page.h would be a fine name, too.

> And while you're at it page-flags.h should probably be merged into
> it.

The only tricky part might be page-flags.h includes asm/pgtable.h, which
(on i386) includes linux/slab.h, which includes asm/page.h.  This might
somewhat restrict the number of places that the new header can be
included.  As it stands, it can be included (and get you a full
definition of struct page) almost anywhere.

But, I'm not quite sure why page-flags.h even needs asm/pgtable.h.  I
just took it out in i386, and it still compiles just fine.  Maybe it is
needed for another architecture.

-- Dave

