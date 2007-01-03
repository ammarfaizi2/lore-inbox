Return-Path: <linux-kernel-owner+w=401wt.eu-S1750724AbXACL5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbXACL5N (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 06:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbXACL5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 06:57:13 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40561 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750719AbXACL5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 06:57:12 -0500
Date: Wed, 3 Jan 2007 12:56:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bhalevy@panasas.com, arjan@infradead.org, mikulas@artax.karlin.mff.cuni.cz,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070103115632.GA3062@elf.ucw.cz>
References: <20061221185850.GA16807@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org> <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu> <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > the use of a good hash function.  The chance of an accidental
> > > collision is infinitesimally small.  For a set of 
> > > 
> > >          100 files: 0.00000000000003%
> > >    1,000,000 files: 0.000003%
> > 
> > I do not think we want to play with probability like this. I mean...
> > imagine 4G files, 1KB each. That's 4TB disk space, not _completely_
> > unreasonable, and collision probability is going to be ~100% due to
> > birthday paradox.
> > 
> > You'll still want to back up your 4TB server...
> 
> Certainly, but tar isn't going to remember all the inode numbers.
> Even if you solve the storage requirements (not impossible) it would
> have to do (4e9^2)/2=8e18 comparisons, which computers don't have
> enough CPU power just yet.

Storage requirements would be 16GB of RAM... that's small enough. If
you sort, you'll only need 32*2^32 comparisons, and that's doable.

I do not claim it is _likely_. You'd need hardlinks, as you
noticed. But system should work, not "work with high probability", and
I believe we should solve this in long term.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
