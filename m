Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272431AbRH3UYd>; Thu, 30 Aug 2001 16:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272432AbRH3UYX>; Thu, 30 Aug 2001 16:24:23 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50192 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272431AbRH3UYM>; Thu, 30 Aug 2001 16:24:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Weinehall <tao@acc.umu.se>, "Peter T. Breuer" <ptb@it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Thu, 30 Aug 2001 22:31:10 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com> <200108301638.SAA04923@nbd.it.uc3m.es> <20010830215151.A14715@khan.acc.umu.se>
In-Reply-To: <20010830215151.A14715@khan.acc.umu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010830202428Z16099-32383+2509@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 30, 2001 09:51 pm, David Weinehall wrote:
> On Thu, Aug 30, 2001 at 06:38:40PM +0200, Peter T. Breuer wrote:
> > "Linus Torvalds wrote:"
> > > What if the "int" happens to be negative?
> > 
> >    if sizeof(typeof(a)) != sizeof(typeof(b)) 
> >        BUG() // sizes differ
> >    const (typeof(a)) _a = ~(typeof(a))0   
> >    const (typeof(b)) _b = ~(typeof(b))0   
> >    if _a < 0 && _b > 0 || _a > 0 && b < 0
> >        BUG() // one signed, the other unsigned
> >    standard_max(a,b)
> 
> <disgusting vomit-sound>Do you really want code like that in the
> kernel (yes, I know that there are code that can compete with it in
> ugliness</disgusting vomit-sound>

Well, loook, if the signedness and widths match all the tests get optimized 
out as constant expressions, if they don't it barfs with BUG and the author 
has to insert specify saner types for the input variables.  It's nice.

This accomplishes what 3arg_min/max set out to do without messing up the 
syntax.

--
Daniel
