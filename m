Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbUKRVSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbUKRVSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKRVQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:16:36 -0500
Received: from almesberger.net ([63.105.73.238]:52491 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261173AbUKRVP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:15:59 -0500
Date: Thu, 18 Nov 2004 18:15:41 -0300
From: Werner Almesberger <wa@almesberger.net>
To: 7eggert@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041118181540.U28844@almesberger.net>
References: <fa.ev73q5c.ejcnom@ifi.uio.no> <fa.es1mdq5.76ib8j@ifi.uio.no> <E1CUtCE-0000us-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUtCE-0000us-00@be1.7eggert.dyndns.org>; from 7eggert@gmx.de on Thu, Nov 18, 2004 at 09:48:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> You'll have some precompiled binaries causing trouble, while other
> precompiled binaries will be killed while you want them to stay alife.

That's why you could use a wrapper.

> Sometimes you'll have the same binary (e.g. perl or java) running a
> "notme"-task like watching the log for intrusion while at the same time
> processing a very large image.

The wrapper could also not be part of the regular execution, and
you'd only use it if you really need it, much like nice, chroot,
etc.

> The best solution I can think of is attaching a kill priority (similar to
> the nice value). Before killing, this value would be added to lg_2(memsize),
> and the least desirable process would "win", even if it's sshd running wild.

I'm extremely sceptical about solutions that require the user to
quantify things. In the world of QoS, if you give users a knob
to play with, the'll stare at in confusion, and ask for the
"faster" button. I don't think the OOM case is much different.

A "victim" (or a "precious") flag has the advantage that the user
doesn't need to estimate peak demands, but still doesn't depend
solely on the verdict of some arcane algorithm working behind
the scenes.

> For the trashing problem: I like the idea of sending a signal to stop the
> process, but it should rather be a request to stop that can be caught by
> the process.

Good idea. That would also help with the problem of browsers
immediately asking to be brought back to life, so that they can
spin the banner ads some more.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
