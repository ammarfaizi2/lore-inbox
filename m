Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135207AbRAZKkR>; Fri, 26 Jan 2001 05:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135222AbRAZKkH>; Fri, 26 Jan 2001 05:40:07 -0500
Received: from zeus.kernel.org ([209.10.41.242]:467 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135207AbRAZKj6>;
	Fri, 26 Jan 2001 05:39:58 -0500
Date: Fri, 26 Jan 2001 10:37:14 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
Message-ID: <20010126103714.B11607@redhat.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> <20010123165117Z131182-221+34@kanga.kvack.org> <20010125151655.V11607@redhat.com> <200101251556.f0PFuPd01743@mail.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101251556.f0PFuPd01743@mail.redhat.com>; from ttabi@interactivesi.com on Thu, Jan 25, 2001 at 09:56:32AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 25, 2001 at 09:56:32AM -0600, Timur Tabi wrote:
> > ioremap*() is only supposed to be used on IO regions or reserved
> > pages.  If you haven't marked the pages as reserved, then iounmap will
> > do the wrong thing, so it's up to you to reserve the pages.
> 
> Au contraire!
> 
> I mark the page as reserved when I ioremap() it.  However, if I leave it marked
> reserved, then iounmap() will not unmap it.  

It certainly should do, and the 2.4 source certainly looks as if it
does.  At least on i386, iounmap calls vfree, which ends up in
free_area_pte(), which will unconditionally clear the pte (hence
unmapping the page).

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
