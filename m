Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbTHZFsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTHZFsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:48:25 -0400
Received: from almesberger.net ([63.105.73.239]:31240 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262684AbTHZFsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:48:15 -0400
Date: Tue, 26 Aug 2003 02:48:08 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030826024808.B3448@almesberger.net>
References: <Pine.LNX.4.44.0308250518380.26988-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308250518380.26988-100000@localhost.localdomain>; from nagendra_tomar@adaptec.com on Mon, Aug 25, 2003 at 05:30:16AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:
> 	While going thru the code for tasklet_kill(), I cannot figure out 
> how recursive tasklets (tasklets that schedule themselves from within 
> their tasklet handler) can be killed by this function. To me it looks that 
> tasklet_kill will never complete for such tasklets.

That's also what I found when looking at it a while ago. This isn't
necessarily a bug of tasklet_kill, just some behaviour that needs
to be documented.

You can always introduce a flag that tells the tasklet if it should
reschedule itself, and clear that flag before calling tasklet_kill.

When I looked at it (I think this was in some 2.4 kernel), it also
seemed that tasklet_kill could loop forever if the tasklet is
scheduled but disabled.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
