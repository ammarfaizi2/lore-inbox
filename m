Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbRCFXrj>; Tue, 6 Mar 2001 18:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRCFXra>; Tue, 6 Mar 2001 18:47:30 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:19592 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129723AbRCFXrW>; Tue, 6 Mar 2001 18:47:22 -0500
Message-ID: <3AA576C7.B00DF382@uow.edu.au>
Date: Tue, 06 Mar 2001 23:46:15 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Patch submissions
In-Reply-To: <Pine.LNX.4.33.0103061422030.1409-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 6 Mar 2001, Alan Cox wrote:
> 
> > I'm getting a notable increase in people sending me patches that
> > do major things and should be 2.5 stuff. Please if you want to
> > rewrite the VM completely, redesign the scsi layer and the like
> > wait until 2.5.
> 
> VM folks can post their patches to linux-mm@kvack.org, where
> we can play with things until 2.5 is forked.
> 

With respect, Rik.  You haven't finished the 2.4 VM yet.

It needs better design description.  I've been reading
through it lately, and in some parts it is very, very
hard to go backwards from the implementation to the
designer's intent.

Let's take just one line:

        count = inactive_shortage() + free_shortage();

That expands to, approximately, sometimes:

inactive_shortage():
        freepages.high + inactive_target - nr_free_pages() -
		nr_inactive_clean_pages() - nr_inactive_dirty_pages;

plus free_shortage():

	(freepages.high + inactive_target / 3) -
              (nr_free_pages() + nr_inactive_clean_pages())

IOW:

	2 * freepages.high + 1.33*(min((memory_pressure >> INACTIVE_SHIFT),
                (num_physpages / 4))) - 2 * nr_free_pages() -
        2 * nr_inactive_clean_pages() - nr_inactive_dirty_pages

That's not a thing which just leaps out at me and shouts "ah-ha!"  :)

Across the lifetime of 2.4, other people are going to need to
understand this stuff.  To be able to analyse and even predict how the
VM dynamics will change with varying tuning, varying workload
and varying platform characteristics.

There *is* a fair quantity of good design description in there,
but there are gaps.

Could you please take the time to raise a commentary patch
which describes the underlying design intent?  I'd
strongly recommend *against* some offstream document (it
doesn't get updated) or API documentation (usually lame and useless).
Inline description is much more useful and better maintained.

Thanks

-
