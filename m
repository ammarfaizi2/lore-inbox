Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSL0AGl>; Thu, 26 Dec 2002 19:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbSL0AGl>; Thu, 26 Dec 2002 19:06:41 -0500
Received: from are.twiddle.net ([64.81.246.98]:54920 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S264683AbSL0AGl>;
	Thu, 26 Dec 2002 19:06:41 -0500
Date: Thu, 26 Dec 2002 16:14:44 -0800
From: Richard Henderson <rth@twiddle.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: manfred@colorfullife.com, anton@samba.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5 fast poll on ppc64
Message-ID: <20021226161444.A21658@twiddle.net>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	manfred@colorfullife.com, anton@samba.org,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <200212262055.VAA28874@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212262055.VAA28874@harpo.it.uu.se>; from mikpe@csd.uu.se on Thu, Dec 26, 2002 at 09:55:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 09:55:15PM +0100, Mikael Pettersson wrote:
> >I would agree, but there is a special restriction on offsetof() and 
> >sizeof() of structures with flexible array members: section 6.7.2.1, 
> >clause 16:
> >
> >First, the size of the structure shall be equal to the offset of the
> >last element of an otherwise identical structure that replaces the
> >flexible array member with an array of unspecified length.
[...]
> Oh dear. I checked my C9x draft copy and you seem to be right.
> The standard states that sizeof(struct a1) == offsetof(struct a1, c),
> but both gcc (2.95.3 and 3.2) and Intel's icc (7.0) get it wrong on x86:
> they make sizeof(struct a1) == 8 but offsetof(struct a1, c) == 6.

Indeed, *every* compiler that supports flexible array members
does it this way.  On the gcc lists we've conjectured that this
will wind up being a Defect Report, and so have elected not to
change anything for the nonce.

That said, you should also note that "struct S foo[0]" is *not*
a flexible array member; "struct S foo[]" is.  The former is
gcc's zero-length array extension.  There are subtle differences
between the two features.  See the gcc docs for details.


r~
