Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRKDSwp>; Sun, 4 Nov 2001 13:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRKDSw3>; Sun, 4 Nov 2001 13:52:29 -0500
Received: from unthought.net ([212.97.129.24]:51928 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273881AbRKDSwK>;
	Sun, 4 Nov 2001 13:52:10 -0500
Date: Sun, 4 Nov 2001 19:52:09 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Tim Jansen <tim@tjansen.de>, Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104195209.J14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>, Tim Jansen <tim@tjansen.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <160Rpw-0rLDCyC@fmrl05.sul.t-online.com> <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 04, 2001 at 01:30:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 01:30:38PM -0500, Alexander Viro wrote:
> 
> 
> On Sun, 4 Nov 2001, Tim Jansen wrote:
> 
> > So if only some programs use the 'dot-files' and the other still use the 
> > crappy text interface we still have the old problem for scripts, only with a 
> > much larger effort.
> 
> Folks, could we please deep-six the "ASCII is tough" mentality?  Idea of
> native-endian data is so broken that it's not even funny.  Exercise:
> try to export such thing over the network.  Another one: try to use
> that in a shell script.  One more: try to do it portably in Perl script.

So make it network byte order.

How many bugs have you heard of with bad use of sscanf() ?

The counters *are* host specific. Available memory is 32 bits somewhere, 64
other places.  That's the world we live in and hiding the difficulties in ASCII
that *can* be parsed so that it only breaks "sometimes" doesn't help the
application developers.

Better to face the facts, and get over it.

> It had been tried.  Many times.  It had backfired 100 times out 100.
> We have the same idiocy to thank for fun trying to move a disk with UFS
> volume from Solaris sparc to Solaris x86.  We have the same idiocy to
> thank for a lot of ugliness in X.
> 
> At the very least, use canonical bytesex and field sizes.  Anything less
> is just begging for trouble.  And in case of procfs or its equivalents,
> _use_ the_ _damn_ _ASCII_ _representations_.  scanf(3) is there for
> purpose.
> 

scanf can be used wrongly in more ways than the two of us can imagine
together, even if we try.

I disagree with harmonizing field sizes - that doesn't make sense. What's
64 bits today is 128 tomorrow (IPv6 related things, crypto, ...), what
used to fit in 32 is in 64, some places.

Having a library that gives you either compile-time errors if you use it
wrong, or barfs loudly at run-time is one hell of a lot better than having
silent mis-parsing of ASCII values.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
