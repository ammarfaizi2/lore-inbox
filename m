Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUASLbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbUASLbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:31:41 -0500
Received: from dp.samba.org ([66.70.73.150]:36314 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264546AbUASLbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:31:39 -0500
Date: Mon, 19 Jan 2004 22:26:07 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@colin2.muc.de>
Cc: torvalds@osdl.org, rth@twiddle.net, akpm@osdl.org, jh@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add noinline attribute - new extable sort patch
Message-Id: <20040119222607.436be39a.rusty@rustcorp.com.au>
In-Reply-To: <20040119010133.GA63615@colin2.muc.de>
References: <20040114083114.GA1784@averell>
	<Pine.LNX.4.58.0401141519260.4500@evo.osdl.org>
	<20040115074834.GA38796@colin2.muc.de>
	<Pine.LNX.4.58.0401151448200.2597@evo.osdl.org>
	<20040116101345.GA96037@colin2.muc.de>
	<20040118204700.GA31601@twiddle.net>
	<20040118230743.GA12989@colin2.muc.de>
	<20040119005244.GB32149@twiddle.net>
	<20040119010133.GA63615@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jan 2004 02:01:33 +0100
Andi Kleen <ak@colin2.muc.de> wrote:

> On Sun, Jan 18, 2004 at 04:52:44PM -0800, Richard Henderson wrote:
> > I don't think that's true.  Yes, sparc and sparc64 have paired
> > entries, but they should still sort consecutive.  If there were
> > an entry that, after sorting, came between them, something would
> > be Very Wrong.
> 
> Hmm, are they really just paired? The description in
> arch/sparc64/mm/extable.c looked differently to me. Anyways - given all
> these complexities doing the sort in arch code is probably better. It
> wasn't my idea anyways to move it into generic code ;-) 

When I started the 2.5 extable consolidation, I stopped where you see today,
becuase I realized that we'd need to move "range" extable entries to a
separate section (empty on most archs) and every arch would need to supply a
cmp function for sorting each one.  Add in rth's point about needing a swap
fn, I think that it's simpler to leave it as is, maybe with a module.c call
to extable_sort() for archs which care to implement.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
