Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273541AbRIUONB>; Fri, 21 Sep 2001 10:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273542AbRIUOMu>; Fri, 21 Sep 2001 10:12:50 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38918 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S273541AbRIUOMh>; Fri, 21 Sep 2001 10:12:37 -0400
Date: Fri, 21 Sep 2001 10:08:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010921122115.271d1a1e.skraw@ithnet.com>
Message-ID: <Pine.LNX.3.96.1010921095055.28645A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Stephan von Krawczynski wrote:

> On Thu, 20 Sep 2001 23:16:55 -0400 (EDT) Bill Davidsen <davidsen@tmr.com>
> wrote:
> 
> > On Sun, 16 Sep 2001, Stephan von Krawczynski wrote:
	[... snip ...]
> > The problem is that when many things effect the optimal ratio of text,
> > data, buffer and free space a solution which doesn't measure all the
> > important factors will produce sub-optimal results. Your proposal is
> > simple and elegant, but I think it's too simple to produce good results.
> > See my reply to Linus' comments.
> 
> Actually I did not really propose a method of valueing the several pros and
> cons in aging itself, but a very basic idea of how this could be done without
> fiddling around with page->members (like page->age) which always implies you
> have to walk down a whole list to get the full picture in case of urgent need
> for freeable pages.
> If you age something by re-arranging its position in a list you have the
> drawback of list-locking, but the gain of fast finding the best freeable pages
> by simply using the first ones in that list. Even better you can add whatever
> criteria you like to this aging, e.g. you could rearrange to let consecutive
> pages be freed together and so on, all would be pretty easy to achieve, and
> page-struct becomes even smaller.
> The more I think about it the better it sounds.
> Your opinion?

The list is an okay way to determine rank within a class, but I still
think that there is a need for some balance between text, program data,
pages loaded via i/o, perhaps more. My disquiet with the new
implementation is based on a desire to avoid swapping program data to make
room for i/o data (using those terms in a loose way for identification).

I would also like to have time to investigate what happens if the pages
associated with a program load are handled in larger blocks, meta-pages
perhaps, which would at least cause many to be loaded at once on a page
fault, rather than faulting them in one at a time. I have to look at the
code again in my spare time, my last serious visit was 2.2.15 or so,
looking to improve SMP performance.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

