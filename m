Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVLKVaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVLKVaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVLKVaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:30:15 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:28031 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVLKVaN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:30:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O3COj3U8BtXFAaKiXbTE4NUguSIIYEhrMZc91KgRM3bPMuVKvj12F3kwJYRqSKcxqKO7ZPC8K+9Jpap7D8RDnYzB+Xf6pK0vFh0ZBF0PA9AOStLFmQYFuavuui4hR3+MHxvTYhT6uL3Rb89apko2l11fWCJ7HN1axoCo+JlZ9OE=
Message-ID: <9a8748490512111330l6097b39cp2c51dbbd059e923f@mail.gmail.com>
Date: Sun, 11 Dec 2005 22:30:12 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Fix vesafb display panning regression
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <439C965C.5030100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051211041308.7bb19454.akpm@osdl.org>
	 <9a8748490512110808q2d485407o52da0d4777fbf38e@mail.gmail.com>
	 <439C965C.5030100@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Fix vesafb hang when scroll mode is REDRAW.
>
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
>
> Jesper Juhl wrote:
> > On 12/11/05, Andrew Morton <akpm@osdl.org> wrote:
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm2/
> >>
> > When booting this kernel with  vga=791 like I normally do, the kernel
> > hangs on boot. Booting with vga=normal works just fine.
> > I don't have very much info since as soon as the videomode is switched
> > I get a small rectangle of messed up colours in the top left corner of
> > the screen (the rest is just black) and then it hangs - even the
> > keyboard is dead, I have to powercycle the machine.
> > Nothing makes it to the logs and I don't have a second machine atm to
> > get logs via serial console or netconsole.
> > I've got the vesafb driver build in, none of the other fb drivers.
> >
>
> Sorry about that.

No problem, it happens :)


>  This particular hunk was missing in the
> vesafb_trim_pan_display.patch
>

I just rebuild 2.6.15-rc5-mm2 with that patch applied and I can
confirm that it fixes the problem.
So, I guess I should add

Acked-by: Jesper Juhl <jesper.juhl@gmail.com>

Andrew, could you please merge that patch from Antonio?



One small detail; With 2.6.15-rc5-mm2 I see a small (rather
insignificant) difference in behaviour compared to 2.6.15-rc5-git1
just at the time when the video mode is switched at boot.
With 2.6.15-rc5-git1 it goes straight from the text mode display to
the graphical one with the boot logo in the top left corner. With
2.6.15-rc5-mm2 + your patch I get a brief, split second, image with
random green/grey/white pixels in the location where the penguin
appears a few ms later - then everything is normal.
No big deal and it doesn't bother me, just thought it might be
something you'd want to know about...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
