Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUKZXxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUKZXxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUKZTnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:43:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20931 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262450AbUKZT2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:16 -0500
Date: Thu, 25 Nov 2004 22:50:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
Message-ID: <20041125215005.GF2488@elf.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294252.5805.228.camel@desktop.cunninghams> <20041125180725.GB1417@openzaurus.ucw.cz> <1101418822.27250.26.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101418822.27250.26.camel@desktop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The sys_ functions are exported because a while ago, people suggested I
> > > use /dev/console to output text that doesn't need to be logged, and I
> > > also use /dev/splash for the bootsplash support. These functions were
> > 
> > Well, we don't do ascii-art on kernel boot and I do not see why we should do it
> > on suspend. Distributions will love bootsplash integration, but it should stay as a separate
> > patch.
> 
> It's modular, so no problem there.

That *is* problem. mainline kernel is not expected to carry stuff like
that. We do not have bash as a kernel module. Not even gzip. And we
should not have ascii-art, too.

> > See swsusp1... it has percentage printing, and I think it should
> > be possible to make it look good enough.
> 
> We can always make a tex_ mode_for_Pavel plugin :>

Yes, and then kill all the other plugins from mainline patches and
submit that. That would work. Ouch and that means no ugly hooks all
over the place in whatever goes into mainline.... and preferably no
plugin interface, too.

> > Why do you need sys_mkdir?
> 
> The text mode plugin is using it to make /dev (if it doesn't exist) so
> it can try to mount devfs (if necessary) and open /dev/console to do the
> output. I'd love to just use vt_console_print, but those who know better
> then me said to use /dev/console...

Ugh, ouch. So if /dev/ is not there you just go and walk over user's
filesystem? Please, let's forget the asciiart.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
