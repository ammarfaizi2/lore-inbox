Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVIXRra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVIXRra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVIXRra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:47:30 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:23770 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932210AbVIXRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:47:29 -0400
Date: Sat, 24 Sep 2005 10:47:28 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unify sys_tkill() and sys_tgkill()
In-Reply-To: <9a8748490509240752436ef7b2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0509241046170.20181@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0509231913550.5348@shell3.speakeasy.net>
 <9a8748490509240752436ef7b2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Jesper Juhl wrote:

> On 9/24/05, Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> > Hi,
> >
> > The majority of the sys_tkill() and sys_tgkill() function code is
> > duplicated between the two of them. This patch pulls the duplication out
> > into a separate function -- do_tkill() -- and lets sys_tkill() and
> > sys_tgkill() be simple wrappers around it. This should make it easier to
> > maintain in light of future changes.
> >
>
> A few nitpicks ... :
>
> [snip]
> > +static int do_tkill(int tgid, int pid, int sig)
>
> I would probably have made this
>
>   static inline int do_tkill(int tgid, int pid, int sig)

Probably not necessary to inline this, as per the previous comments.

> [snip]
> > +       if (p && ((tgid <= 0) || (p->tgid == tgid))) {
>
> Why all the extra parenthesis?
>
>    if (p && (tgid <= 0 || p->tgid == tgid)) {
>
>
> [snip]
> > +       return (do_tkill(tgid, pid, sig));
>
> return is not a function
>
>    return do_tkill(tgid, pid, sig);
>
> [snip]
> > +       return (do_tkill(0, pid, sig));
>
> again, get rid of the pointless extra parens
>
>    return do_tkill(0, pid, sig);

These are all no biggie. I'll remove the parens and resend.

> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
>

Thanks for the comments.
-Vadim Lobanov
