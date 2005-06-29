Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVF2QXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVF2QXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVF2QXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:23:45 -0400
Received: from mail1.kontent.de ([81.88.34.36]:62627 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261575AbVF2QWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:22:11 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Mike Bell <kernel@mikebell.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Date: Wed, 29 Jun 2005 18:22:29 +0200
User-Agent: KMail/1.8
References: <20050624081808.GA26174@kroah.com> <200506290841.29785.oliver@neukum.org> <20050629160659.GA23594@kroah.com>
In-Reply-To: <20050629160659.GA23594@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291822.29351.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. Juni 2005 18:06 schrieben Sie:
> On Wed, Jun 29, 2005 at 08:41:29AM +0200, Oliver Neukum wrote:
> > What devfs and udev can do, and a static dev cannot, is names independent
> > of order of detection.
> 
> devfs can not do that.

Why not?

> > As for ressources, it is an illusion to think that user space means
> > less ressources. A demon means page tables and a kernel stack. That
> > 12K unswappable memory in the best case.
> 
> You don't have to run the udevd process if you are worried about an

What about events arriving out of order?

> extra process in your kernel tables.  Although this is the first time I
> have heard anyone voice the "oh no, not another userspace task running"
> point :)

Well, you should have. 16K is a more realistic figure. Tasks have their cost.
In fact:
root         1  0.0  0.0    684   248 ?        S    16:58   0:01 init [5]
root         2  0.0  0.0      0     0 ?        SN   16:58   0:00 [ksoftirqd/0]
root         3  0.0  0.0      0     0 ?        S<   16:58   0:00 [events/0]
root         4  0.0  0.0      0     0 ?        S<   16:58   0:00 [khelper]
root         5  0.0  0.0      0     0 ?        S<   16:58   0:00 [kthread]
<snip>
root      3424  0.0  0.1   2032   632 tty3     Ss+  16:59   0:00 /sbin/mingetty tty3
root      3425  0.0  0.1   2032   632 tty4     Ss+  16:59   0:00 /sbin/mingetty tty4
root      3426  0.0  0.1   2032   632 tty5     Ss+  16:59   0:00 /sbin/mingetty tty5
root      3427  0.0  0.1   2032   632 tty6     Ss+  16:59   0:00 /sbin/mingetty tty6

Counting this I arrive at 51*16K = 816K. That's a whole lot of unswappable
memory. Thinking user space cheap is an automatic reflex these days. It's
sometimes misleading like all blind reflexes.
It makes me feel a fool for caring about __init and __exit.

	Regards
		Oliver
