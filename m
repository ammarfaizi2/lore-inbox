Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262483AbSJDUde>; Fri, 4 Oct 2002 16:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJDUde>; Fri, 4 Oct 2002 16:33:34 -0400
Received: from [198.149.18.6] ([198.149.18.6]:47797 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262483AbSJDUdd>;
	Fri, 4 Oct 2002 16:33:33 -0400
Subject: Re: 2.5 O)DIRECT problem
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D9DFA34.581D9D98@digeo.com>
References: <1033762674.2457.73.camel@jen.americas.sgi.com> 
	<3D9DFA34.581D9D98@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Oct 2002 15:38:16 -0500
Message-Id: <1033763896.6896.101.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 15:29, Andrew Morton wrote:
> Steve Lord wrote:
> > Either the flush needs to happen before the bounds checks, or the
> > invalidate should only be done on a successful write. It looks
> > pretty hard to detect the latter case with the current structure,
> > we can get EINVAL from the bounds check and possibly from an
> > aligned, but invalid memory address being passed in.
> 
> Yes I agree; let's just do the sync before any checks.
> 
> I think it should be moved into generic_file_direct_IO(),
> because that's the place where the invalidation happens, yes?

OK, sounds good to me, I will let my tests churn away on that
version and see what happens. I think something else is doing
the same thing to me elsewhere, but it might well be an xfs
specific case.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
