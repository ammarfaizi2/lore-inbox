Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSJJWpL>; Thu, 10 Oct 2002 18:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJJWpL>; Thu, 10 Oct 2002 18:45:11 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11539
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S262324AbSJJWpK>; Thu, 10 Oct 2002 18:45:10 -0400
Date: Thu, 10 Oct 2002 15:50:50 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       Mark Mielke <mark@mark.mielke.cc>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>, andersen@codepoet.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010225050.GC2673@matchmail.com>
Mail-Followup-To: Giuliano Pochini <pochini@shiny.it>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
	Mark Mielke <mark@mark.mielke.cc>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>, andersen@codepoet.org
References: <1034221067.794.505.camel@phantasy> <XFMail.20021010153919.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20021010153919.pochini@shiny.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 03:39:19PM +0200, Giuliano Pochini wrote:
> 
> > Look, the pagecache is already smart.  New stuff will replace unusued
> > old stuff.  On VM pressure, the pagecache will be pruned.  Streaming I/O
> > is a fundamentally different problem in that the data is so large it
> > _continually_ thrashes the pagecache.  Such I/O is sequential and
> > use-once.  You end up with a permanent waste of memory (the cached
> > I/O).
> 
> When a process opens a file with O_STREAMING, it tells the kernel
> it will use the data only once, but it tells nothing about other
> tasks. If that process reads something which is already cached,
> then it must not drop it because someone other used it recently
> and IMHO pagecache only should be allowed to drop it.
>

You are missing the point.  If the app thinks that might happen, it
shouldn't use O_STREAMING.

Though, how do you get around some binary app using O_STREAMING when it
shouldn't?
