Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbUJYS3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUJYS3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbUJYS3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:29:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27537 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261225AbUJYS1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:27:47 -0400
Message-ID: <417D4621.5010604@tmr.com>
Date: Mon, 25 Oct 2004 14:29:53 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] I2C update for 2.6.9
References: <1098231506642@kroah.com> <10982315063481@kroah.com>
In-Reply-To: <10982315063481@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Trip points
> ===========
> 
> Trip points are now numbered (point1, point2, etc...) instead of named
> (_off, _min, _max, _full...). This solves the problem of various chips
> having a different number of trip points. The interface is still chip
> independent in that it doesn't require chip-specific knowledge to be
> used by user-space apps.

It would seem that all chips would have off, max, full, etc, but mapping 
nondescript names into functionality may require some chip info anyway. 
As you note, with some chips these are not nice linear points on a line, 
  so it would seem to tell if the top points were "max norm" and "max 
safe" vs. "critical" and "shutdown NOW" is still going to need some 
information on the chip, both points and operating range.

That's an observation, not a complaint, not even a question unless you 
feel the urge to enlighten me.
> 
> The reason for this change is that newer chips tend to have more trip
> points. the LM63 has 8, the LM93 has no less than 12. Also, I read in
> the LM63 datasheet that ideal pwm vs temperature curve were parabolic in
> shape. Seems hard to achieve this if we arbitrarily lock the number of
> trip points to 3 ;)
> 
> I also introduced an optional hysteresis temperature for trip points.
> The LM63 has this. Since it makes full sense I'd expect other chips to
> propose this as well.
> 
> As before, there are two sets of files, each chip driver picks the one
> matching its internal model: trip points are either temperature
> channel-dependent (ADM1031...) or pwm channel-dependent (IT87xx...). If
> we ever come accross fan speed-driven pwm outputs where trip points are
> fan channel-dependent we may have to offer a third set of files. We'll
> see when/if this happens.
> 
> I hope I have taken everyone's comments and advice into account and we
> can make this interface proposal part of the sysfs interface standard
> now. I'm sorry it took so long. Comments welcome.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
