Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275055AbTHRUod (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275057AbTHRUod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:44:33 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36874
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275055AbTHRUoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:44:25 -0400
Date: Mon, 18 Aug 2003 13:43:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, marcelo@conectiva.com.br,
       akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818204338.GE10320@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, marcelo@conectiva.com.br,
	akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
References: <16182.54248.868067.968522@gargle.gargle.HOWL> <20030811113302.6f30a256.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811113302.6f30a256.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:33:02AM +0200, Stephan von Krawczynski wrote:
> On Mon, 11 Aug 2003 09:23:20 +1000
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> > On Sunday August 10, skraw@ithnet.com wrote:
> > > 
> > > From looking at the tests so far I would say the setup is remarkably slower
> > > in terms of writing to ext3 via nfs and sync option set. I think especially
> > > the"sync" is very visible - unlike reiserfs.
> > 
> >   data=journal
> > makes nfsd go noticable faster over ext3.  Having an external journal
> > is even better.
> 
> Uh, forgive my ignorance. "journal" means metadata+data journaling. If I have
> large data movement, how can that be even faster? Ok, I see the facts around
> sync'ing the fs. But anyway the data size written should be nearly doubled
> compared to data=ordered. Reiserfs journaling has to be real incredible in
> comparison to ext3(ordered). I have the impression that large files are hit
> most.

You enlarge your journal (larger for more activity).

The idea is that the sync puts all data+meta-data into the journal, and once
that's complete the sync returns.

After the sync returns, the data is written from the journal asyncrounously
in the background while you're not waiting.

If your system is stressed to its limit, this won't work, but in the common
case, it will speed up your nfs server.

Though, after using reiserfs for a while, writeout is smoother.  There
aren't the spikes like with ext3 (even in ordered mode), but that could be
due to the 30 second timeout on reiserfs compared to 5 second for ext3
before writes are committed to disk (without memory pressure).
