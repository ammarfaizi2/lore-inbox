Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbQL2SbV>; Fri, 29 Dec 2000 13:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131772AbQL2SbL>; Fri, 29 Dec 2000 13:31:11 -0500
Received: from hermes.mixx.net ([212.84.196.2]:43012 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130061AbQL2Sav>;
	Fri, 29 Dec 2000 13:30:51 -0500
Message-ID: <3A4CD0A9.3F8F6D16@innominate.de>
Date: Fri, 29 Dec 2000 18:58:01 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.10.10012281125260.12260-100000@penguin.transmeta.com> <267620000.978105801@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Thursday, December 28, 2000 11:29:01 AM -0800 Linus Torvalds
> <torvalds@transmeta.com> wrote:
> [ skipping io on the first walk in page_launder ]
> >
> > There are some arguments for starting the writeout early, but there are
> > tons of arguments against it too (the main one being "avoid doing IO if
> > you can do so"), so your patch is probably fine. In the end, the
> > performance characteristics are what matters. Does the patch make for
> > smoother behaviour and better performance?
> 
> My dbench speeds have always varied from run to run, but the average speed
> went up about 9% with the anon space mapping patch and the page_launder
> change.  I could not find much difference in a pure test13-pre4, probably
> because dbench doesn't generate much swap on my machine.  I'll do more
> tests when I get back on Monday night.
> 
> Daniel, sounds like dbench varies less on your machine, what did the patch
> do for you?
> 
> BTW, the last anon space mapping patch I sent also works on test13-pre5.
> The block_truncate_page fix does help my patch, since I have bdflush
> locking pages ( thanks Marcelo )

Yes it does, but the little additional patch you posted no longer
applies.  Your patch is suffering badly under pre5 here, reducing
throughput from around 10 MB/sec to 5-6 MB/sec, and highly variable.  If
you're not seeing this you should probably try to get a few others to
run it.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
