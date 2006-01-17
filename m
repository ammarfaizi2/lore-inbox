Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWAQSzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWAQSzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWAQSzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:55:12 -0500
Received: from hera.kernel.org ([140.211.167.34]:4548 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932231AbWAQSzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:55:11 -0500
Date: Tue, 17 Jan 2006 10:53:53 -0800
From: Nathan Laredo <laredo@hera.kernel.org>
To: Michael Krufky <mkrufky@m1k.net>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, webmaster@kernel.org,
       lkml <linux-kernel@vger.kernel.org>, Michael Krufky <mkrufky@gmail.com>
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
Message-ID: <20060117185353.GA28302@hera.kernel.org>
References: <43CCF8BB.1050009@m1k.net> <200601171739.17168.s0348365@sms.ed.ac.uk> <43CD309A.3030704@m1k.net> <200601171817.00182.s0348365@sms.ed.ac.uk> <43CD36FC.4020801@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD36FC.4020801@m1k.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:27:08PM -0500, Michael Krufky wrote:
> >Also, try s/www/zeus2/ in the URL to see if it's a problem 
> >specific to one server (I wonder if the reason some of us have 
> >problems and others don't is that we are being http load 
> >balanced).
> >
> Well, when I used zeus2 directly, I can see the diff...... I tried doing 
> the same with  zeus1, and in fact, the diff does not show.
> 
> That solves it!
> 
> Zeus2 is working correctly, Zeus1 isnt showing us any diff's ......
> 
> Thanks for the help, now, can this be fixed?

A couple things were happening here...

zeus1 suffered a cpu fan failure and was shutdown by external 
hardware that rebooted it into a different kernel (which ended
up resolving the 64-bit sendfile issue (older kernel)

load average on zeus1 was well over 150 with the older kernel--
and a bit of investigation went into whether or not the kernel
was the cause, but in the process of investigation, a third problem 
was discovered...

Logwatch left 39GB of turds in /tmp filling up the entire root
filesystem causing gitweb to fail because it had nowhere to
write temp files (also why the bandwidth graph wasn't showing
up as well for zeus1).

The root filesystem is only 50GB on that machine while /var/log
is hundreds of gigabytes...

/tmp was cleared out, the system is now on a more stable kernel
that should resolve the 64-bit sendfile issues, and the system
load appears to now be at a reasonable level...

We will be updating the kernel on the other machine after the
current one proves stable with 64-bit sendfile support.

That should fix the problem with apache not being able to
serve DVD images...

-- Nathan Laredo
laredo@kernel.org
