Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129244AbRBAAYx>; Wed, 31 Jan 2001 19:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129365AbRBAAYo>; Wed, 31 Jan 2001 19:24:44 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:13841 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129244AbRBAAY0>;
	Wed, 31 Jan 2001 19:24:26 -0500
Date: Wed, 31 Jan 2001 16:24:24 -0800
From: David Gould <dg@suse.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
Message-ID: <20010131162424.E9053@archimedes.oak.suse.com>
In-Reply-To: <Pine.LNX.4.21.0101310636530.16408-100000@freak.distro.conectiva> <m18znrcxx7.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <m18znrcxx7.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Jan 31, 2001 at 12:40:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 12:40:52PM -0700, Eric W. Biederman wrote:
> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> > On Wed, 31 Jan 2001, Stephen C. Tweedie wrote:
> > > On Wed, Jan 31, 2001 at 01:05:02AM -0200, Marcelo Tosatti wrote:
> > > > 
> > > > However, the pages which are contiguous on swap are not necessarily
> > > > contiguous in the virtual memory area where the fault happened. That means
> > > > the swapin readahead code may read pages which are not related to the
> > > > process which suffered a page fault.
> > > > 
> > > Yes, but reading extra sectors is cheap, and throwing the pages out of
> > > memory again if they turn out not to be needed is also cheap.  The
> > > on-disk swapped pages are likely to have been swapped out at roughly
> > > the same time, which is at least a modest indicator of being of the
> > > same age and likely to have been in use at the same time in the past.
> > 
> > You're throwing away pages from memory to do the readahead. 
> > 
> > This pages might be more useful than the pages which you're reading from
> > swap. 
> 
> Possibly.  However the win (lower latency) from getting swapin
> readahead is probably even bigger.  And you are throwing out the least
> desirable pages in memory.
> 
> > > I'd like to see at lest some basic performance numbers on this,
> > > though.
> > 
> > I'm not sure if limiting the readahead the way my patch does is a better
> > choice, too.
... 
> Unless you can see a big performance win somewhere please don't submit
> this to Linus for inclusion.

Hmmm, arguably reading pages we do not want is a mistake. I should think that
if a big performance win is required to justify a design choice, it should
be especially required to show such a win for doing something that on its
face is wrong.

I am skeptical of the argument that we can win by replacing "the least
desirable" pages with pages were even less desireable and that we have
no recent indication of any need for. It seems possible under heavy swap
to discard quite a portion of the useful pages in favor of junk that just
happenned to have a lucky disk address.

-dg

-- 
David Gould                                                 dg@suse.com
SuSE, Inc.,  580 2cd St. #210,  Oakland, CA 94607          510.628.3380
You left them alone in a room with a penguin?!  Mr Gates, your men are
already dead.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
