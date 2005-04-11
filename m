Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVDKM7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVDKM7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDKM61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:58:27 -0400
Received: from ns1.suse.de ([195.135.220.2]:26528 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261574AbVDKM4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:56:51 -0400
From: Chris Mason <mason@suse.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: New SCM and commit list
Date: Mon, 11 Apr 2005 08:51:13 -0400
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       David Woodhouse <dwmw2@infradead.org>
References: <1113174621.9517.509.camel@gaston> <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org> <20050411073844.GA5485@elte.hu>
In-Reply-To: <20050411073844.GA5485@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504110851.14416.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 April 2005 03:38, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> > So anything that got modified in just one tree obviously merges to
> > that version. Any file that got modified in two trees will end up just
> > being passed to the "merge" program. See "man merge" and "man diff3".
> > The merger gets to fix up any conflicts by hand.
>
> at that point Chris Mason's "rej" tool is pretty nifty:
>
>   ftp://ftp.suse.com/pub/people/mason/rej/rej-0.13.tar.gz
>
> (There is no fully automatic mode in where it would not bother the user
> with the really trivial rejects - but it has an automatic mode where you
> basically have to do nothing - maybe a fully automatic one could be
> added that would resolve low-risk rejects?)
>

rej -M skips the merge program, so rej -a -M will give you something like 
this:

coffee:/local/linux.p # rej -a -M drivers/ide/ide.c.rej
        drivers/ide/ide.c: 1 matched, 0 conflicts remain

But I would want to go over the bit that calculates the conflicts remaining 
more carefully if people plan on trusting this ;)  It'll run on unified diffs 
too, although it will be slower then patch since the assumption is the quick 
and easy placement patch does has already failed.  (that's easy enough to fix 
though).

> it's really easy to use (but then again i'm a vim user, so i'm biased),
> just try it on a random .rej file you have ("rej -a kernel/sched.c.rej"
> or whatever).

you can rej -m kdiff3|meld|tkdiff or any program that does a side by side 
comparison of two files. (export REJMERGE=foo sets the diff prog as well)

I use rej frequently to merge patches in here, but that is mostly because 
there is no easy way to get the common ancestor and parent revision of the 
patches I'm merging.

With that info in hand, kdiff3 is pretty nice.  You would have to spoon feed 
it the renames, but it should have most of the other features you're looking 
for, including the 'no gui if all conflicts are auto-solvable'

-chris
