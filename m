Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289927AbSAWRk7>; Wed, 23 Jan 2002 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289930AbSAWRkj>; Wed, 23 Jan 2002 12:40:39 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:33804 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S289927AbSAWRk3>; Wed, 23 Jan 2002 12:40:29 -0500
Date: Wed, 23 Jan 2002 18:40:02 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020123184002.A3858@dpt-info.u-strasbg.fr>
In-Reply-To: <20020123183102.A3780@dpt-info.u-strasbg.fr> <Pine.GSO.4.21.0201231832560.26747-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0201231832560.26747-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Jan 23, 2002 at 06:34:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 06:34:03PM +0100, Geert Uytterhoeven wrote:
> On Wed, 23 Jan 2002, Sven wrote:
> > On Mon, Jan 21, 2002 at 09:03:25AM -0800, James Simmons wrote:
> > > 
> > > > BTW, romain, i have built pm3fb with 2.5.2, there were some modifications
> > > > needed, the major of them was the testing for 2.2 or 2.4 kernels that needed
> > > > changing, and the new info.node, which needed to be changed to
> > > > info.node.values.
> > > 
> > > The correct fix is to do something like fb_info.node = NODEV;
> > 
> > And not B_FREE ?
> > 
> > I am unsure about this, but i notice that in the 2.4.17 kernel + pm3fb, the
> > value assigned to .node was -1, which correspond to B_FREE and not NODEV
> > (which is 0).
> > 
> > That said, since it is almost never used, it would maybe be best to move it
> > out of the fbdevs and into some of the more generic layers.
> > 
> > Also, since when does the B_FREE or NODEV exists ? I did put the changes into
> > a #ifdef kernel 2.5, and kept the -1 for kernels 2.4, but i guess i could
> > remove this check altogether if the NODEV was present from the begining. And
> 
> IIRC, Marcelo added NODEV to 2.4.x in one of his latest releases, just to solve
> this problem.
> 
> > what about 2.2 kernels ?
> 
> No idea. Ask Alan :-)

Ok, so the best thing would be to keep the #ifdef then.

or maybe i could try an :

#ifdef NODEV
	..node = NODEV
#else
	..node = -1
#endif

?

Friendly,

Sven Luther
