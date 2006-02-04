Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946132AbWBDA0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946132AbWBDA0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946136AbWBDA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:26:37 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:44301 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1946132AbWBDA0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:26:36 -0500
Date: Sat, 4 Feb 2006 01:26:35 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Nigel Cunningham <nigel@suspend2.net>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204002635.GB4845@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	Dave Jones <davej@redhat.com>,
	Nigel Cunningham <nigel@suspend2.net>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602031824.45467.rjw@sisk.pl> <20060203183006.GB57965@dspnet.fr.eu.org> <200602032208.58640.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602032208.58640.rjw@sisk.pl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 10:08:57PM +0100, Rafael J. Wysocki wrote:
> By the same token any code that's run as/by root is untrastable and it can
> destroy the system just as well.

Yes, and that's why old timers essentially never run GUI code as root.
The quality of that code tends to be... sloppy compared to the
standards of setuid code or kernel code.


> > That's exactly what I'm terribly afraid of.  You have no way to
> > enforce them, so they won't be respected.  And filesystems will die
> > randomly and unpredictably.
> 
> Yes, this may happen if the userland helpers are buggy, but again any
> root-equivalent process that is buggy can do the damage just as well.
> 
> Your point seem to be "we should implement this in the kernel to protect
> the users from irresponsible authors of userland applications
> and distributors".  I just don't agree with that.  [Going along this line of
> reasoning we should implement fsck in the kernel too. ;-)]

fsck isn't sexy and is implemented by the authors of the filesystems
or in close collaboration with them.  Even there, there is a lot of
talk about fscking live systems but nobody has dared it yet.  That has
some similarities with your situation.

There are two parts in your suspend userland helper.  The
functionality code, which you, and Pavel, and other highly competent
people will write.  I have no qualms with that one.  And then there is
the chrome code, the sexy code, that everybody and his dog is going to
want to muck with because that's where the looks are.  I'll give it 6
months at best from when you have a working system before you get a
submission for some themed, 3d-accelerated buzzword-compliant
nightmare of a progress bar.  With demented pressure to have it in the
official distribution because it looks like Babylon 5 on steroids.
Especially if you have a plugin structure, which otherwise makes a lot
of sense technically.  Will you be able to trust this code to do no
disk access and no other state changes that could be problematic (like
changing vt back to X)?

In other words, opening a window between the snapshot and the shutdown
for look-oriented code you won't control may not be a can of worms you
really want to have to handle.

While from the kernel side you can close the access to what you do not
want disturbed.

  OG.
