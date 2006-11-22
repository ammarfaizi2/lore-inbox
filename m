Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757009AbWKVVE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009AbWKVVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 16:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757005AbWKVVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 16:04:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:9630 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756663AbWKVVE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 16:04:58 -0500
Date: Wed, 22 Nov 2006 21:04:50 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org> 
 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com> 
 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org> 
 <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com> 
 <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org> 
 <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com> 
 <Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org>
 <cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> James Simmons wrote:
> > Lets look at the new code that I have done with your above parameters.
> >
> >        for (i = image->height; i--; ) {
> >                shift = val = 0;
> >                n = image->width;
> >                dst = (u32 __iomem *) dst1;
> >
> > 		while (n--) {
> > 			if (!s) { src++; s = 32; }
> > 			s -= 1;
> > 			color = (swapb32p(src) & (1 << s)) ? 1 : 0;

Replace the below line in my patch I sent 

> > 			val |= color << shift;

with
			val <<= shift;
			val |= color;

> > 		       /* Did the bitshift spill bits to the next long? */
> >                        if (shift >= 31) {
> >                                FB_WRITEL(val, dst++);
> >                                val = (shift == 31) ? 0 :(color >> (32 - shift));
> >                        }
> >                        shift += 1;
> >                        shift &= (32 - 1);
> >                }
> >
> >                [ ...]

Let me know if that works.

