Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293737AbSCETPH>; Tue, 5 Mar 2002 14:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293734AbSCETO5>; Tue, 5 Mar 2002 14:14:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21000 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293736AbSCETOn>;
	Tue, 5 Mar 2002 14:14:43 -0500
Message-ID: <3C8518AE.B44AF2D5@zip.com.au>
Date: Tue, 05 Mar 2002 11:12:46 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@fenrus.demon.nl>
CC: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>,
		<20020305192604.J20606@dualathlon.random>; from andrea@suse.de on Tue, Mar 05, 2002 at 07:26:04PM +0100 <20020305183053.A27064@fenrus.demon.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Tue, Mar 05, 2002 at 07:26:04PM +0100, Andrea Arcangeli wrote:
> 
> > Another approch would be to add the pages backing the bh into the lru
> > too, but then we'd need to mess with the slab and new bitflags, new
> > methods and so I don't think it's the best solution. The only good
> > reason for putting new kind of entries in the lru would be to age them
> > too the same way as the other pages, but we don't need that with the bh
> > (they're just in, and we mostly care only about the page age, not the bh
> > age).
> 
> For 2.5 I kind of like this idea. There is one issue though: to make
> this work really well we'd probably need a ->prepareforfreepage()
> or similar page op (which for page cache pages can be equal to writepage()
> ) which the vm can use to prepare this page for freeing.

If we stop using buffer_heads for pagecache I/O, we don't have this problem.

I'm showing a 20% reduction in CPU load for large reads.  Which is a *lot*,
given that read load is dominated by copy_to_user.

2.5 is significantly less efficient than 2.4 at this time.  Some of that 
seems to be due to worsened I-cache footprint, and a lot of it is due
to the way buffer_heads now have a BIO wrapper layer.

Take a look at submit_bh().   The writing is on the wall, guys.

-
