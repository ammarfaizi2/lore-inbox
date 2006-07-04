Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWGDNGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGDNGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWGDNGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:06:46 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:54933 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932149AbWGDNGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:06:44 -0400
Date: Tue, 4 Jul 2006 15:02:35 +0200
To: Jes Sorensen <jes@sgi.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Milton Miller <miltonm@bga.com>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] reduce IPI noise due to /dev/cdrom open/close
Message-ID: <20060704130235.GD11458@aitel.hist.no>
References: <yq0mzbqhfdp.fsf@jaguar.mkp.net> <200607040516.k645GFTj014564@sullivan.realtime.net> <44AA1D09.7080308@sgi.com> <1151999591.3109.8.camel@laptopd505.fenrus.org> <44AA2301.2030400@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AA2301.2030400@sgi.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 10:12:49AM +0200, Jes Sorensen wrote:
> Arjan van de Ven wrote:
> > On Tue, 2006-07-04 at 09:47 +0200, Jes Sorensen wrote:
> >> Well yes and no. $#@$#@* hald will do the open/close stupidity a
> >> couple of times per second. On a 128 CPU system thats quite a lot of
> >> IPI traffic, resulting in measurable noise if you run a benchmark.
> >> Remember that the IPIs are synchronous so you have to wait for them to
> >> hit across the system :
> > 
> > can you get hald fixed? That sounds important anyway... stupid userspace
> > isn't going to be good no matter what, and the question is how much crap
> > we need to do in the kernel to compensate for stupid userspace...
> > especially if such userspace is open source and CAN be fixed...
> 
> I'd like to, I don't know how feasible it is though :( The distros make
> it a priority to run all the GUI stuff that makes Linux look like
> windows as much as they can, which includes autodetecting when users
> insert their latest audio CD so they can launch the mp3 ripper
> automatically ....
> 
> Guess the question is, is there a way we can detect when media has been
> inserted without doing open/close on the device constantly? It's not
> something I have looked at in detail, so I dunno if there's a sensible
> way to handle it.

I always believed that it was possible, but not on all cdroms.
If this was supported, people with lots of cpus could be told to
get some of the sane cdroms for their big boxes.

One solution is to have the kernel do this kind of polling itself,
in the device drivers for removeable media.
Then it can simply notify userspace when something happens,
and userspace can decide to play music, mount a fs, or whatever
people want to happen.

> 
> The other part of it is that I do think it's undesirable that a user
> space app can cause so much kernel IPI noise by simply doing open/close
> on a device.

Sure, a DOS waiting to happen.  If they can poll twice a second, whats
to stop them from trying to poll a hundred times a second, or in
a busy loop?

Helge Hafting
