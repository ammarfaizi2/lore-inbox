Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269221AbRH2Xnd>; Wed, 29 Aug 2001 19:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRH2XnX>; Wed, 29 Aug 2001 19:43:23 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:19204 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269221AbRH2XnI>; Wed, 29 Aug 2001 19:43:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Thu, 30 Aug 2001 01:49:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108290858410.19372-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.33.0108290858410.19372-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010829234316Z16134-32384+1075@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 29, 2001 06:02 pm, David Lang wrote:
> one question that I thought of in context with the other e-mails in this
> thread.
> 
> when you write a signed/unsigned comparison is it defined in any standard
> which type the compiler should generate or is it somethign that could be
> different in different compilers (and versions)

Yes, in the signed/unsigned case the comparison generated is always
unsigned.  This is something that all c programmers are supposed to have 
tattoed on the insides of their eyelids, because if you don't know it
there are all kinds of situations that can bite you, not just min and
max.

> (also when comparing different size items same question)

The narrower is expanded to the size of the wider before being compared.

> if there are cases that are not defined in a standard and could vary by
> compiler/version then we definantly need to have the current version with
> the type argument.

No, these cases are defined perfectly clearly and have been at least
since K&R.

> David Lang
> 
> 
>  On Wed, 29 Aug 2001,
> Daniel Phillips wrote:
> 
> > Date: Wed, 29 Aug 2001 17:42:39 +0200
> > From: Daniel Phillips <phillips@bonn-fries.net>
> > To: Linus Torvalds <torvalds@transmeta.com>
> > Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
> > Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
> >
> > On August 29, 2001 03:13 am, Linus Torvalds wrote:
> > > On Wed, 29 Aug 2001, Daniel Phillips wrote:
> > > >
> > > >     min(host->scsi.SCp.this_residual, (unsigned) DMAC_BUFFER_SIZE / 
2);
> > >
> > > Sure.
> > >
> > > If you put the type information explicitly, you can get it right.
> > >
> > > Which is, btw, _exactly_ why the min() function takes the type 
explicitly.
> >
> > My point is that proper programming discipline would have prevented the
> > problem from arising in the first place.  It would be far more appropriate
> > for kernel programmers to exercise such discpline than to treat them like
> > babies, breaking well-known syntax in the process.
> >
> > It seems trivial to pick up all potential min/max problems with the 
Stanford
> > Checker in the case some programmer has been too clueless to think about
> > their code as they write it.  A simple policy statement for users of 
min/max
> > would have avoided this entire mess.
> >
> > Not that I you're going to back down, it just made me feel better to get 
this
> > off my chest ;-)
> >
> > --
> > Daniel
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
