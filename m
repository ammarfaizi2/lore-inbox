Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbTH1Isl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 04:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTH1IsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 04:48:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:42405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263859AbTH1ISz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 04:18:55 -0400
Date: Thu, 28 Aug 2003 01:21:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030828012152.1294f183.akpm@osdl.org>
In-Reply-To: <20030828080403.DC3272C640@lists.samba.org>
References: <20030826232039.626f5a4c.akpm@osdl.org>
	<20030828080403.DC3272C640@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> > I think a better place to rehash the futex would be at the point where the
>  > page is added to and removed from swapcache.
> 
>  This is simplest: the current code actually moves the futex queue out
>  of the hash.  If we make the rule: "call futex_rehash" every time
>  page->mapping (or page->index) changes, we avoid races and make the
>  code simpler.
> 
>  But this means it could be called quite often.

Moving pages to and from swapcache really is not a fastpath at all,
so I wouldn't be worrying about that.

And even if the code is sucky, it will only be sucky when there is a lot of
swapcache activity AND a lot of futexes are in use.



