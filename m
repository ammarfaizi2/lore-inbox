Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVBFNeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVBFNeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBFNeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:34:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:12261 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261240AbVBFNcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:32:48 -0500
Date: Sun, 6 Feb 2005 14:32:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206133239.GA4483@elte.hu>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu> <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org> <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org> <20050206131130.GJ30109@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206131130.GJ30109@wotan.suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> On Sun, Feb 06, 2005 at 01:06:50PM +0000, Christoph Hellwig wrote:
> > On Sun, Feb 06, 2005 at 02:01:52PM +0100, Andi Kleen wrote:
> > > > correct,
> > > > http://lists.ximian.com/archives/public/mono-list/2004-June/021592.html
> > > > 
> > > > that fixes mono instead
> > > 
> > > Silent breakage => bad.
> > 
> > silent breakage for newly compiled buggty and non-portable code.
> 
> Executing custom code in mmap is by definition non portable, 
> so this argument doesn't make very much sense.
> 
> > 
> > Still not nice but certainly tolerable.  
> 
> I strongly disagree that breaking source level compatibility silently
> like this is tolerable.
> 
> Especially since it won't even affect most users, so most developers
> won't notice it, only the x86-64 users. This makes it extremly silent
> for most people.

fortunately there's this 'NX-emulation' thing called exec-shield which
is part of Fedora (and has been part of it for almost 2 years) and did
all the testing for you on all x86 hardware, on thousands of packages
and on over a ten thousand binaries, well in advance of this going
upstream. It wasnt a bump-free ride, but it was worth it.

(the Mono bug was found this way, the Grub one wasnt, due to it being
RWE. But if it triggers it shows up immediately so it's not like you
have no sign that something wrong is going on. Only grub-install
triggers it and no boot/install kernel i know of defaults to
PAE-enabled, that's what caused grub-install being used in an NX
scenario so infrequently.)

anyway, this particular flamewar might have made more sense last Summer.

	Ingo
