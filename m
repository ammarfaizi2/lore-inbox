Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUFQT1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUFQT1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUFQT1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:27:43 -0400
Received: from witte.sonytel.be ([80.88.33.193]:3313 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261867AbUFQT1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:27:39 -0400
Date: Thu, 17 Jun 2004 21:27:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Finn Thain <ft01@webmastery.com.au>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Matt Mackall <mpm@selenic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Subject: Re: make checkstack on m68k
In-Reply-To: <20040617183616.GC29029@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.58.0406172127150.1495@waterleaf.sonytel.be>
References: <200406161930.VAA16618@pfultra.phil.uni-sb.de>
 <Pine.LNX.4.58.0406171812440.8197@bonkers.disegno.com.au>
 <20040617183616.GC29029@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> On Thu, 17 June 2004 18:43:18 +1000, Finn Thain wrote:
> > Jörn Engel wrote:
> > > On Wed, 16 June 2004 18:51:03 +0200, Geert Uytterhoeven wrote:
> > > >
> > > > @@ -40,6 +40,11 @@
> > > >  	} elsif ($arch =~ /^ia64$/) {
> > > >  		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
> > > >  		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
> > > > +	} elsif ($arch =~ /^m68k$/) {
> > > > +		#2b6c:       4e56 fb70       linkw %fp,#-1168
> > > > +		#$re = qr/.*linkw %fp,#-([0-9]{1,4})/o;
> > > > +		#1df770:       defc ffe4       addaw #-28,%sp
> > > > +		$re = qr/.*addaw #-([0-9]{1,4}),%sp/o;
> > >
> > > For i386 I used a really ugly hack, but this needs someone with better
> > > perl skills.  Matt, can you find a nice regex?  If it adds more
> > > brackets, that's fine.  We'll just add empty brackets to the other
> > > regexes and use $2 instead of $1 or so.
> >
> > There is no nice way to do this in perl in a single regex and have the
> > result always in $1 or always in $2. So you would test for undef in one
> > and use the other.  But then the other arch regexes that capture more than
> > one cluster would need to be rewritten to use (?: ) syntax to get
> > clustering without capturing (see man perlre) so as to leave $2 undefined.
> >
> > A list of regexes for each arch would be nice. But should probably be
> > left until needed. Following is probably the simplest way. The regexes
> > remain understandable to mortals since they don't do fancy stuff. And the
> > other archs don't need to be touched.
>
> It's not as ugly as my hack.  Can I get a success report from m68k?
> Thanks!

Works.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
