Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUIJGi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUIJGi2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUIJGi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:38:28 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:937 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268399AbUIJGiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:38:11 -0400
Date: Fri, 10 Sep 2004 07:37:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
cc: Andrew Morton <akpm@osdl.org>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>
Subject: Re: PATCH] atomic_inc_return() [0/5] (Re: atomic_inc_return)
In-Reply-To: <01be01c496eb$6a9dbd60$f97d220a@linux.bs1.fc.nec.co.jp>
Message-ID: <Pine.LNX.4.44.0409100721470.15219-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Kaigai Kohei wrote:
> > 
> > I believe you have a patch adding those to i386 (including CONFIG_M386
> > runtime check lest it's an actual i386 which cannot do "xadd") and x86_64.
> > I'd be glad to see that go into the tree, would you be ready to submit it
> > to Andrew or Linus based on the current 2.6 BK tree?
> 
> Indeed, I hope to do this.
> atomic_inc_return() is necessary for the 'SELinux performance improvement
> by RCU' patch.

Thanks a lot, the patches 1-5 you've posted look good to me (aside from
some spaces instead of tab in the asm-arm 3/5), and should save me from
my silly race.

If we'd had these earlier, we could have avoiding changing page->count
and page->mapcount over to start from -1 (though I dare say they may
be slightly more efficient as they now are, than if we converted them
back).  Should save making such conversions in future, anyway.

> > I think arm was missing the inc and dec, but has recently gained them.

I was wrong when I said that: asm-arm/atomic.h has recently been reworked,
but does still needs your additions: sorry for the confusion.

Thanks,
Hugh

