Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753557AbWKFUX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbWKFUX3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbWKFUX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:23:29 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:4285 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1753370AbWKFUX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:23:28 -0500
Date: Mon, 6 Nov 2006 21:23:13 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061106202313.GA691@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1162838843.12129.8.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 November 2006 13:47:23 -0500, Jeff Layton wrote:
> On Mon, 2006-11-06 at 11:22 -0700, Matthew Wilcox wrote:
> > On Mon, Nov 06, 2006 at 01:12:05PM -0500, Jeff Layton wrote:
> > > The attached patch remedies this by making the last_inode counter be an
> > > unsigned int on kernels that have ia32 compatability mode enabled.
> > 
> > ... and this only happens on ia64/x86_64 kernels, not sparc64, ppc64,
> > s390x, parisc64 or mips64?
> 
> Here's a new (untested) patch that replaces the ia32 specific
> compatability mode defines with CONFIG_COMPAT, as suggested by Matthew.

While you're at it, how about making last_ino per-sb instead of
system-wide?  ino collisions after a wrap are just as bad as inos
beyond 32bit.  And this should be a fairly simple method to reduce the
risk.

Also, do you have a testcase that can actually force the wrap?

Jörn

-- 
Don't patch bad code, rewrite it.
-- Kernigham and Pike, according to Rusty
