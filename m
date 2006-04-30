Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWD3MLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWD3MLf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWD3MLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:11:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3972 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750778AbWD3MLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:11:34 -0400
Date: Sun, 30 Apr 2006 14:10:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       John Lenz <lenz@cs.wisc.edu>, Richard Purdie <rpurdie@openedhand.com>
Subject: Re: led_class: storing a value can act but return -EINVAL
Message-ID: <20060430121047.GB30024@elf.ucw.cz>
References: <1146310432.5019.45.camel@localhost> <20060430100243.GB4452@ucw.cz> <1146394862.5019.53.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146394862.5019.53.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I'd argue current behaviour is okay... can you strace it? It
> > should accept the number (return 3) then return -EINVAL.
> 
> That's exactly what happens.

And that's pretty much exactly okay.

You got success return when you wrote "255" there, then you got
-EINVAL when you tried to put newline there. Expected behaviour, I'd
say.

...I can see it looks ugly when you do echo manually, but you simply
should not do that.

> Which is totally bogus, because userspace will think that the setting
> didn't succeed. Or application authors will ignore the return value
> assuming that it always succeeded. Or read the value back to see if it
> succeeded. All icky, when we can well have a good return value.

Well, they got what they deserve, that \n does not belong there. And
they _did_ get success report -- "3" was returned. That's how unix
works, I'd say. Educate userspace authors that adding \n is bad idea.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
