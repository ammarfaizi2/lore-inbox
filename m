Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758347AbWK0QCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758347AbWK0QCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758349AbWK0QCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:02:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1758347AbWK0QCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:02:22 -0500
Date: Mon, 27 Nov 2006 16:01:21 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611230653x2951d9d8x41b193f0101f9fdf@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611271558550.11317@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
 <cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
 <Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org> 
 <cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com> 
 <Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org> 
 <cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com> 
 <Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org> 
 <cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com> 
 <Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
 <cda58cb80611230653x2951d9d8x41b193f0101f9fdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Replace the below line in my patch I sent
> > 
> > > >                     val |= color << shift;
> > 
> > with
> >                         val <<= shift;
> >                         val |= color;
> 
> I think it can't work since shift is 0 to 31, you'll end up with 'val
> <<= 31' which I don't think is what you want.
 
> doing
>                         val <<= 1;
> 
> make it works but it's still very fragile. Code which deals with
> trailing bit seems bogus since new value of 'val' is simply discarded
> here.

I'm going to test the code in depth over the next few days. I managed to 
fix most of the problems with fast_imageblit. Now to fix the slow image 
blit code.

> I'm wondering if working with 32 bits words really worth... I mean the
> code is quite hard to follow because it needs to deal with endianess,
> heading bits, trailings bits whereas working with 8 bits would be so
> much easier, wouldn't it ? Are writings in video RAM very long ?

Yes. We need to minimize the writes over the PCI bus. Its really really 
slow.
