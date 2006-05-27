Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWE0CMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWE0CMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWE0CMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:12:45 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:4309 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751761AbWE0CMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:12:45 -0400
Message-ID: <348695962.25458@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Sat, 27 May 2006 10:12:52 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/33] readahead: context based method
Message-ID: <20060527021252.GB7418@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469544.17438@ustc.edu.cn> <20060526102343.625a16a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526102343.625a16a8.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 10:23:43AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > +#define PAGE_REFCNT_0           0
> >  +#define PAGE_REFCNT_1           (1 << PG_referenced)
> >  +#define PAGE_REFCNT_2           (1 << PG_active)
> >  +#define PAGE_REFCNT_3           ((1 << PG_active) | (1 << PG_referenced))
> >  +#define PAGE_REFCNT_MASK        PAGE_REFCNT_3
> >  +
> >  +/*
> >  + * STATUS   REFERENCE COUNT
> >  + *  __                   0
> >  + *  _R       PAGE_REFCNT_1
> >  + *  A_       PAGE_REFCNT_2
> >  + *  AR       PAGE_REFCNT_3
> >  + *
> >  + *  A/R: Active / Referenced
> >  + */
> >  +static inline unsigned long page_refcnt(struct page *page)
> >  +{
> >  +        return page->flags & PAGE_REFCNT_MASK;
> >  +}
> >  +
> 
> This assumes that PG_referenced < PG_active.  Nobody knows that this
> assumption was made and someone might go and reorder the page flags and
> subtly break readahead.
> 
> We need to either not do it this way, or put a big comment in page-flags.h,
> or even redefine PG_active to be PG_referenced+1.

I have had a code segment like:

#if PG_active < PG_referenced
#  error unexpected page flags order
#endif

I'd add it back.
