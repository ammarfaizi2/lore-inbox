Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292681AbSBUSA1>; Thu, 21 Feb 2002 13:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292683AbSBUSAT>; Thu, 21 Feb 2002 13:00:19 -0500
Received: from www.wen-online.de ([212.223.88.39]:60428 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S292681AbSBUSAF>;
	Thu, 21 Feb 2002 13:00:05 -0500
Date: Thu, 21 Feb 2002 19:11:14 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Joe Wong <joewong@tkodog.no-ip.com>, linux-kernel@vger.kernel.org
Subject: Re: detect memory leak tools?
In-Reply-To: <Pine.LNX.3.95.1020221104124.20988A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.10.10202211902290.842-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Richard B. Johnson wrote:

> On Thu, 21 Feb 2002, Joe Wong wrote:
> 
> > Hi,
> > 
> >   Is there any tools that can detect memory leak in kernel loadable 
> > module?
> > 
> > TIA.
> > 
> > - Joe
> 
> How would it know? If you can answer that question, you have made
> the tool. It would be specific to your module. FYI, in designing
> such a tool, you often the find the leak, which means you don't
> need the tool anymore.
> 
> I would start by temporarily putting a wrapper around whatever you
> use for memory allocation and deallocation. The wrapper code keeps
> track of pointer values and outstanding allocations. If the outstanding
> allocations grow or if the pointers to whatever_free() are different
> than the pointers to whatever_alloc(), you have a leak. You can read
> the results from a private ioctl().

Close to how memleak works.  Wrap all allocators, and maintain a 1/32
scale model of memory consisting of tags showing who allocated that
ram-clod when.  Read allocation array via proc.

For most leaks, you're right.. the tool is too much horsepower for
the problem.  Memleak has found some very non-trivial leaks though.
It found one that was irritating Ingo quite a bit, and he designed
memleak :)

	-Mike

