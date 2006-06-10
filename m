Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWFJOns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWFJOns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 10:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWFJOns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 10:43:48 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53124 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030427AbWFJOnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 10:43:47 -0400
Date: Sat, 10 Jun 2006 16:42:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <bunk@stusta.de>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610144228.GA6416@elte.hu>
References: <Pine.LNX.4.64.0606090907060.5498@g5.osdl.org> <E1FolFA-0007RU-Ab@w-gerrit.beaverton.ibm.com> <20060610134645.GB11634@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610134645.GB11634@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <bunk@stusta.de> wrote:

> > I'd argue that whatever we call it, we need a standard, stable, 
> > supported solution *soon* for large files, large filesystems, large 
> > storage systems in Linux.
> > 
> > I'd think the quickest path is to relieve the pressure now in ext3.
> 
> Why aren't JFS and XFS good enough for relieving the pressure now?

Compatibility? Upgradability? Simplicity? Supportability?

Even ignoring all those arguments, i find your "ext3/ext4 is too 
complex, use XFS or JFS" argument a bit naive. Please take a quick look 
at the linecount of the filesystems in question:

                  LOC
   ------------------
   ext2:         7492
   ext3+jbd:    22197
   ext4+jbd:    24312

   reiser3:     28857
   reiser4:     79189

   JFS:         32819

   XFS:        110718

the ext3 -> ext4 patches add +2115 lines of code (which 2115 lines solve 
the biggest performance and scaling problem ext3 currently has), which 
is 1.9% of the linecount of XFS.

Q.E.D.

> > We still haven't solved the filesystem check time problem, which is the
> > next big bugaboo.  But getting large fileysstems to real customers soon,
> > e.g. in mainline, well tested, ready for distro support is my real goal.
> >...
> 
> Other people have the "no regressions for existing ext3 users" goal.

frankly, i'll leave that decision to the ext3 developers and obviously, 
to distributors. Their filesystem has handled my data for 10 years, and 
they have been very conservative about their technical choices 
throughout. I trust them to not mess up this time either.

ext3 does quite a few things to stay compatible with ext2 - and frankly, 
i very much expected it to do that when i migrated my ext2 data to ext3. 
The days of "change the world in an incompatible way and dont look back" 
are gone.

	Ingo
