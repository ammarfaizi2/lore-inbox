Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUGNUhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUGNUhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUGNUhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:37:24 -0400
Received: from gprs214-176.eurotel.cz ([160.218.214.176]:59264 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263574AbUGNUhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:37:22 -0400
Date: Wed, 14 Jul 2004 22:32:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: ext3: bump mount count on journal replay
Message-ID: <20040714203258.GC25802@elf.ucw.cz>
References: <20040714131525.GA1369@elf.ucw.cz> <20040714200554.GR23346@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714200554.GR23346@schnapps.adilger.int>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Currently, you get fsck "just to be sure" once every ~30 clean
> > mounts or ~30 hard shutdowns. I believe that hard shutdown is way more
> > likely to cause some disk corruption, so it would make sense to fsck
> > more often when system is hit by hard shutdown.
> > 
> > What about this patch?
> >
> > @@ -1484,9 +1485,11 @@
> >  	 * root first: it may be modified in the journal!
> >  	 */
> >  	if (!test_opt(sb, NOLOAD) &&
> > -	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) {
> > -		if (ext3_load_journal(sb, es))
> > -			goto failed_mount2;
> > +	    EXT3_HAS_COMPAT_FEATURE(sb, EXT3_FEATURE_COMPAT_HAS_JOURNAL)) { {
> > +		    mount_cost = 5;
> > +		    if (ext3_load_journal(sb, es))
> > +			    goto failed_mount2;
> > +	    }
> 
> AFAICS, this just means that if you have an ext3 filesystem
> (i.e. has_journal) that you will fsck 5x as often, not so great.  You
> should instead check for INCOMPAT_RECOVER instead of HAS_JOURNAL.

Oops, you are right. Updated patch is attached.

> Instead, you could change this to only increment the mount count after
> a clean unmount 20% of the time (randomly).  Since most people bitch
> about the full fsck anyways this is probably the better choice than
> increasing the frequency of checks and forcing the users to change the
> check interval to get the old behaviour.

Nice hack.... would that be acceptable?
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
