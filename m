Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVA1N6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVA1N6f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 08:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVA1N6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 08:58:35 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:34528 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261367AbVA1N6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 08:58:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DBHHIKzXKON59OGagDIYDi4PQ++nCSYCtQn80Tb0kuELBYheBJW2e/bI4n+AclQw1sSmEn235FOLOXtLCKlSF7XGEg6Xi3xLDcpSb6TcjQn2GRYAn0qeNx2CKE/788jbsOpbdlmD8E7BmK3xRYOkyGIeQg+tAOwVvQcNDjs5YmA=
Message-ID: <3f250c7105012805585c01a26@mail.gmail.com>
Date: Fri, 28 Jan 2005 09:58:24 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: tglx@linutronix.de, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ville.medeiros@gmail.com
In-Reply-To: <20050127221129.GX8518@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <3f250c71050121132713a145e3@mail.gmail.com>
	 <3f250c7105012113455e986ca8@mail.gmail.com>
	 <20050122033219.GG11112@dualathlon.random>
	 <3f250c7105012513136ae2587e@mail.gmail.com>
	 <1106689179.4538.22.camel@tglx.tec.linutronix.de>
	 <3f250c71050125161175234ef9@mail.gmail.com>
	 <20050126004901.GD7587@dualathlon.random>
	 <3f250c7105012710541d3e7ad1@mail.gmail.com>
	 <20050127221129.GX8518@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Thu, 27 Jan 2005 23:11:29 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> On Thu, Jan 27, 2005 at 02:54:13PM -0400, Mauricio Lin wrote:
> > Hi Andrea,
> >
> > On Wed, 26 Jan 2005 01:49:01 +0100, Andrea Arcangeli <andrea@suse.de> wrote:
> > > On Tue, Jan 25, 2005 at 08:11:19PM -0400, Mauricio Lin wrote:
> > > > Sometimes the first application to be killed is XFree. AFAIK the
> > >
> > > This makes more sense now. You need somebody trapping sigterm in order
> > > to lockup and X sure traps it to recover the text console.
> > >
> > > Can you replace this:
> > >
> > >         if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
> > >                 force_sig(SIGTERM, p);
> > >         } else {
> > >                 force_sig(SIGKILL, p);
> > >         }
> > >
> > > with this?
> > >
> > >         force_sig(SIGKILL, p);
> > >
> > > in mm/oom_kill.c.
> >
> > Nice. Your suggestion made the error goes away.
> >
> > We are still testing in order to compare between your OOM Killer and
> > Original OOM Killer.
> 
> Ok, thanks for the confirmation. So my theory was right.
> 
> Basically we've to make this patch, now that you already edited the
> code, can you diff and send a patch that will be the 6/5 in the serie?

OK. I will send the patch.

> (then after fixing this last very longstanding [now deadlock prone too]
> bug, we can think how to make at a 7/5 that will wait a few seconds
> after sending a sigterm, to fallback into a sigkill, that shouldn't be
> difficult, but the above 6/5 will already make the code correct)
> 
> Note, if you add swap it'll workaround it too since then the memhog will
> be allowed to grow to a larger rss than X. With 128m of ram and no swap,
> X is one of the biggest with xshm involved from some client app
> allocating lots of pictures. I could never notice since I always tested
> it either with swap or on higher mem systems and my test box runs
> with an idle X too which isn't that big ;).

Well, we like to reduce the memory resources, because we also think
about OOM Killer in small devices with few resources.

BR,

Mauricio Lin.
