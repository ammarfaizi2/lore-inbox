Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbULKUlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbULKUlG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbULKUlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 15:41:06 -0500
Received: from waste.org ([209.173.204.2]:63427 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262012AbULKUlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:41:01 -0500
Date: Sat, 11 Dec 2004 12:40:29 -0800
From: Matt Mackall <mpm@selenic.com>
To: Adam Heath <doogie@debian.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041211204028.GZ8876@waste.org>
References: <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org> <20041210182804.GT8876@waste.org> <20041210212815.GB25409@thunk.org> <20041210222306.GV8876@waste.org> <Pine.LNX.4.58.0412101821330.2173@gradall.private.brainfood.com> <20041211173317.GA28382@thunk.org> <Pine.LNX.4.58.0412111358150.2173@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412111358150.2173@gradall.private.brainfood.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 01:58:45PM -0600, Adam Heath wrote:
> On Sat, 11 Dec 2004, Theodore Ts'o wrote:
> 
> > On Fri, Dec 10, 2004 at 06:22:37PM -0600, Adam Heath wrote:
> > >
> > > Actually, I think this is a security issue.  Since any plain old program can
> > > read from /dev/urandom at any time, an attacker could attempt to read from
> > > that device at the same moment some other program is doing so, and thereby
> > > gain some knowledge as to the other program's state.
> >
> > It could be a potential exploit, but....
> >
> > 	(a) it only applies on SMP machines
> > 	(b) it's not a remote exploit; the attacker needs to have
> > 		the ability to run arbitrary programs on the local
> > 		machine
> > 	(c) the attacker won't get all of other programs' reads of
> > 		/dev/urandom, and
> > 	(d) the attacker would have to have a program continuously
> > 		reading from /dev/urandom, which would take up enough
> > 		CPU time that it would be rather hard to hide.
> >
> > That's not to say that we shouldn't fix it at our earliest
> > convenience, and I'd urge Andrew to push this to Linus for 2.6.10 ---
> > but I don't think we need to move heaven and earth to try to
> > accelerate the 2.6.10 release process, either.
> 
> Is it a problem for other kernel versions?  2.4?  Shouldn't this patch be
> pushed out separately to distributions?

It's a problem for all kernels back to 1.3.57 (when SMP was added) and
perhaps earlier for kernel-internal get_random_bytes users. Fixing
pre-2.6 means backporting the whole driver but not the changes in the
network area.

-- 
Mathematics is the supreme nostalgia of our time.
