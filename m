Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUGNUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUGNUeh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbUGNUeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:34:37 -0400
Received: from gprs214-176.eurotel.cz ([160.218.214.176]:58240 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263943AbUGNUef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:34:35 -0400
Date: Wed, 14 Jul 2004 22:30:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Theodore Ts'o" <tytso@mit.edu>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ext3: bump mount count on journal replay
Message-ID: <20040714203012.GB25802@elf.ucw.cz>
References: <20040714131525.GA1369@elf.ucw.cz> <20040714195526.GF3229@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714195526.GF3229@thunk.org>
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
> 
> At least in theory an unclean shutdown is not going to cause any
> problems, unless the hardware is screwy, in which case even a single
> hard shutdown is going to cause problems.  I'm not sure that it
> really

I'd say "unclean shutdown is not going to cause any problems *if it
was due to powerfail". If unclean shutdown is caused by software
problem journaling is not guaranteed to help.

> makes sense to arbitrarily state that a hard shutdown is 5 times more
> likely to cause problems.  We could make it be configurable, I
> suppose, but I'm not sure it's worth it to add all that extra
> complexity.  (Heck, we could also argue using a similar reasoning that
> software suspends also increases the chances of filesystem corruption
> "if something bad happens".  :-)

Well, if you suspend, resume and then your machine crashes, you should
better run fsck, or it is not going to be pretty. Problem is that
during bootup, its hard to tell if machine failed due to powerfail or
if software problem caused shutdown.

Of course, "5" is very wrong number in any case. Do you see any
non-ugly way to make it configurable?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
