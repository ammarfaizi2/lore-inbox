Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWDNVra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWDNVra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbWDNVra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:47:30 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:27818 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965051AbWDNVra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:47:30 -0400
Date: Fri, 14 Apr 2006 14:47:29 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Poll microoptimizations.
In-Reply-To: <20060414143820.6a04b696.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0604141440180.30907@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0604132115290.29982@shell3.speakeasy.net>
 <20060414123118.0a8fb24c.akpm@osdl.org> <Pine.LNX.4.58.0604141413260.21335@shell2.speakeasy.net>
 <20060414143820.6a04b696.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2006, Andrew Morton wrote:

> Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> >
> > I can put in a comment to explain what the code is doing, or if you
> > think that the bitmasking itself is "yuk", then I can easily transform
> > the code into an explicit "if () {}" block. :)
>
> yes please.
>
> > > Yuk.  Sorry, no.
> >
> > Thank you for the review. The comments above are easy to address. Do you
> > like the main concept behind the patch? Should I correct and resubmit?
>
> I don't really understand it yet.

It's really a bit of (subjective) cleanup, that just incidentally
happens to save us a few extra clock cycles here and there. In the
current code, the "count" and "pt" variables are modified both in the
function where they're declared (do_poll()), AND also indirectly in a
different function (do_pollfd()). The patch moves all handling of these
variables to the function that declares and "owns" them (do_poll()).

> Yes, please resend and feel free to a) add comments in places where we can
> help people to understand the code and b) convert any code which gets
> touched to be coding-style-friendly.  (I usually recommend that we do that
> even if the surrounding code uses different conventions - eventually
> everything will be fixed ;))

I couldn't agree more on this particular point. The only thing that
stops me is that noone can ever agree on the coding style, even if it is
spelled out in the Documentation/ directory (witness the periodic flame
wars on this list). Helps to have a thick skin, and I'm slowly getting
to that point. ;)

I'll correct, comment, and resend the patch when I get a chance.

- Vadim Lobanov
