Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVLEXZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVLEXZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVLEXZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:25:43 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:20912 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964863AbVLEXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:25:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Tue, 6 Dec 2005 00:05:04 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <20051205081935.GI22168@hexapodia.org>
In-Reply-To: <20051205081935.GI22168@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512060005.04556.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 5 December 2005 09:19, Andy Isaacson wrote:
> On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> seconds or less,

It took much more time on my box, but I won't discuss with your
experience. ;-)

> and writing out the swap image took less than 5 
> seconds, so within 15 seconds of running my suspend script power was
> off.
> 
> The downside was that after suspend, *everything* needed to be paged
> back in, so all my apps were *very* slow for the first few interactions.
> It would take about 15 or 20 seconds for Firefox to repaint the first
> time I switched to its virtual desktop, and it was perceptibly slower
> than normal for the next 5 or 10 minutes of use.
> 
> Now that I'm running 2.6.15-rc3-mm1, the page-in problem seems to be
> largely gone; I don't notice a significant lagginess after resuming from
> swsusp.
> 
> But the suspend process is *slow*.  It takes a good 20 or 30 seconds to
> write out the image, which makes the overall suspend process take close
> to a minute; it's writing about 400 MB, and my disk seems to only be
> good for about 18 MB/sec according to hdparm -t.
> 
> And, the resume is about the same amount slower, too.
> 
> Certainly there's a tradeoff to be made, and I'm glad to lose the slow
> re-paging after resume, but I'm hoping that some kind of improvement can
> be made in the suspend/resume time.

Yes, there is a tradeoff.  Till now, we have used the simplistic approach
based on freeing as much memory as possible before suspend.  Now, we
are freeing only as much memory as necessary, which is on the other
end of the scale, so to speak.  There are a whole lot of possibilities in
between, and there's a question which one is the best.  Frankly, I'm afraid
the answer is very system-dependent.

If you want a quick solution, you can get back to the previous behavior by
commenting out the definition of FAST_FREE in kernel/power/power.h.

Alternatively, you can increase the value of PAGES_FOR_IO, defined
in include/linux/suspend.h.  To see any effect, you'll probably have to
increase it by tens of thousands, but please note the box may be unable
to suspend if it's too great (if you try this anyway, please let me know what
number seems to be the best to you).

Also, I can create a patch to improve this a bit, if you promise to help
test/debug it. ;-)

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

