Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTDGUDW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTDGUDW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 16:03:22 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:16554 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263623AbTDGUDV (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 16:03:21 -0400
Date: Mon, 7 Apr 2003 22:13:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: MTRR save and restore.
Message-ID: <20030407201311.GA177@elf.ucw.cz>
References: <1049530866.2241.23.camel@laptop-linux.cunninghams> <200304062220.h36MKC35017233@vindaloo.ras.ucalgary.ca> <1049680104.12790.46.camel@laptop-linux.cunninghams> <20030407130507.GA16919@atrey.karlin.mff.cuni.cz> <200304071646.h37GkBd6005985@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304071646.h37GkBd6005985@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[I added l-k to the cc list].

> > > We could add it to suspend scripts, but wouldn't mtrrs fit into the
> > > driver model idea? Would you say the same thing about implementing S3
> > > support?
> > 
> > I think going through the driver model is the right thing to
> > do.
> 
> It's useless bloat.
> 
> > Userspace should not need to know about mtrrs,
> 
> It's a swsuspend helper daemon, not some random application. There
> *should* be a helper daemon, if not, the design is flawed.

There's no helper daemon, nor I plan to make one. Notice that mtrr
stuff is shared between S3 (== suspend to ram) and swsusp. Both S3 and
swsusp can be used to do some pretty important stuff (machine
overheats or battery critically low -> suspend somewhere), so I do not
think userland daemon is good idea.

It can be dependend on CONFIG_PM; if you still think that's too much
bloat, it could be dependend on CONFIG_SLEEP which could be only
compiled when S3 or swsusp is selected (but I feel that would be
overdesign).

								Pavel
-- 
When do you have heart between your knees?
