Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAIQss>; Tue, 9 Jan 2001 11:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130387AbRAIQsi>; Tue, 9 Jan 2001 11:48:38 -0500
Received: from hermes.mixx.net ([212.84.196.2]:40209 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129532AbRAIQs1>;
	Tue, 9 Jan 2001 11:48:27 -0500
Message-ID: <3A5B401F.9D4BCBDF@innominate.de>
Date: Tue, 09 Jan 2001 17:45:19 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>, Christoph Rohland <cr@sap.com>,
        linux-kernel@vger.kernel.org
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com> <Pine.LNX.4.21.0101081621590.21675-100000@duckman.distro.conectiva> <20010109140932.E4284@redhat.com> <qwwhf387p4s.fsf@sap.com> <20010109153119.G9321@redhat.com> <qwwd7dw7mrd.fsf@sap.com> <20010109160511.I9321@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> On Tue, Jan 09, 2001 at 04:45:10PM +0100, Christoph Rohland wrote:
> >
> > AFAIU mlock'ed pages would never get deactivated since the ptes do not
> > get dropped.
> 
> D'oh, right --- so can't you lock a segment just by bumping page_count
> on its pages?

Putting this together with an idea from Linus:

Linus Torvalds wrote:
> On Mon, 8 Jan 2001, Rik van Riel wrote:
> >
> > We need a check in deactivate_page() to prevent the kernel
> > from moving pages from locked shared memory segments to the
> > inactive_dirty list.
> >
> > Christoph?  Linus?
> 
> The only solution I see is something like a "active_immobile" list, and
> add entries to that list whenever "writepage()" returns 1 - instead of
> just moving them to the active list.

Call it 'pinned'... the pinned list would have pages with use count = 2
or more.  A page gets off the pinned list when its use count goes to 1
in put_page.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
