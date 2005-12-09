Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVLIKg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVLIKg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbVLIKg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:36:28 -0500
Received: from [139.30.44.16] ([139.30.44.16]:50982 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1751307AbVLIKg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:36:28 -0500
Date: Fri, 9 Dec 2005 11:36:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Core Team <coreteam@netfilter.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Decrease number of pointer derefs in nf_conntrack_core.c
In-Reply-To: <9a8748490512090218q72998aebq8c09247921bd167e@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0512091134100.31859@gockel.physik3.uni-rostock.de>
References: <200512082336.19695.jesper.juhl@gmail.com>  <20051209110441.GC20314@elte.hu>
 <9a8748490512090218q72998aebq8c09247921bd167e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Jesper Juhl wrote:

> On 12/9/05, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > > orig:
> > >    text    data     bss     dec     hex filename
> > >   12636      49     760   13445    3485 net/netfilter/nf_conntrack_core.o
> > >
> > > patched:
> > >    text    data     bss     dec     hex filename
> > >   11825     183     632   12640    3160 net/netfilter/nf_conntrack_core.o
> >
> > just a question - are you sure the measurements are accurate in this
> > case? The patch looks too small to shave more than 800 bytes off .text!
> > If it's real then something really wrong is going on in gcc-land ...
> >
> I did all this with an allyesconfig kernel source and then did :
>    make net/netfilter/nf_conntrack_core.o
>    size net/netfilter/nf_conntrack_core.o
>    rm net/netfilter/nf_conntrack_core.o
> then applied the patch and redid
>    make net/netfilter/nf_conntrack_core.o
>    size net/netfilter/nf_conntrack_core.o
> 
> So I believe the numbers should be correct, but I'm not at home atm,
> so I can't verify right now. I won't have a chance to look at it until
> tomorrow, but then I'll double-check.


I get
orig:
   text    data     bss     dec     hex filename
  11745      67     728   12540    30fc net/netfilter/nf_conntrack_core.o

patched:
   text    data     bss     dec     hex filename
  11681      67     728   12476    30bc net/netfilter/nf_conntrack_core.o

> gcc --version
gcc (GCC) 4.0.2 20050901 (prerelease) (SUSE Linux)

Tim
