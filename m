Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbTCGGmf>; Fri, 7 Mar 2003 01:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbTCGGmf>; Fri, 7 Mar 2003 01:42:35 -0500
Received: from angband.namesys.com ([212.16.7.85]:29570 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261390AbTCGGmd>; Fri, 7 Mar 2003 01:42:33 -0500
Date: Fri, 7 Mar 2003 09:53:07 +0300
From: Oleg Drokin <green@namesys.com>
To: dan carpenter <error27@email.com>
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sf.net
Subject: Re: smatch update / 2.5.64 / kbugs.org
Message-ID: <20030307095307.E4600@namesys.com>
References: <20030307064535.20769.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030307064535.20769.qmail@email.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 07, 2003 at 01:45:35AM -0500, dan carpenter wrote:
> > > The smatch bugs for kernel 2.5.64 are up.  The 
> > > new url for the smatch bug database is http://kbugs.org.  
> > Unfortunatelly the bug database does not work. I mean I cannot connect to it.
> Crap...  sorry about that, I screwed up.

> > This script can produce a lot less false positives with even more custom merge rules.
> > Here's the diff that if run on fs/ext3/super.c from current bk tree, produces
> > only one true bug. (your version from cvs produces one real bug and two false positives)
> > (8 less hits on my default build).
> I have uploaded your modifications to CVS.  I'll use it 
> on the next kernel release.  The unfree.pl was just a few
> modifications to the deference_check.pl so your patch
> will cut down on the false positives with that also.

Actually I think these free() checks can be extended a lot, it can detect memory leaks and so on.

I have preliminary working version here, but it was only barely tested (And not tested on real kernel at all).
I will spend more time on it today and then send it in.
Incidentally this new version should also work on non-kernel code too, I think ;)
I think that tracking only negative/NULL returns is not the best way.
My current approach is to add several more states like "exported" which means that this value was added
to externally visible variable. Then upon reaching return/end of function we can see if all the
allocated stuff was freed or exported. Tricky part seems to correctly merge all these states
from different branches of if steatements.

Also is anybody working on "redundant assignments" stuff as described in Standford guys papers?

Bye,
    Oleg
