Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFZOVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbTFZOVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:21:40 -0400
Received: from almesberger.net ([63.105.73.239]:52495 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261428AbTFZOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:21:39 -0400
Date: Thu, 26 Jun 2003 11:35:25 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Tommi Virtanen 
	<tv-nospam.da39a3ee5e6b4b0d3255bfef95601890afd80709@tv.debian.net>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030626113525.B1309@almesberger.net>
References: <3EE8D038.7090600@mvista.com> <20030612214753.GA1087@kroah.com> <20030612150335.6710a94f.akpm@digeo.com> <20030612225040.GA1492@kroah.com> <20030619165135.C6248@almesberger.net> <20030626121707.GA10603@lapdog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626121707.GA10603@lapdog>; from tv-nospam.da39a3ee5e6b4b0d3255bfef95601890afd80709@tv.debian.net on Thu, Jun 26, 2003 at 03:17:07PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommi Virtanen wrote:
> 	If you have a sysfs-scanning method for startup, couldn't you
> 	just make the sequence-number-checking daemon reset its state
> 	and redo the sysfs scan on loss of events?

Yes, that's the easier approach if you don't have any detection
of error in the kernel itself. If the kernel already does all
the work for figuring out that something has gone wrong, it may
as well use this to reduce the noise.

> 	That way the system recovers from event loss (or a reordering
> 	that gets the earlier event too late and is believed to be a
> 	loss) in a way that needs to work anyway, and isn't a magic
> 	special case.

Let's just hope reordering stays dead :-)

There's still a bit of magic in loss recovery, because you need
something that triggers loss recovery, after the loss has
happened. That can of course just be whatever else happens to
come along (or the user getting impatient), or a periodic scan.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
