Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUASBAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 20:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264314AbUASBAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 20:00:47 -0500
Received: from colin2.muc.de ([193.149.48.15]:2061 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264313AbUASBAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 20:00:46 -0500
Date: 19 Jan 2004 02:01:33 +0100
Date: Mon, 19 Jan 2004 02:01:33 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute - new extable sort patch
Message-ID: <20040119010133.GA63615@colin2.muc.de>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org> <20040116101345.GA96037@colin2.muc.de> <20040118204700.GA31601@twiddle.net> <20040118230743.GA12989@colin2.muc.de> <20040119005244.GB32149@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119005244.GB32149@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 04:52:44PM -0800, Richard Henderson wrote:
> On Mon, Jan 19, 2004 at 12:07:43AM +0100, Andi Kleen wrote:
> > I looked at it more closely now. Alpha (and IA64 which uses the same
> > format) would be relatively easy to do. But sparc and sparc64 have a
> > very strange different format which would be too complicated to handle.
> 
> I don't think that's true.  Yes, sparc and sparc64 have paired
> entries, but they should still sort consecutive.  If there were
> an entry that, after sorting, came between them, something would
> be Very Wrong.

Hmm, are they really just paired? The description in arch/sparc64/mm/extable.c
looked differently to me. Anyways - given all these complexities
doing the sort in arch code is probably better. It wasn't my idea anyways
to move it into generic code ;-) 

It's probably not very critical for the other architectures anyways
because they likely don't depend on exception tables working in __init
functions (and if they do they likely already have an own sort function)

-Andi

