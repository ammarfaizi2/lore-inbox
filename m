Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRIPS6l>; Sun, 16 Sep 2001 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272679AbRIPS6c>; Sun, 16 Sep 2001 14:58:32 -0400
Received: from ns.ithnet.com ([217.64.64.10]:60422 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272677AbRIPS6V>;
	Sun, 16 Sep 2001 14:58:21 -0400
Date: Sun, 16 Sep 2001 20:45:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: gallir@m3d.uib.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010916204528.6fd48f5b.skraw@ithnet.com>
In-Reply-To: <20010916201657.052b0fc0.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva>
	<Pine.LNX.4.33.0109161856380.31311-100000@m3d.uib.es>
	<20010916201657.052b0fc0.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Sep 2001 20:16:57 +0200 Stephan von Krawczynski <skraw@ithnet.com>
wrote:

> On Sun, 16 Sep 2001 19:06:45 +0200 (MET) Ricardo Galli <gallir@m3d.uib.es>
> wrote:
> 
> > On Sun, 16 Sep 2001, Jeremy Zawodny wrote:
> > >
> > > Agreed. I'd be great if there was an option to say "Don't swap out
> > > memory that was allocated by these programs. If you run out of disk
> > > buffers, toss the oldest ones and start re-using them."
> > 
> > More easy though (for cases of listening mp3's and backups): cache pages
> > that were accesed only "once"(*) several seconds ago must be discarded
> > first. It only implies a check against an access counter and a "last
> > accesed"  epoch fields of the page.
> 
> Well, I guess this is everybody's first idea about the problem: make an
initial
> timestamp for knowing how _old_ an allocation really is,

Thinking again about it, I guess I would prefer a FIFO-list of allocated pages.
This would allow to "know" the age simply by its position in the list. You
wouldn't need a timestamp then, and even better it works equally well for
systems with high vm load and low, because you do not deal with absolute time
comparisons, but relative.
That sounds pretty good for me. 
Still the problem with page accesses is not solved, but if you had an idea on
that, you could manipulate the alloc-list simply by moving accessed pages to
the end (one or several positions) of the list which effectively "youngers"
them. So you came around any new members of some structs with simple (and fast)
list operations.
Comments?

Regards,
Stephan


