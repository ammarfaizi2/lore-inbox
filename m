Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbRAIOMQ>; Tue, 9 Jan 2001 09:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130769AbRAIOMG>; Tue, 9 Jan 2001 09:12:06 -0500
Received: from zeus.kernel.org ([209.10.41.242]:28622 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130875AbRAIOLv>;
	Tue, 9 Jan 2001 09:11:51 -0500
Date: Tue, 9 Jan 2001 14:09:32 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org, Christoph Rohland <cr@sap.com>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: VM subsystem bug in 2.4.0 ?
Message-ID: <20010109140932.E4284@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com> <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Mon, Jan 08, 2001 at 04:30:10PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 08, 2001 at 04:30:10PM -0200, Rik van Riel wrote:
> On Mon, 8 Jan 2001, Linus Torvalds wrote:
> > 
> > The only solution I see is something like a "active_immobile"
> > list, and add entries to that list whenever "writepage()"
> > returns 1 - instead of just moving them to the active list.
> 
> Just marking them with a special "do not deactivate me"
> bit seems to work fine enough. When this special bit is
> set, we simply move the page to the back of the active
> list instead of deactivating.

But again, how do you clear the bit?  Locking is a per-vma property,
not per-page.  I can mmap a file twice and mlock just one of the
mappings.  If you get a munlock(), how are you to know how many other
locked mappings still exist?

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
