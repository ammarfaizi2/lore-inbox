Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265312AbSJRVUP>; Fri, 18 Oct 2002 17:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265314AbSJRVUO>; Fri, 18 Oct 2002 17:20:14 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:32740 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265312AbSJRVUL>; Fri, 18 Oct 2002 17:20:11 -0400
Date: Fri, 18 Oct 2002 14:19:21 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdev changes.
In-Reply-To: <1034813995.563.32.camel@daplas>
Message-ID: <Pine.LNX.4.33.0210181400360.3591-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi James,
>
> Since you seem to be very busy, here's an idea for the framebuffer
> cursor API.

I looked over your patch and even tested it out. Then I thought about it a
long time. The question I had to ask myself is what do we want when we
have fbdev stand alone and fbdev with framebuffer console. Also how to use
a little code as possible (for embedded systems). So the goals are

1) For stand alone fbdev we want the maximum support for a cursor. But
   what if we don't have a hardware cursor. In this case we should leave
   it to userland to handle making it own cursor. The userland app might
   not even want a cursor. So we avoid having extra code in the kernel for
   a software cursor.

2) For fbcon the only thing we need for a cursor is a little rectangle. We
   could still use imageblit but is seems really heavy when you consider
   saving a bitmap of the current text under the cursor. True you have a
   cost at reading the framebuffer when using fillrect but doesn't it cost
   also to save the text bitmap under the cursor as well ? The question is
   which cost more.

