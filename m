Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292510AbSBTVE1>; Wed, 20 Feb 2002 16:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292508AbSBTVEI>; Wed, 20 Feb 2002 16:04:08 -0500
Received: from [62.47.19.142] ([62.47.19.142]:9089 "HELO twinny.dyndns.org")
	by vger.kernel.org with SMTP id <S292507AbSBTVDu>;
	Wed, 20 Feb 2002 16:03:50 -0500
Message-ID: <3C740BD5.B1227ABF@webit.com>
Date: Wed, 20 Feb 2002 21:49:25 +0100
From: Thomas Winischhofer <tw@webit.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: Jean Paul Sartre <sartre@linuxbr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <Pine.LNX.4.40.0202201556280.2588-100000@sartre.linuxbr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Paul Sartre wrote:
> > This has nothing whatsoever with processor time to do. It's to keep
> > DRM/DRI from overwriting X's screen and off-screen buffers.
> 
>         (hm, you still lose CPU time when deallocating memory when
> switching back to console (fb) and switching to X, it they are not really
> shared, as with copy_from_user() and copy_to_user()...)

AFAIK Alloc/Dealloc is not done when switching back and forth to/from
VT. Why do you assume this? (Remember: We are talking about video RAM
here)

> > It's not done by simply duplicating the sis_malloc/sis_free functions as
> > these also require
> >
> > - detecting the type and size of the memory (of many different SiS
> > chipsets),
> 
>         Yes, with those DRAM detection routines.

And these are HUGE (check init.c - half that file deals with that)

>         With the sisfb_poh_allocate() (which I by found itself the
> complicated part), the display struct, the *huge* heap initializer which
> depends on all the rest, eheh, the duplication would cost too much.

Exactly :)

>         Ahn, then you are speaking of moving SIS common heap functions,
> command queue determination, queue area size and whatsoever common outside
> to a common area? This is really a good approach. :)

I am actually thinking of this - but 

1) I haven't developed a new concept yet (which has to satisfy
framebuffer, DRM and X), and

2) it's not on the top of my list. There are by far more important
things to be done first (see below). 

>         In this current way, yes. But one can compile, let's say, the SIS
> FB support as a module and the SIS DRM support as a builtin, which would
> break the driver.

I'd never compile the DRM "module" into the kernel - what for...? (But
you're right, of course. That combination will cause trouble.)

>         Well, now that I've got into the code, neither I do. :)

:)))

>         Any idea on when you'll split allocation codes from the FB code?
> (Or will you work on doing just one common module that'll give support for
> both FB and DRM?)

I figure leaving these routines inside the fb code is the best choice
for now. I don't see any harm with that at the moment. (Apart from the
compilation combination you mentioned, of course.)

Or does anybody want a third module for just doing video memory
management...? Yes? You, there in the second row? Please stand up.... :)

I will, however, deal closer with that issue as soon as I got the X
driver somewhat fixed - and this might take a few weeks (communication
with SiS is kinda, let's say, time-taking and they aren't really
generous with information on their devices). And aside from this - I got
my attorney's exam on March 6 which will keep me from spending as much
time as I'd like on SiS drivers until then... :(

What has the X driver to do with this, you ask? Well: The X driver now
(after a hard struggle :) ) relates to sisfb by using the exact same
code basis for the core functions. For assumingly understood
maintainance reasons, I want to make the core functions re-usable for
both of the drivers. This is partly finished but not complete yet. (If
you want to test the latest drivers [both sisfb and X] and some more
information on SiS VGA devices see
http://www.webit.com/tw/linuxsis630.shtml)

Another - rather important - issue is that SiS very soon releases a new
chip (SiS 650) and a new video bridge (302B/301LV/302LV) and support for
these should also be included in BOTH drivers. I am currently working on
this. 

For now, I believe patching the config dependencies is the best thing to
do. I'd also patch the documentation so that folks don't compile DRM
into the kernel (which is a waste of resources, IMHO)

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
mailto:tw@webit.com                  *** http://www.webit.com/tw
