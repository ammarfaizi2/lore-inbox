Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWEYMMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWEYMMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWEYMMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:12:08 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:64452 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965124AbWEYMMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:12:07 -0400
Message-ID: <348559122.14768@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 20:12:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/33] readahead: min/max sizes
Message-ID: <20060525121206.GI4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469541.17438@ustc.edu.cn> <447537B3.7050707@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447537B3.7050707@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 02:50:59PM +1000, Nick Piggin wrote:
> Wu Fengguang wrote:
> 
> >- Enlarge VM_MAX_READAHEAD to 1024 if new read-ahead code is compiled in.
> > This value is no longer tightly coupled with the thrashing problem,
> > therefore constrained by it. The adaptive read-ahead logic merely takes
> > it as an upper bound, and will not stick to it under memory pressure.
> >
> 
> I guess this size enlargement is one of the main reasons your
> patchset improves performance in some cases.

Sure, I started the patch to fulfill the 1M _default_ size dream ;-)
The majority users will never enjoy the performance improvement if
ever we stick to 128k default size.  And it won't be possible for the
current readahead logic, since it lacks basic thrashing protection
mechanism.

> There is currently some sort of thrashing protection in there.
> Obviously you've found it to be unable to cope with some situations
> and introduced a lot of really fancy stuff to fix it. Are these just
> academic access patterns, or do you have real test cases that
> demonstrate this failure (ie. can we try to incrementally improve
> the current logic as well as work towards merging your readahead
> rewrite?)

But to be serious, in the progress I realized that it's much more
beyond the max readahead size. The fancy features are more coming out
of _real_ needs than to fulfill academic goals. I've seen real world
improvements from desktop/file server/backup server/database users
for most of the implemented features.

Wu
