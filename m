Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318373AbSHELBF>; Mon, 5 Aug 2002 07:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSHELBF>; Mon, 5 Aug 2002 07:01:05 -0400
Received: from angband.namesys.com ([212.16.7.85]:9426 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318373AbSHELBE>; Mon, 5 Aug 2002 07:01:04 -0400
Date: Mon, 5 Aug 2002 15:04:36 +0400
From: Oleg Drokin <green@namesys.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
Message-ID: <20020805150436.A1176@namesys.com>
References: <20020805135420.A30430@namesys.com> <Pine.LNX.4.44.0208051243430.31879-100000@pc40.e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208051243430.31879-100000@pc40.e18.physik.tu-muenchen.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 05, 2002 at 12:51:35PM +0200, Roland Kuhn wrote:

> > Unfortunatelly dirty flag for reiserfs gets set way to often than necessary,
> > we have some patches that should help this (from Chris Mason).
> > You can try these for yourself too, for example from here:
> > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 
> I will try it immediately. And I will try to find documentation on how 
> this all is working, so I can understand the implications. Does the 
> "flushing" also happen, when the journal is full? Or is it possible to 

Yes, if journal is full it is also flushed.

> begin a new journal while the old one is written out?

No, it is not possible to begin "new journal" in reiser3.

> > So you might try the patch I mentioned or you can mount with nodiratime mount
> > option to prevent updqting of directory atimes, but having atimes still to be
> > updated on regular files at the same time.
> Interesting mount option, though I think very few application actually use 
> atime anyway, isn't it?

I know for sure that atime on mbox-style files used to determine which messages
are new, and which are not. (N and O status in mutt).
There may be other users as well.

Bye,
    Oleg
