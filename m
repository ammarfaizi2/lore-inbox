Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272848AbRIGUxc>; Fri, 7 Sep 2001 16:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272849AbRIGUxX>; Fri, 7 Sep 2001 16:53:23 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:65042 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272848AbRIGUxD>; Fri, 7 Sep 2001 16:53:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Martin MOKREJ? <mmokrejs@natur.cuni.cz>
Subject: Re: __alloc_pages: 0-order allocation failed.
Date: Fri, 7 Sep 2001 23:00:21 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.21.0109071502390.170-100000@prfdec.natur.cuni.cz> 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907205321Z16323-26184+70@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 7, 2001 10:43 pm, Daniel Phillips wrote:
> On September 7, 2001 03:06 pm, Martin MOKREJ? wrote:
> > On Tue, 4 Sep 2001, Daniel Phillips wrote:
> > 
> > > On September 4, 2001 03:11 pm, Martin MOKREJ? wrote:
> > > > Hi,
> > > >   I'm getting the above error on 2.4.9 kernel with kernel HIGHMEM option
> > > > enabled to 2GB, 2x Intel PentiumIII. The machine has 1GB RAM
> > > > physically. Althougj I've found many report to linux-kernel list during
> > > > past months, not a real solution. Maybe only:
> > > > http://www.alsa-project.org/archive/alsa-devel/msg08629.html
> > > 
> > > Try 2.4.10-pre4.
> > 
> > 
> > Wow, I've just now realized that I get two types of error message:
> > __alloc_pages: 0-order allocatiocation failed (gfp=0x70/1).
> > __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> > 
> > We are using LVM and ReiserFS, HIGMEM kernel.
> > 
> > Maybe it helps to track it down. Any ideas?
> 
> printk has a limited amount of space for buffering messages, a ring buffer 
> (sort of) and will start dropping text when the buffer fills up, so as not
> to slow the kernel down and/or interfere with interrupts.  So that is why
> two lines of output got combined above, they are all the same message.
> 
> The gfp=0x70/1 identifies the failure as GFP_NOIO, PF_MEMALLOC, which by
> process of eliminate, comes from alloc_bounce_page.  Marcelo's patch for
> bounce buffer allocation is *not* in 2.4.10-pre4, so we haven't proved
> anything yet.
> 
> You can get the patch from Marcelo's post on lkml on Aug 22 under the
> subject "Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on
> 7899P)".  Note the correction posted in his next message in the thread.
> It applies to 2.4.9.  Please try it and see if these failures go away.
> 
> This patch *should* be in the main tree soon.  Some testing by you would
> help a lot.

Correction, it's in Linus's tree all write, with some changed names.  So...
conclusion: Marcelo's approach is not airtight.  Or there was an error in
translation.  Arjan has a patch going in soon to the -ac tree, so stay
tuned.
