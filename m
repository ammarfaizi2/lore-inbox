Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWEYOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWEYOik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWEYOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:38:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14294 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030194AbWEYOij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:38:39 -0400
Date: Thu, 25 May 2006 07:38:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/33] readahead: common macros
Message-Id: <20060525073802.7e64f563.akpm@osdl.org>
In-Reply-To: <348564538.06705@ustc.edu.cn>
References: <20060524111246.420010595@localhost.localdomain>
	<348469539.42623@ustc.edu.cn>
	<44754708.5090406@yahoo.com.au>
	<348564538.06705@ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> On Thu, May 25, 2006 at 03:56:24PM +1000, Nick Piggin wrote:
> > >+#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> 
> > >PAGE_CACHE_SHIFT)
> > >+#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
> > >
> > Don't really like the names. Don't think they do anything for clarity, but
> > if you can come up with something better for PAGES_BYTE I might change my
> > mind ;) (just forget about PAGES_KB - people know what *1024 means)
> > 
> > Also: the replacements are wrong: if you've defined VM_MAX_READAHEAD to be
> > 4095 bytes, you don't want the _actual_ readahead to be 4096 bytes, do you?
> > It is saying nothing about minimum, so presumably 0 is the correct choice.
> 
> Got an idea, how about these ones:
> 
> #define FULL_PAGES(bytes)    ((bytes) >> PAGE_CACHE_SHIFT)

I dunno.  We've traditionally open-coded things like this.

> #define PARTIAL_PAGES(bytes) (((bytes)+PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT)

That's identical to include/linux/kernel.h:DIV_ROUND_UP(), from the gfs2 tree.
