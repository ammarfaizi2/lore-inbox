Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSBIOda>; Sat, 9 Feb 2002 09:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSBIOdU>; Sat, 9 Feb 2002 09:33:20 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:57469 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288963AbSBIOdO>; Sat, 9 Feb 2002 09:33:14 -0500
Date: Sat, 9 Feb 2002 09:33:05 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020209093305.A13748@redhat.com>
In-Reply-To: <3C630D5D.CD66795@zip.com.au> <Pine.LNX.4.21.0202081649120.1497-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0202081649120.1497-100000@localhost.localdomain>; from hugh@veritas.com on Fri, Feb 08, 2002 at 05:46:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 05:46:56PM +0000, Hugh Dickins wrote:
> Ben, you probably have an AIO opinion here.  Is there a circumstance
> in which AIO can unpin a user page at interrupt time, after the
> calling task has (exited or) unmapped the page?

If the user unmaps the page, then aio is left holding the last reference 
to the page and will unmap it from irq or bh context (potentially task 
context too).  With networked aio, pages from userspace (anonymous or 
page cache pages) will be released by the network stack from bh context.  
Even now, I'm guess that should be possible with the zero copy flag...

		-ben
