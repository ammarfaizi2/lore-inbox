Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWHTPej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWHTPej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWHTPej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:34:39 -0400
Received: from mother.openwall.net ([195.42.179.200]:25792 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750806AbWHTPei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:34:38 -0400
Date: Sun, 20 Aug 2006 19:30:37 +0400
From: Solar Designer <solar@openwall.com>
To: Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820153037.GA20007@openwall.com>
References: <20060820003840.GA17249@openwall.com> <20060820100706.GB6003@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820100706.GB6003@steel.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 12:07:06PM +0200, Alex Riesen wrote:
> Solar Designer, Sun, Aug 20, 2006 02:38:40 +0200:
> > Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> > set*uid() kill the current process rather than proceed with -EAGAIN when
> > the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> > and return anyway due to properties of the allocator, in which case the
> > patch does not change a thing.  But better safe than sorry.
> 
> Why not ENOMEM?

ENOMEM would not be any better than EAGAIN from the security standpoint.

The problem is that there are lots of privileged userspace programs that
do not bother to check the return value from set*uid() calls (or
otherwise check that the calls succeeded) before proceeding with work
that is only safe to do with the *uid switched as intended.

Alexander
