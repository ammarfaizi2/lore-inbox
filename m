Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWGDINT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWGDINT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWGDINT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:13:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:40338 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751186AbWGDINS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:13:18 -0400
Message-ID: <44AA2301.2030400@sgi.com>
Date: Tue, 04 Jul 2006 10:12:49 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Milton Miller <miltonm@bga.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net>	 <200607040516.k645GFTj014564@sullivan.realtime.net>	 <44AA1D09.7080308@sgi.com> <1151999591.3109.8.camel@laptopd505.fenrus.org>
In-Reply-To: <1151999591.3109.8.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-07-04 at 09:47 +0200, Jes Sorensen wrote:
>> Well yes and no. $#@$#@* hald will do the open/close stupidity a
>> couple of times per second. On a 128 CPU system thats quite a lot of
>> IPI traffic, resulting in measurable noise if you run a benchmark.
>> Remember that the IPIs are synchronous so you have to wait for them to
>> hit across the system :
> 
> can you get hald fixed? That sounds important anyway... stupid userspace
> isn't going to be good no matter what, and the question is how much crap
> we need to do in the kernel to compensate for stupid userspace...
> especially if such userspace is open source and CAN be fixed...

I'd like to, I don't know how feasible it is though :( The distros make
it a priority to run all the GUI stuff that makes Linux look like
windows as much as they can, which includes autodetecting when users
insert their latest audio CD so they can launch the mp3 ripper
automatically ....

Guess the question is, is there a way we can detect when media has been
inserted without doing open/close on the device constantly? It's not
something I have looked at in detail, so I dunno if there's a sensible
way to handle it.

The other part of it is that I do think it's undesirable that a user
space app can cause so much kernel IPI noise by simply doing open/close
on a device.

Anyway, I do agree, we should look at fixing both problems.

Cheers,
Jes
