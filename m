Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTKFDBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 22:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTKFDBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 22:01:32 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:25533 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263303AbTKFDBa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 22:01:30 -0500
Date: Wed, 5 Nov 2003 19:01:25 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tomas Szepe <szepe@pinerecords.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: BK2CVS problem
Message-ID: <20031106030125.GA27184@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tomas Szepe <szepe@pinerecords.com>,
	Chad Kitching <CKitching@powerlandcomputers.com>,
	linux-kernel@vger.kernel.org, tytso@mit.edu
References: <18DFD6B776308241A200853F3F83D507169CBC@pl6w2kex.lan.powerlandcomputers.com> <20031105230350.GB12992@work.bitmover.com> <20031106005224.GA7105@louise.pinerecords.com> <20031105185713.U10197@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105185713.U10197@schatzie.adilger.int>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 06:57:13PM -0700, Andreas Dilger wrote:
> First of all, thanks Larry for detecting this.  Your paranoia that made
> you add extra checks on the export of data (also evident in the BK
> checksums everywhere) probably saved Linux as a whole a lot of grief.  

Thanks for noticing that, it makes the extra work worth it, it really does.

For those of you wondering what this is about, the way the export works is:

    a) get a BK tree on an internal BitMover machine
    b) export that to a CVS tree on an internal BitMover machine
    c) copy the updated files to kernel.bkbits.net's CVS tree
    d) checksum the tree on kernel.bkbits.net and here and compare them

All of this is done out of cron with mail sent if there is a problem,
which is what caught this difference.  If we weren't trained to trust
noone then this problem would have gone unnoticed and the CVS users could
have sent in a patch that included this trojan horse and compromised
Linux.  

It's worth mentioning that it would be close to impossible to add the
same to change to BK unnoticed.  It's possible but the accountability
would be a lot better and the bad user could be tarred and feathered.

> Had something like this been submarined into the kernel without any
> review it might have taken a good while to find, even though it wasn't
> in the BK repository itself.  Are the incremental kernel patches on
> kernel.org or anything else built from the BKCVS gateway?

It's possible but I doubt it.  I've verified 30 seconds ago that the
change is not in in Linus' BK tree.  We run these comparisons every night
(and I'm going to increase that after we reinstall the machine).  So I
noticed this this morning and had the tree fixed this afternoon; I suppose
people could complain that it should have been sooner but I was running
tests to make sure it was not some problem in the BK2CVS exporter code.

Even with the delay, the problem was identified and corrected in less
than 24 hours.  That doesn't leave a lot of time to have the problem
get into the real release tree.

> Granted that this was not a break in BK itself the event is still alarming.
> It makes me wonder if there is some way we can start using GPG signatures
> with BK itself so that you can get proof-positive that a CSET annotated
> as from davem really is from the David Miller we know and trust.

I couldn't agree more, we've thought about this and have a design,
but credit where credit is due, Ted T'so is the driving force behind
this idea.  He and I have had long discussions about this and we have a
plan to do exactly that in BK.  I've already told Linus that we can add
that to BK, and will, in the free version, so that you can at least be
assured that all the stuff in BK is either flagged trusted or untrusted.

We think that is an excellent idea, we want to do it, but we were waiting
for some event to trigger it.  We've been berated publicaly for each
and every change we've made to the free version of BK so now we wait
for people to ask for changes and then we'll make them.  Just say the
word and we'll code this up as soon as we can.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
