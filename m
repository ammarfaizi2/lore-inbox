Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJQDVh>; Wed, 16 Oct 2002 23:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJQDU7>; Wed, 16 Oct 2002 23:20:59 -0400
Received: from thunk.org ([140.239.227.29]:43473 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261678AbSJQDUW>;
	Wed, 16 Oct 2002 23:20:22 -0400
Date: Wed, 16 Oct 2002 23:26:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
Message-ID: <20021017032619.GA11954@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 05:44:59PM +0200, Stefan Schwandter wrote:
> 
> I saw capabilities and acl patches for ext2/3 enter -mm. Is it possible
> now to give an executable (that lives on an ext2/ext3 fs) the necessary
> rights to use SCHED_FIFO without being setuid root? Could someone give
> me some pointers for these topics (capabilities support in linux, acl)?

The patchs which I've been working on do not support capabilities;
just extended attributes. 

Personally, I'm not so convinced that capabilities are such a great
idea.  System administrators have a hard enough time keeping 12 bits
of permissions correct on executable files; with capabilities they
have to keep track of several hundred bits of capabilties flags, which
must be set precisely correctly, or the programs will either (a) fail
to function, or (b) have a gaping huge security hole.  

This probablem could be solved with some really scary, complex user
tools (which no one has written yet).  Alternatively you could just
let programs continue to be setuid root, but modify the executable to
explicitly drop all the capabilities except for the ones that are
actually needed as one of the first things that executable does.  It
perhaps only gives you 90% of the benefits of the full-fledged
capabilities model, but it's much more fool proof, and much easier to
administer.

						- Ted
