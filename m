Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWEYNmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWEYNmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030180AbWEYNmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:42:23 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16272 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1030184AbWEYNmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:42:22 -0400
Message-ID: <348564538.06705@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 21:42:24 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/33] readahead: common macros
Message-ID: <20060525134224.GJ4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469539.42623@ustc.edu.cn> <44754708.5090406@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44754708.5090406@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 03:56:24PM +1000, Nick Piggin wrote:
> >+#define PAGES_BYTE(size) (((size) + PAGE_CACHE_SIZE - 1) >> 
> >PAGE_CACHE_SHIFT)
> >+#define PAGES_KB(size)	 PAGES_BYTE((size)*1024)
> >
> Don't really like the names. Don't think they do anything for clarity, but
> if you can come up with something better for PAGES_BYTE I might change my
> mind ;) (just forget about PAGES_KB - people know what *1024 means)
> 
> Also: the replacements are wrong: if you've defined VM_MAX_READAHEAD to be
> 4095 bytes, you don't want the _actual_ readahead to be 4096 bytes, do you?
> It is saying nothing about minimum, so presumably 0 is the correct choice.

Got an idea, how about these ones:

#define FULL_PAGES(bytes)    ((bytes) >> PAGE_CACHE_SHIFT)
#define PARTIAL_PAGES(bytes) (((bytes)+PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT)
