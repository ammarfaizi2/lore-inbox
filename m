Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbRIFNKj>; Thu, 6 Sep 2001 09:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270634AbRIFNK3>; Thu, 6 Sep 2001 09:10:29 -0400
Received: from ns.ithnet.com ([217.64.64.10]:32004 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S270273AbRIFNKM>;
	Thu, 6 Sep 2001 09:10:12 -0400
Date: Thu, 6 Sep 2001 15:10:15 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: riel@conectiva.com.br, jaharkes@cs.cmu.edu, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-Id: <20010906151015.69d2afb2.skraw@ithnet.com>
In-Reply-To: <20010906122459Z16031-32383+3771@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33L.0109060851020.31200-100000@imladris.rielhome.conectiva>
	<20010906122459Z16031-32383+3771@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001 14:31:32 +0200 Daniel Phillips <phillips@bonn-fries.net>
wrote:

> On September 6, 2001 01:52 pm, Rik van Riel wrote:
> > On Tue, 4 Sep 2001, Jan Harkes wrote:
> > 
> > > To get back on the thread I jumped into, I totally agree with Linus
> > > that writeout should be as soon as possible.
> > 
> > Nice way to destroy read performance.
> 
> Blindly delaying all the writes in the name of better read performance isn't 
> the right idea either.  Perhaps we should have a good think about some 
> sensible mechanism for balancing reads against writes.

I guess I have the real-world proof for that:
Yesterday I mastered a CD (around 700 MB) and burned it, I left the equipment
to get some food and sleep (sometimes needed :-). During this time the machine
acts as nfs-server and gets about 3 GB of data written to it. Coming back today
I recognise that deleting the CD image made yesterday frees up about 500 MB of
physical mem (free mem was very low before). It was obviously held 24 hours for
no reason, and _not_ (as one would expect) exchanged against the nfs-data. This
means the caches were full with _old_ data and explains why nfs performance has
remarkably dropped since 2.2. There is too few mem around to get good
performance (no matter if read or write). Obviously aging did not work at all,
there was not a single hit on these (CD image) pages during 24 hours, compared
to lots on the nfs-data. Even if the nfs-data would only have one single hit,
the old CD image should have been removed, because it is inactive and _older_.

> > As DaveM noted so
> > nicely in his reverse mapping patch (at the end of the
> > 2.3 series), dirty pages get moved to the laundry list
> > and the washing machine will deal with them when we have
> > a full load.
> > 
> > Lets face it, spinning the washing machine is expensive
> > and running less than a full load makes things inefficient ;)

I guess this is what people writing w*ndows screen blankers thought, too ;-)

Sorry for this comment, couldn't resist :-)

Stephan


