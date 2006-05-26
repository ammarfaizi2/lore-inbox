Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWEZHGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWEZHGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWEZHGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:06:46 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:12691 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751317AbWEZHGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:06:45 -0400
Message-ID: <348627203.10651@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 26 May 2006 15:06:46 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/33] readahead: page flag PG_readahead
Message-ID: <20060526070646.GC5135@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469537.16036@ustc.edu.cn> <20060525092311.0523d8bf.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060525092311.0523d8bf.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 09:23:11AM -0700, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > An new page flag PG_readahead is introduced as a look-ahead mark, which
> > reminds the caller to give the adaptive read-ahead logic a chance to do
> > read-ahead ahead of time for I/O pipelining.
> > 
> > It roughly corresponds to `ahead_start' of the stock read-ahead logic.
> > 
> 
> This isn't a very revealing description of what this flag does.

Updated to:

An new page flag PG_readahead is introduced.

It acts as a look-ahead mark, which tells the page reader:
        Hey, it's time to invoke the adaptive read-ahead logic!
        For the sake of I/O pipelining, don't wait until it runs out of
        cached pages.  ;-)

> > +#define __SetPageReadahead(page) __set_bit(PG_readahead, &(page)->flags)
> 
> uh-oh.  This is extremly risky.  Needs extensive justification, please.

Ok, removed the ugly __ :-)

Wu
