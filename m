Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWHTQSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWHTQSx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWHTQSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:18:53 -0400
Received: from 1wt.eu ([62.212.114.60]:49680 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750932AbWHTQSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:18:52 -0400
Date: Sun, 20 Aug 2006 18:17:39 +0200
From: Willy Tarreau <w@1wt.eu>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820161739.GI602@1wt.eu>
References: <20060820003840.GA17249@openwall.com> <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com> <1156089203.23756.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156089203.23756.46.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 05:53:22PM +0200, Arjan van de Ven wrote:
> On Sun, 2006-08-20 at 19:30 +0400, Solar Designer wrote:
> > On Sun, Aug 20, 2006 at 12:07:06PM +0200, Alex Riesen wrote:
> > > Solar Designer, Sun, Aug 20, 2006 02:38:40 +0200:
> > > > Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> > > > set*uid() kill the current process rather than proceed with -EAGAIN when
> > > > the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> > > > and return anyway due to properties of the allocator, in which case the
> > > > patch does not change a thing.  But better safe than sorry.
> > > 
> > > Why not ENOMEM?
> > 
> > ENOMEM would not be any better than EAGAIN from the security standpoint.
> > 
> > The problem is that there are lots of privileged userspace programs that
> > do not bother to check the return value from set*uid() calls (or
> > otherwise check that the calls succeeded) before proceeding with work
> > that is only safe to do with the *uid switched as intended.
> 
> sounds like a good argument to get the setuid functions marked
> __must_check in glibc...

Agreed, as I'm sure that I've not always checked it in some of my own
programs. A warning would have helped.

Willy

