Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316770AbSEaUfB>; Fri, 31 May 2002 16:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316774AbSEaUfA>; Fri, 31 May 2002 16:35:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19568 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316770AbSEaUe7>; Fri, 31 May 2002 16:34:59 -0400
Date: Fri, 31 May 2002 22:34:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020531203454.GQ1172@dualathlon.random>
In-Reply-To: <20020515212733.GA1025@dualathlon.random> <20020516202626.A13795@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 08:26:26PM +0100, Christoph Hellwig wrote:
> On Wed, May 15, 2002 at 11:27:33PM +0200, Andrea Arcangeli wrote:
> > o	minor bdflush tuning difference to avoid char-writer in bonnie
> > 	to stall and to slowdown too much (can make a difference in real
> > 	life)
> 
> ...
> 
> > Only in 2.4.19pre8aa3: 00_bdflush-tuning-1
> > 
> > 	Put the mid watermark at 50% (near the high watermark so we don't stall
> > 	too much).
> 
> As the 2.4.19-pre mainline got your buffer throtteling changes I guess it
> has the same issues?  Do you think it's worth to submit that patch to Marcelo
> even that late in the release cycle?

it is not very important, but of course it could go in too.

> 
> > Only in 2.4.19pre8aa2: 05_vm_10_read_write_tweaks-1
> > Only in 2.4.19pre8aa3: 05_vm_10_read_write_tweaks-2
> > 
> > 	Avoid backing out the flush_page_to_ram in this vm patch,
> > 	the one on the pagecache is still needed before the memcpy
> > 	on the pagecache during the early cow (would be cleaner
> > 	to move it up, if Hugh wants to clean it up that's welcome,
> > 	it will be an orthogonal patch, so far I just avoid to
> > 	change that area in my changes, not high prio to clean it up
> > 	as DaveM side it's more high prio to conver the users of
> > 	flush_page_to_ram API to flush_dcache_page/icache new API during 2.5).
> 
> It seems to me you ignore the comments akpm put in the split patches you
> merged :)  Not only the comment to this change is superflous now, but also

updated :)

> I'd really like to get an answer to the remaining part of it as Andrew's
> comment about that part beeing buggy makes a lot of sense to me..

well, as Andrew said it's a microoptimization, but it's not buggy. It is
used to avoid marking a page referenced twice if somebody reads with an
userspace buffer granularity smaller than PAGE_SIZE, the same
optimization exists in the read side (there it is a bit more of a
microoptimization because the writer never activates pages but the
readers activates pages without such check).

Andrea
