Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRIUKVo>; Fri, 21 Sep 2001 06:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273229AbRIUKVe>; Fri, 21 Sep 2001 06:21:34 -0400
Received: from ns.ithnet.com ([217.64.64.10]:32270 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S273213AbRIUKV0>;
	Fri, 21 Sep 2001 06:21:26 -0400
Date: Fri, 21 Sep 2001 12:21:15 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-Id: <20010921122115.271d1a1e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
In-Reply-To: <20010916204528.6fd48f5b.skraw@ithnet.com>
	<Pine.LNX.3.96.1010920231251.26679B-100000@gatekeeper.tmr.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 23:16:55 -0400 (EDT) Bill Davidsen <davidsen@tmr.com>
wrote:

> On Sun, 16 Sep 2001, Stephan von Krawczynski wrote:
> 
> 
> > Thinking again about it, I guess I would prefer a FIFO-list of allocated
pages.
> > This would allow to "know" the age simply by its position in the list. You
> > wouldn't need a timestamp then, and even better it works equally well for
> > systems with high vm load and low, because you do not deal with absolute
time
> > comparisons, but relative.
> > That sounds pretty good for me. 
> 
> The problem is that when many things effect the optimal ratio of text,
> data, buffer and free space a solution which doesn't measure all the
> important factors will produce sub-optimal results. Your proposal is
> simple and elegant, but I think it's too simple to produce good results.
> See my reply to Linus' comments.

Actually I did not really propose a method of valueing the several pros and
cons in aging itself, but a very basic idea of how this could be done without
fiddling around with page->members (like page->age) which always implies you
have to walk down a whole list to get the full picture in case of urgent need
for freeable pages.
If you age something by re-arranging its position in a list you have the
drawback of list-locking, but the gain of fast finding the best freeable pages
by simply using the first ones in that list. Even better you can add whatever
criteria you like to this aging, e.g. you could rearrange to let consecutive
pages be freed together and so on, all would be pretty easy to achieve, and
page-struct becomes even smaller.
The more I think about it the better it sounds.
Your opinion?

Regards,
Stephan

