Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZKmr>; Fri, 26 Jan 2001 05:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRAZKm1>; Fri, 26 Jan 2001 05:42:27 -0500
Received: from zeus.kernel.org ([209.10.41.242]:29395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129143AbRAZKmQ>;
	Fri, 26 Jan 2001 05:42:16 -0500
Date: Fri, 26 Jan 2001 10:39:31 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Roman Zippel <roman@augan.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
Message-ID: <20010126103931.C11607@redhat.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> <20010123165117Z131182-221+34@kanga.kvack.org> <20010125155345Z131181-221+38@kanga.kvack.org> <3A705802.5C4DD2F2@augan.com> <20010125164707Z131181-222+39@kanga.kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010125164707Z131181-222+39@kanga.kvack.org>; from ttabi@interactivesi.com on Thu, Jan 25, 2001 at 10:49:50AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 25, 2001 at 10:49:50AM -0600, Timur Tabi wrote:
> 
> > set_bit(PG_reserved, &page->flags);
> > 	ioremap();
> > 	...
> > 	iounmap();
> > 	clear_bit(PG_reserved, &page->flags);
> 
> The problem with this is that between the ioremap and iounmap, the page is
> reserved.  What happens if that page belongs to some disk buffer or user
> process, and some other process tries to free it.  Won't that cause a problem?

It depends on how it is being used, but yes, it is likely to --- page
reference counts won't be updated properly on reserved pages, for
example.  Why on earth do you want to do ioremap of something like a
page cache page, though?  That is _not_ what ioremap is designed for!

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
