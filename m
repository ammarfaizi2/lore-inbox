Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVE3TYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVE3TYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 15:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVE3TYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 15:24:13 -0400
Received: from colin.muc.de ([193.149.48.1]:53263 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261162AbVE3TYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 15:24:09 -0400
Date: 30 May 2005 21:24:08 +0200
Date: Mon, 30 May 2005 21:24:08 +0200
From: Andi Kleen <ak@muc.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Chris Friesen <cfriesen@nortel.com>,
       john cooper <john.cooper@timesys.com>, linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
Message-ID: <20050530192408.GA25794@muc.de>
References: <934f64a205052715315c21d722@mail.gmail.com> <A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de> <429B289D.7070308@nortel.com> <20050530164003.GB8141@muc.de> <429B4957.7070405@nortel.com> <m1k6lgwqro.fsf@muc.de> <02485B05-6AE5-4727-8778-D73B2D202772@mac.com> <20050530184059.GA2222@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530184059.GA2222@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >I suspect any attempt to use time stamps in locks is a bad
> > >idea because of this.
> > 
> > Something like this could be built only for CPUs that do support that
> > kind of cycle counter.
> 
> RDTSC on older Intel CPUs takes something like 6 cycles. On P4's it
> takes much more, since it's decoded to a microcode MSR access.

It actually seems to flush the trace cache, because Intel figured
out that out of order RDTSC is probably not too useful (which is right) 
and the only way to ensure that on Netburst seems to stop the trace
cache in its track. That can be pretty slow, we're talking 1000+ cycles
here.

Now on the other hand if you only execute it in the slow path
of a lock it might not be that bad (since the machine should
be pretty synchronized at this point anyways), but still it
is probably not something you want to do often.

-Andi
