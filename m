Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbULKAXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbULKAXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 19:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbULKAXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 19:23:22 -0500
Received: from brown.brainfood.com ([146.82.138.61]:33447 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261895AbULKAWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 19:22:45 -0500
Date: Fri, 10 Dec 2004 18:22:37 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Matt Mackall <mpm@selenic.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Concurrent access to /dev/urandom
In-Reply-To: <20041210222306.GV8876@waste.org>
Message-ID: <Pine.LNX.4.58.0412101821330.2173@gradall.private.brainfood.com>
References: <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino>
 <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org>
 <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org>
 <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org>
 <20041210182804.GT8876@waste.org> <20041210212815.GB25409@thunk.org>
 <20041210222306.GV8876@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Matt Mackall wrote:

> On Fri, Dec 10, 2004 at 04:28:15PM -0500, Theodore Ts'o wrote:
> > On Fri, Dec 10, 2004 at 10:28:04AM -0800, Matt Mackall wrote:
> > >
> > > Fair enough. s/__add/mix/, please.
> > >
> >
> > Why?  Fundamentally, it's all about adding entropy to the pool.  I
> > don't have an strong objection to calling it __mix_entropy_words, but
> > if we're going to change it, we should change the non-__ variant for
> > consistency's sake, and I'd much rather do that in a separate patch if
> > we're going to do it all.  I don't see the point of the rename,
> > though.
>
> I suppose I don't really care. The __add is no longer just add, and
> mix was the word that came to mind. But it doesn't really describe it
> well either.
>
> > Still, I'd feel better if we did initialize more data via
> > init_std_data(), and then cranked the LFSR some number of times so
> > that we don't have to worry about analyzing the case where a good
> > portion of the pool might contain consecutive zero values.  But yeah,
> > we can save that for another patch, as it's not absolutely essential.
> >
> > Are we converging here?
>
> I'm gonna call this last iteration done. Repasted below for akpm's
> benefit. Urgency: medium-ish.

Actually, I think this is a security issue.  Since any plain old program can
read from /dev/urandom at any time, an attacker could attempt to read from
that device at the same moment some other program is doing so, and thereby
gain some knowledge as to the other program's state.
