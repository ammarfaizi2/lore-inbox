Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUBQVhJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266630AbUBQVeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:34:06 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:1006 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S266608AbUBQVdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:33:44 -0500
Date: Tue, 17 Feb 2004 16:33:34 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@ruby.engin.umich.edu
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <Linux-MM@kvack.org>
Subject: Re: [PATCH] mremap NULL pointer dereference fix
In-Reply-To: <Pine.LNX.4.58.0402162203230.2154@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0402171621110.29417-100000@ruby.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > This saves a goto.   It works, but I wasn't able to trigger
> > the oops without it either.
>
> To trigger the bug you have to have _just_ the right memory usage, I
> suspect. You literally have to have the destination page directory
> allocation unmap the _exact_ source page (which has to be clean) for the
> bug to hit.

A minor point. It is not necessary for the src to be clean because a
parallel truncate can also invalidate the src. Actually, my test program
uses truncate to invalidate the src.

> Your version of the patch saves a goto in the source, but results in an
> extra goto in the generated assembly unless the compiler is clever enough
> to notice the double test for NULL.
>
> Never mind, that's a micro-optimization, and your version is cleaner.

Yeah. Andrew's patch is lot cleaner than my _crap_ patch.

> Let's go with it if Rajesh can verify that it fixes the problem for him.

Yeap. Andrew's patch fixes the problem. I did put in a printk along with
Andrew's patch to check whether the NULL src condition repeats. I could
trigger the condition again, and the machine didn't oops because of the
patch.

Thanks,
Rajesh


