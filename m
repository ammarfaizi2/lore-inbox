Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVCTWR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVCTWR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVCTWR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 17:17:57 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:2478 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261301AbVCTWRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 17:17:53 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Jesper Juhl <juhl-lkml@dif.dk>, Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] remove redundant NULL checks before kfree() in drivers/video/
Date: Mon, 21 Mar 2005 06:17:53 +0800
User-Agent: KMail/1.5.4
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net, Alex Kern <alex.kern@gmx.de>,
       Ani Joshi <ajoshi@shell.unixbox.com>,
       "Ben. Herrenschmidt" <benh@kernel.crashing.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Helge Deller <deller@gmx.de>, Philipp Rumpf <prumpf@tux.org>,
       James Simmons <jsimmons@users.sf.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       "Eddie C. Dost" <ecd@skynet.be>, Nicolas Pitre <nico@cam.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost> <200503210453.47487.adaplas@hotpop.com> <Pine.LNX.4.62.0503202255060.2508@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503202255060.2508@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503210617.53272.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 March 2005 06:02, Jesper Juhl wrote:
> On Mon, 21 Mar 2005, Antonino A. Daplas wrote:
> > On Sunday 20 March 2005 06:59, Jesper Juhl wrote:
> > > Checking a pointer for NULL before calling kfree() on it is redundant,
> > > kfree() deals with NULL pointers just fine.
> > > This patch removes such checks from files in drivers/video/
> > >
> > > Since this is a fairly trivial change (and the same change made
> > > everywhere) I've just made a single patch for all the files and CC all
> > > authors/maintainers of those files I could find for comments. If
> > > spliting this into one patch pr file is prefered, then I can easily do
> > > that as well.
> >
> > [snip]
> >
> > > --- linux-2.6.11-mm4-orig/drivers/video/console/bitblit.c	2005-03-16
> > > 15:45:26.000000000 +0100 +++
> > > linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-19
> > > 22:27:39.000000000 +0100 @@ -199,8 +199,7 @@ static void
> > > bit_putcs(struct vc_data *vc
> > >  		count -= cnt;
> > >  	}
> > >
> > > -	if (buf)
> > > -		kfree(buf);
> > > +	kfree(buf);
> > >  }
> >
> > This is performance critical, so I would like the check to remain. A
> > comment may be added in this section.
>
> Ok, I believe Andrew already merged the patch into -mm, if you really want
> that check back then I'll send him a patch to put it back and add a
> comment once he puts out the next -mm.
> But, at the risk of exposing my ignorance, I have to ask if it wouldn't
> actually perform better /without/ the if(buf) bit?  The reason I say that
> is that the generated code shrinks quite a bit when it's removed, and also
> kfree() itself does the same NULL check as the very first thing, so it
> comes down to the bennefit of shorter generated code, one less branch,
> against the overhead of a function call - and how often will 'buf' be
> NULL? if buff is != NULL the majority of the time, then it should be a
> gain to remove the if().

You said it, buf is almost always NULL, except when the driver is in
monochrome mode.  So a kfree is rarely done.

Anyway, if the patch is already in the tree, let's leave it at that.  I would
surmise that the performance loss is negligible.

Tony


