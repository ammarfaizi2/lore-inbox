Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129438AbRCHS0P>; Thu, 8 Mar 2001 13:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRCHS0F>; Thu, 8 Mar 2001 13:26:05 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:33459 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129438AbRCHSZq>; Thu, 8 Mar 2001 13:25:46 -0500
Date: Thu, 8 Mar 2001 18:26:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: "J . A . Magallon" <jamagallon@able.es>,
        MATSUSHIMA Akihiro <amatsus@jaist.ac.jp>,
        Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Can't compile 2.4.2-ac14
In-Reply-To: <3AA6DBA3.A38C0543@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0103081735250.1646-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Andrew Morton wrote:
> "J . A . Magallon" wrote:
> > Try this:
> This is the better fix.

I'm interested in the thinking here (because I tend the other way).

With J.A.M.'s patch blessed by Andrew, #ifdef CONFIG_DEBUG_BUGVERBOSE
goes around do_BUG() in fault.c, around its extern declaration in
page.h, and around its export in i386_ksyms.c.  Which stops compiling
do_BUG() into an ndef CONFIG_DEBUG_BUGVERBOSE kernel.

But I have an interest in compiling (some) modules once to run with
different configurations of base kernel - and I'd expect the makers
of Linux distributions to have a similar interest.  Just how many
versions of a driver do you need to build for your distribution?

My main concern is to let modules be independent of HIGHMEM config:
to which end I'd like one day (not imminent) to submit a patch in
which even CONFIG_NOHIGHMEM kernel would have stubs for kmap_high()
and kunmap_high(), to allow CONFIG_HIGHMEM modules to be linked in.

Of course there's a limit to how far such a programme should go,
but I don't think we should add CONFIG obstacles so cheaply avoided.
I'd prefer a module built with CONFIG_DEBUG_BUGVERBOSE to link into
a kernel built without CONFIG_DEBUG_BUGVERBOSE i.e. source as in -ac14,
but the #ifdef CONFIG_DEBUG_BUGVERBOSE moved down one line in page.h.

Am I a heretic?

Hugh

