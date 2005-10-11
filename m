Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVJKPTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVJKPTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 11:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVJKPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 11:19:22 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:11902 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751279AbVJKPTV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 11:19:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iBeib6j49VFw6sN2u32LRjxj4vwYTiEtesaKCPXGZHdE0mXPNeIaN5os/jtrfF//A8O+xu7uPrndyXUdtKjV4LSX79iVSxqp7GZSaDV2E4PtYjrzUNymGUrb5UCE1SOix0ZoyRw4Ige7z6uFKHTgIqY+wTqe/FaDo0Nf3M3WrH0=
Message-ID: <35fb2e590510110819v8d1febfo74f0fe5bd89ef8c4@mail.gmail.com>
Date: Tue, 11 Oct 2005 16:19:21 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Junichi Uekawa <dancer@netfort.gr.jp>
Subject: Re: Bug#322309: Debian woody dpkg no longer works with recent linux kernel.
Cc: Scott James Remnant <scott@netsplit.com>, 322309@bugs.debian.org,
       329468@bugs.debian.org, debian-devel@bugs.debian.org,
       linux-kernel@vger.kernel.org, 332903@bugs.debian.org
In-Reply-To: <87achg9lnl.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87zmpi3ell.dancerj%dancer@netfort.gr.jp>
	 <1128897196.19000.3.camel@localhost.localdomain>
	 <87achg9lnl.dancerj%dancer@netfort.gr.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/05, Junichi Uekawa <dancer@netfort.gr.jp> wrote:

> > > dpkg in Debian woody (3.0) is broken by recent linux kernels;
> > > due to the following command changing behavior (mmap of
> > > zero-byte length):
> > >
> > >   addr=mmap(NULL, 0, PROT_READ, MAP_SHARED, fd, 0);
> > >
> > > These bugs are caused by mmap changing behavior;
> > > it used to return NULL when given a length of 0.
> > > However, it now returns -1, and gives back an errno=EINVAL.

> I'm seeing several potential solutions.

> Backport dpkg change to woody and update woody
> (maybe impossible due to Debian oldstable
> update infrastructure)

That's probably the best fix.

> write a kernel patch to return 0 when mmap is
> called with length=0

Bad idea. I'm not the greatest authority on what the standards say
mmap should be doing, but this change seems logical and there's no
point in changing the kernel to revert the behaviour just for Debian
systems. It'd be another pointless Debian kernel patch :-)

> Create a LD_PRELOAD or ptrace hack to return
> 0 when mmap is called with length=0

Yummy. Better than the previous hack.

Jon.
