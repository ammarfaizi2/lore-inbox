Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSJIRAV>; Wed, 9 Oct 2002 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSJIRAU>; Wed, 9 Oct 2002 13:00:20 -0400
Received: from findaloan-online.cc ([216.209.85.42]:43525 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261849AbSJIRAU>;
	Wed, 9 Oct 2002 13:00:20 -0400
Date: Wed, 9 Oct 2002 13:05:17 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Robert Love <rml@tech9.net>, riel@conectiva.com.br, akpm@digeo.com,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021009170517.GA5608@mark.mielke.cc>
References: <1034104637.29468.1483.camel@phantasy> <XFMail.20021009103325.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20021009103325.pochini@shiny.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 10:33:25AM +0200, Giuliano Pochini wrote:
> > The point of O_STREAMING is one change: drop pages in the pagecache
> > behind our current position, that are free-able, because we know we will
> > never want them.
> Does it drop pages unconditionally ?  What happens if I do a
> streaming_cat largedatabase > /dev/null while other processes
> are working on it ?  It's not a good thing to remove the whole
> cached data other apps are working on.

Anybody could make the cache thrash. I don't see this as an argument against
O_STREAMING (whether explicitly activated, or dynamically activated).

The only extension I would suggest (I don't think the patch did this?) 
is that pages should only be candidates for being forgotten if all
open files associated with the page are O_STREAMING and all seek
points for all open files are beyond the page.

This would allow for a web app, or similar, that was serving the same
document over two different sockets, to provide a compromise between
O_STREAMING and not O_STREAMING where performance would suffer, but
for the common case, where only one person is accessing the file, the
full benefit of O_STREAMING would be realized.

Does the patch allow for mmap() to benefit from O_STREAMING?
"I intend to access this virtual memory range sequentially..."

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

