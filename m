Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVBUPxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVBUPxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVBUPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 10:53:49 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35889
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262020AbVBUPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 10:53:09 -0500
Date: Mon, 21 Feb 2005 16:53:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Miles Bader <miles@gnu.org>
Cc: Dustin Sallings <dustin@spy.net>, lm@bitmover.com,
       Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       linux-kernel@vger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Message-ID: <20050221155306.GU7247@opteron.random>
References: <20050214020802.GA3047@bitmover.com> <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com> <20050218090900.GA2071@opteron.random> <bc647aafb53842b58dd0279161fb48e0@spy.net> <buosm3q5v5y.fsf@mctpc71.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buosm3q5v5y.fsf@mctpc71.ucom.lsi.nec.co.jp>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miles,

On Mon, Feb 21, 2005 at 02:39:05PM +0900, Miles Bader wrote:
> Yeah, the basic way arch organizes its repository seems _far_ more sane
> than the crazy way CVS (or BK) does, for a variety of reasons[*].  No
> doubt there are certain usage patterns which stress it, but I think it
> makes a lot more sense to use a layer of caching to take care of those,
> rather than screwing up the underlying organization.
> 
> [*] (a) Immutability of repository files (_massively_ good idea)

what is so important about never modifying the repo? Note that only the
global changeset database and a few ,v files will be modified for each
changeset, it's not like we're going to touch all the ,v files for each
checkin. Touching the "modified" ,v files sounds a very minor overhead.

And you can incremental backup the stuff with recursive diffing the
repo too.

AFIK all other SCM except arch and darcs always modify the repo, I never
heard complains about it, as long as incremental backups are possible
and they definitely are possible.

>     (b) Deals with tree-changes "naturally" (CVS-style ,v files are a
>         complete mess for anything except file-content changes)

Certainly it's more complicated but I believe the end result will be a
better on-disk format.

Don't get me wrong, current disk format is great already for small
projects, it's the simplest approach and it's very reliable, but I don't
think the current on-disk it scales up to the l-k with reasonable
performance.

>     (c) Directly corresponds to traditional diff 'n' patch, easy to
>         think about, no surprises

Nobody is supposed to touch the repo with an editor anyway, all it
matters is how fast the command works.

And you'll be able to ask to the SCM "show me all changesets touching
this file, or even ""this range" of the file"", in the last 2 years" and
get an answer in dozen seconds like with cvsps today. even cvsps
creates an huge cache, but it doesn't need to unpack >20000 tar.gz
tarballs to create its cache. Feel free to prove me wrong and covert
current kernel CVS to arch and see how big it grows unpacked ;).

Anyway this is quickly going offtopic with l-k, so we should take it to
darcs and arch lists.

Thanks!
