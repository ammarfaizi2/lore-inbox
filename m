Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131326AbRAEUaF>; Fri, 5 Jan 2001 15:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131306AbRAEU3z>; Fri, 5 Jan 2001 15:29:55 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:55536 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131176AbRAEU3m>; Fri, 5 Jan 2001 15:29:42 -0500
Date: Fri, 5 Jan 2001 18:29:29 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0101051630150.2882-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051827440.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Marcelo Tosatti wrote:
> On Fri, 5 Jan 2001, Chris Mason wrote:
> > On Friday, January 05, 2001 01:43:07 PM -0200 Marcelo Tosatti
> > <marcelo@conectiva.com.br> wrote:
> > > On Fri, 5 Jan 2001, Chris Mason wrote:
> > > 
> > >> 
> > >> Here's the latest version of the patch, against 2.4.0.  The
> > >> biggest open issues are what to do with bdflush, since
> > >> page_launder could do everything bdflush does.  
> > > 
> > > I think we want to remove flush_dirty_buffers() from bdflush. 
> > > 
> > 
> > Whoops.  If bdflush doesn't balance the dirty list, who does?
> 
> Who marks buffers dirty. 
> 
> Linus changed mark_buffer_dirty() to use flush_dirty_buffers() in case
> there are too many dirty buffers.
> 
> Also, I think in practice page_launder will help on balancing. 

Chris is right. It is possible (not very likely, but possible
notheless) that the majority of the dirty pages are _active_
pages ... in that case page_launder() won't help one bit and
only flush_dirty_buffers() can do the job.

Also, you do not want the writer to block on writing out buffers
if bdflush could write them out asynchronously while the dirty
buffer producer can work on in the background.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
