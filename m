Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbULQAoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbULQAoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 19:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbULQAnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 19:43:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:17282 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262069AbULQAnA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 19:43:00 -0500
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0412170133560.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412170133560.793@scrub.home>
Content-Type: text/plain
Message-Id: <1103244171.13614.2525.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Dec 2004 16:42:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 16:36, Roman Zippel wrote:
> On Thu, 16 Dec 2004, Dave Hansen wrote:
> > I'm working on breaking out the struct page definition into its
> > own file.  There seem to be a ton of header dependencies that
> > crop up around struct page, and I'd like to start getting rid
> > of thise.
> 
> Why do you want to move struct page into a separate file?

Circular header dependencies suck :)

I posted another patch, shortly after the one that I cc'd you on, with
the following description.  Cristoph suggested just making it
linux/page.h and maybe combining it with page-flags.h, but otherwise the
idea remains the same.  

> There are currently 24 places in the tree where struct page is
> predeclared.  However, a good number of these places also have to
> do some kind of arithmetic on it, and end up using macros because
> static inlines wouldn't have the type fully defined at
> compile-time.
> 
> But, in reality, struct page has very few dependencies on outside
> macros or functions, and doesn't really need to be a part of the
> header include mess which surrounds many of the VM headers.
> 
> So, put 'struct page' into structpage.h, along with a nasty comment
> telling everyone to keep their grubby mitts out of the file.
> 
> Now, we can use static inlines for almost any 'struct page'
> operations with no problems, and get rid of many of the
> predeclarations.


-- Dave

