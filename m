Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266262AbRF3UC3>; Sat, 30 Jun 2001 16:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRF3UCU>; Sat, 30 Jun 2001 16:02:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48395 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266262AbRF3UCL>; Sat, 30 Jun 2001 16:02:11 -0400
Date: Sat, 30 Jun 2001 15:29:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Steve Lord <lord@sgi.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock 
In-Reply-To: <200106301807.f5UI7g503277@jen.americas.sgi.com>
Message-ID: <Pine.LNX.4.21.0106301514320.3227-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Jun 2001, Steve Lord wrote:

> 
> > Yes. 2.4.6-pre8 fixes that (not sure if its up already). 
> 
> It is up.
> 
> > 
> > > If the fix is to avoid page_launder in these cases then the number of
> > > occurrences when an alloc_pages fails will go up. 
> > 
> > > I was attempting to come up with a way of making try_to_free_buffers
> > > fail on buffers which are being processed in the generic_make_request
> > > path by marking them, the problem is there is no single place to reset
> > > the state of a buffer so that try_to_free_buffers will wait for it.
> > > Doing it after the end of the loop in generic_make_request is race
> > > prone to say the least.
> > 
> > I really want to fix things like this in 2.5. (ie not avoid the deadlock
> > by completly avoiding physical IO, but avoid the deadlock by avoiding
> > physical IO on the "device" which is doing the allocation)
> > 
> > Could you send me your code ? No problem if it does not work at all :)
> > 
> 
> Well, the basic idea is simple, but I suspect the implementation might
> rapidly become historical in 2.5. Basically I added a new buffer state bit,
> although BH_Req looks like it could be cannibalized, no one appears to check
> for it (is it really dead code?). 

Dunno. Ask Jens :)

> Using a flag to skip buffers in try_to_free_buffers is easy:

I was thinking more about skipping the buffers which are "owned" by the
device which is doing the allocation. 

