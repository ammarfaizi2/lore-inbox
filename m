Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWD3L6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWD3L6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 07:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWD3L6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 07:58:08 -0400
Received: from tim.rpsys.net ([194.106.48.114]:48093 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750783AbWD3L6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 07:58:07 -0400
Subject: Re: led_class: storing a value can act but return -EINVAL
From: Richard Purdie <rpurdie@rpsys.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       John Lenz <lenz@cs.wisc.edu>, Richard Purdie <rpurdie@openedhand.com>
In-Reply-To: <1146394862.5019.53.camel@localhost>
References: <1146310432.5019.45.camel@localhost>
	 <20060430100243.GB4452@ucw.cz>  <1146394862.5019.53.camel@localhost>
Content-Type: text/plain
Date: Sun, 30 Apr 2006 12:57:49 +0100
Message-Id: <1146398270.6254.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-30 at 13:01 +0200, Johannes Berg wrote:
> Hi,
> 
> > Well, I'd argue current behaviour is okay... can you strace it? It
> > should accept the number (return 3) then return -EINVAL.
> 
> That's exactly what happens.
> 
> Which is totally bogus, because userspace will think that the setting
> didn't succeed. Or application authors will ignore the return value
> assuming that it always succeeded. Or read the value back to see if it
> succeeded. All icky, when we can well have a good return value.
> 
> > > There are two possible ways to handle this:
> > > a) accept anything that begins with a valid number.
> > > b) reject anything that isn't *only* a number
> > 
> > c) accept anything that is number, ignore newlines.

echo 255> brightness works, returns success.
echo 255 > brightness works but then returns -EINVAL.

So we currently do b, quite strictly. Its the trailing space thats the
problem. It also shouldn't have altered the brightness value if it ends
up returning -EINVAL.

I've looked around other implementations and it would appear we should
accept an optional space. Most sysfs attributes seem to handle this
differently, each with its own "bugs".

I've some fixes in mind both for the led and backlight classes which
I'll post once I've done a little more testing. I'd be interested to
know the official view on what the attributes should/shouldn't accept
is.

Cheers,

Richard

