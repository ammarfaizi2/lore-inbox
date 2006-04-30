Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWD3KTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWD3KTl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 06:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWD3KTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 06:19:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19463 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750948AbWD3KTk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 06:19:40 -0400
Date: Sun, 30 Apr 2006 10:02:43 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       John Lenz <lenz@cs.wisc.edu>, Richard Purdie <rpurdie@openedhand.com>
Subject: Re: led_class: storing a value can act but return -EINVAL
Message-ID: <20060430100243.GB4452@ucw.cz>
References: <1146310432.5019.45.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146310432.5019.45.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When I store something into the brightness sysfs attribute of an LED, it
> will accept the value but return -EINVAL:
> 
> johannes:/sys/class/leds/pmu-front-led# echo 255 > brightness
> bash: echo: write error: Invalid argument
> 
> (yet the LED turns on)
> 
> This happens because the store callback doesn't consume all the input.

Well, I'd argue current behaviour is okay... can you strace it? It
should accept the number (return 3) then return -EINVAL.

> There are two possible ways to handle this:
> a) accept anything that begins with a valid number.
> b) reject anything that isn't *only* a number

c) accept anything that is number, ignore newlines.

a) is just way too ugly...
						Pavel

-- 
Thanks, Sharp!
