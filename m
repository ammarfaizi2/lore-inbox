Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVL3GJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVL3GJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 01:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVL3GJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 01:09:39 -0500
Received: from thunk.org ([69.25.196.29]:42138 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751172AbVL3GJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 01:09:38 -0500
Date: Fri, 30 Dec 2005 00:14:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
Message-ID: <20051230051413.GA7431@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com> <20051230004608.GA12822@redhat.com> <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org> <20051230012145.GD12822@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230012145.GD12822@redhat.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 08:21:45PM -0500, Dave Jones wrote:
> With 2.6.14 on my testbox, I get this..
> 
> $ ls /dev/input/
> event0  event1  mice  mouse0
> 
> With 2.6.15rc
> 
> $ ls /dev/input/
> mice
> 
> If I can dig out the bugzilla that reported this, I'll followup.
> Something in my head is telling me it had something to do with
> laptop touchpads, but that could be the post-xmas `nog talking.

When I got bitten with this udev breakage a while ago, it wasn't a
matter of /dev/input/event? in the X configuration file, but that the
Synaptics driver directly searches for /dev/input/event?  files to
talk directly to the raw touchpad device driver directly, and fails to
initialize, thus causing the X server initialization to fail.  There
may be other failure scenarios, but this was the one I ran into with
my laptop.

							- Ted
