Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292549AbSBTWdB>; Wed, 20 Feb 2002 17:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292547AbSBTWcw>; Wed, 20 Feb 2002 17:32:52 -0500
Received: from traven.uol.com.br ([200.231.206.184]:26252 "EHLO
	traven.uol.com.br") by vger.kernel.org with ESMTP
	id <S292549AbSBTWcj>; Wed, 20 Feb 2002 17:32:39 -0500
Date: Wed, 20 Feb 2002 19:31:33 -0300 (BRT)
From: Cesar Suga <sartre@linuxbr.com>
To: Thomas Winischhofer <tw@webit.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sis_malloc / sis_free
In-Reply-To: <3C740BD5.B1227ABF@webit.com>
Message-ID: <Pine.LNX.4.40.0202201916001.3145-100000@sartre.linuxbr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Thomas Winischhofer wrote:

> >         (hm, you still lose CPU time when deallocating memory when
> > switching back to console (fb) and switching to X, it they are not really
> > shared, as with copy_from_user() and copy_to_user()...)

> AFAIK Alloc/Dealloc is not done when switching back and forth to/from
> VT. Why do you assume this? (Remember: We are talking about video RAM
> here)

# From sis_drm.h:
typedef struct {
  int context;
  unsigned int offset;
  unsigned int size;
  unsigned int free;
} drm_sis_mem_t;

	Ahm, sorry. eh. Well, as I said. I'm not too familiarized and I
thought the source disposition is not too obvious for me to understand.
(no, I am no C expert, so..)

> >         Yes, with those DRAM detection routines.
> And these are HUGE (check init.c - half that file deals with that)

	Hm, they actually convinced me that, for me, the better way to get
those things working with ease of expansion is how you stated (and I
asked, for the 'code split'), the module for video memory management.

> >         With the sisfb_poh_allocate() (which I by found itself the
> > complicated part), the display struct, the *huge* heap initializer which
> > depends on all the rest, eheh, the duplication would cost too much.

> Exactly :)

> >         Ahn, then you are speaking of moving SIS common heap functions,
> > command queue determination, queue area size and whatsoever common outside
> > to a common area? This is really a good approach. :)

> I am actually thinking of this - but

> 1) I haven't developed a new concept yet (which has to satisfy
> framebuffer, DRM and X), and

> 2) it's not on the top of my list. There are by far more important
> things to be done first (see below).

	I think a video memory management module would be *very*
important for new modules both for FB and DRM. So the modules would care
about the command queues, setting modes, etc. - nothing related to video
memory.

> >         In this current way, yes. But one can compile, let's say, the SIS
> > FB support as a module and the SIS DRM support as a builtin, which would
> > break the driver.

> I'd never compile the DRM "module" into the kernel - what for...? (But
> you're right, of course. That combination will cause trouble.)

	One should be, at least, adviced in the Configure.help whilst
configuring his/her kernel.

> >         Well, now that I've got into the code, neither I do. :)

> :)))

> >         Any idea on when you'll split allocation codes from the FB code?
> > (Or will you work on doing just one common module that'll give support for
> > both FB and DRM?)

> I figure leaving these routines inside the fb code is the best choice
> for now. I don't see any harm with that at the moment. (Apart from the
> compilation combination you mentioned, of course.)

> Or does anybody want a third module for just doing video memory
> management...? Yes? You, there in the second row? Please stand up.... :)

	Yes, eh. Hope someone can help (I do not know yet how to manage
that).

> I will, however, deal closer with that issue as soon as I got the X
> driver somewhat fixed - and this might take a few weeks (communication
> with SiS is kinda, let's say, time-taking and they aren't really
> generous with information on their devices). And aside from this - I got
> my attorney's exam on March 6 which will keep me from spending as much
> time as I'd like on SiS drivers until then... :(

	Hm. And I'll only be able to contribute in, say, documentation.

> What has the X driver to do with this, you ask? Well: The X driver now
> (after a hard struggle :) ) relates to sisfb by using the exact same
> code basis for the core functions. For assumingly understood
> maintainance reasons, I want to make the core functions re-usable for
> both of the drivers. This is partly finished but not complete yet. (If
> you want to test the latest drivers [both sisfb and X] and some more
> information on SiS VGA devices see
> http://www.webit.com/tw/linuxsis630.shtml)

> Another - rather important - issue is that SiS very soon releases a new
> chip (SiS 650) and a new video bridge (302B/301LV/302LV) and support for
> these should also be included in BOTH drivers. I am currently working on
> this.

	Hope you code that support with the possibility of splitting
functions between modules ;)

> For now, I believe patching the config dependencies is the best thing to
> do. I'd also patch the documentation so that folks don't compile DRM
> into the kernel (which is a waste of resources, IMHO)

	Yes, at least for now.

	Regards,
	Cesar Suga <sartre@linuxbr.com>


