Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRCPIoU>; Fri, 16 Mar 2001 03:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129321AbRCPIoL>; Fri, 16 Mar 2001 03:44:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34319 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129126AbRCPIn4>; Fri, 16 Mar 2001 03:43:56 -0500
Date: Fri, 16 Mar 2001 03:58:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reserved memory for highmem bouncing (fwd)
In-Reply-To: <Pine.LNX.4.30.0103160917420.807-100000@elte.hu>
Message-ID: <Pine.LNX.4.21.0103160358230.4571-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok.

Going to write a patch and send you to test RSN.

On Fri, 16 Mar 2001, Ingo Molnar wrote:

> 
> On Thu, 15 Mar 2001, Marcelo Tosatti wrote:
> 
> > The old create_bounce code used to set PF_MEMALLOC on the task flags
> > and call wakeup_bdflush(1) in case GFP_BUFFER page allocation failed.
> > That was broken because flush_dirty_buffers() could try to flush a
> > buffer pointing to highmem page, which would end up in create_bounce
> > again, but with PF_MEMALLOC.
> >
> > Have you tried to make flush_dirty_buffers() only flush buffers
> > pointing to lowmem pages in case the caller wants it to do so?
> 
> this makes sense too - although an emergency pool of some sort never
> hurts, given that highmem buffers cannot be written out without allocating
> bounce buffers. (this makes them more volatile wrt. resource shortages
> than lowmem buffers.) Also, there is no guarantee that flushing lowmem
> buffers yields any free pages.
> 
> > This way you can call flush_dirty_buffers() with the guarantee you're
> > going to free useful (lowmem) memory. This also throttles high mem
> > writes giving priority to low mem ones.
> 
> yep, i think we should do this in addition to the emergency pool thing, it
> should improve balance.
> 
> 	Ingo
> 

