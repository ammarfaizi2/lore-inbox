Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRF0Uh2>; Wed, 27 Jun 2001 16:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265242AbRF0UhS>; Wed, 27 Jun 2001 16:37:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40466 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262568AbRF0UhD>; Wed, 27 Jun 2001 16:37:03 -0400
Date: Wed, 27 Jun 2001 17:36:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
In-Reply-To: <933130000.993673450@tiny>
Message-ID: <Pine.LNX.4.33L.0106271733280.23373-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Chris Mason wrote:
> On Wednesday, June 27, 2001 04:43:28 PM -0300 Rik van Riel

> > If you don't have free memory, you are limited to 2 choices:
> >
> > 1) wait on IO
> > 2) spin endlessly, wasting CPU until the IO is done
>
> Ok, I need to describe the problem a little better.  reiserfs
> inodes need to be logged, which means you have to join/start a
> transaction in order to write them.

> So, the only time reiserfs_write_inode needs to do something is for fsync
> and/or O_SYNC writes, and all it needs to do is commit the transaction.
>
> Any time kswapd is calling write_inode, it is just trying to
> free the inode struct, and reiserfs can safely ignore the write
> request, regardless of if a sync is requested.

OK, sounds sane enough to me ;)

So the fix is just to let reiserfs_write_inode always be
asynchronous, independent of its arguments, as long as
we're not in fsync() or O_SYNC.

OTOH, if we are called synchronously, we could also just
walk down the code path taken when we _are_ called by
fsync(), right ?

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

