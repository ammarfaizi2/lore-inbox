Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277237AbRJQVaj>; Wed, 17 Oct 2001 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277242AbRJQVa3>; Wed, 17 Oct 2001 17:30:29 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:18802 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277237AbRJQVaQ>; Wed, 17 Oct 2001 17:30:16 -0400
Date: Wed, 17 Oct 2001 23:30:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: chris@scary.beasts.org
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Gortmaker <p_gortmaker@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
Message-ID: <20011017233017.G12055@athlon.random>
In-Reply-To: <20011017222108.C12055@athlon.random> <Pine.LNX.4.33.0110172220230.2072-100000@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110172220230.2072-100000@sphinx.mythic-beasts.com>; from chris@scary.beasts.org on Wed, Oct 17, 2001 at 10:23:37PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 10:23:37PM +0100, chris@scary.beasts.org wrote:
> 
> On Wed, 17 Oct 2001, Andrea Arcangeli wrote:
> 
> > I think with directory readahead Marcelo meant a transparent kernel
> > heuristic in the readdir path. ext2_get_page is completly synchronous
> > and it's reading one page at time, that's bad but it can be improved
> > transparently to userspace, just like we do with the files, and also
> > like the old code was doing before the directory in pagecache IIRC.
> 
> Do the -ac kernels have the directory in pagecache patch? If not, it could

yes, -ac has it too.

> explain why the -ac kernel performed _much_ better for the
> creat()/stat()/unlink() tests in bonnie++.

It can't explain that. But there was another optimization in -ac that
avoids restarting searching entries from the start of the directory. That
could make a relevant difference. It is included in mainline too starting
from 2.4.10.

Andrea
