Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbUJYVIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbUJYVIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUJYVIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:08:23 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:39692 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261963AbUJYUxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:53:39 -0400
Date: Mon, 25 Oct 2004 22:54:59 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH] I2C update for 2.6.9
Message-Id: <20041025225459.5ffc37ba.khali@linux-fr.org>
In-Reply-To: <417D4621.5010604@tmr.com>
References: <1098231506642@kroah.com>
	<10982315063481@kroah.com>
	<417D4621.5010604@tmr.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> Greg KH wrote:

I actually wrote this.

> > Trip points
> > ===========
> > 
> > Trip points are now numbered (point1, point2, etc...) instead of
> > named(_off, _min, _max, _full...). This solves the problem of
> > various chips having a different number of trip points. The
> > interface is still chip independent in that it doesn't require
> > chip-specific knowledge to be used by user-space apps.
> 
> It would seem that all chips would have off, max, full, etc, but
> mapping nondescript names into functionality may require some chip
> info anyway. As you note, with some chips these are not nice linear
> points on a line, 
>   so it would seem to tell if the top points were "max norm" and "max 
> safe" vs. "critical" and "shutdown NOW" is still going to need some 
> information on the chip, both points and operating range.

The interface is actually (almost) self-sufficient. A point is the union
of a temperature and a fan speed. Most often, point1 will have a speed
of 0, which means it really is _off. point1 will be fan_min. point(P-1)
will be _max, point(P) will have a speed of 100% and will be _full. The
advantage of the numbered approach is that you can have has many points
as the chip provides. It will also help user-space applications, since
all points can be handled the exact same way, without having to
interpret the names, know that some names have predefined fan speeds,
etc.

The only thing the interface doesn't tell is the shape of the curve
resulting from the various trip points. This is admittedly chip
dependent. I think it would be next to impossible to export this through
sysfs, and I'm not sure it would be worth the pain anyway. The exact
shape of the curve isn't that important IMHO.

Your objection about "critical", "shutdown NOW" etc if out of the scope
of this interface. The critical limits are defined by tempN_crit files.
Actions taken by the chip when the limit is crossed is admittedly
chip-dependent. Not a big deal either, since in most cases this is
either not configurable or motherboard-dependent and set by the BIOS for
us anyway.

I hope I answered your question-which-was-not-really-one. :)

-- 
Jean Delvare
http://khali.linux-fr.org/
