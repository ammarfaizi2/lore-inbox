Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbTDAONw>; Tue, 1 Apr 2003 09:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbTDAONw>; Tue, 1 Apr 2003 09:13:52 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:54229 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S262549AbTDAONv>; Tue, 1 Apr 2003 09:13:51 -0500
Date: Wed, 2 Apr 2003 00:23:18 +1000
From: CaT <cat@zip.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030401142317.GC459@zip.com.au>
References: <1049194788.22942.9.camel@bip.localdomain.fake> <Pine.LNX.4.44.0304011207500.9723-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304011207500.9723-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 12:11:46PM +0100, Hugh Dickins wrote:
> On 1 Apr 2003, Xavier Bestel wrote:
> >                         size = memparse(value,&rest);
> > +                       if (*rest == '%') {
> > +                               struct sysinfo si;
> > +                               si_meminfo(&si);
> > +                               size = (si.totalram << PAGE_CACHE_SHIFT) / 100 * size;
> > 
> > (si.totalram << PAGE_CACHE_SHIFT) * size / 100;
> > would have been better precision-wise.
> 
> Hardly, it'll overflow in even more cases
> than CaT's (si.totalram << PAGE_CACHE_SHIFT).

Yes. I had it initially as Xavier suggested but after thinking about it
a bit I felt that making the value smaller and -then- bigger was safer.

> I'll take a look at this later, not right now.

It is still an unsigned long long int so (AFAIK) it wont overflow till
it hits 18,446,744,073,709,551,615. Now... if you have that much ram...
wow! :)

Basically it'll only overflow for astoundingly stupid values of size and
when it comes down to it, I think you could still make it overflow by
setting a REALLY large static value for size anyways (liek greater then
the above). Same issue as far as I can see.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, Leader of the United States Regime
          September 26, 2002 (from a political fundraiser in Houston, Texas)
