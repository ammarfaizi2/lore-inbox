Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271918AbRIUIF5>; Fri, 21 Sep 2001 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271858AbRIUIFq>; Fri, 21 Sep 2001 04:05:46 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:38410 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271836AbRIUIFa>; Fri, 21 Sep 2001 04:05:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: broken VM in 2.4.10-pre9
Date: Fri, 21 Sep 2001 10:13:11 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rob Fuller <rfuller@nsisoftware.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33L.0109200903100.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109200903100.19147-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010921080549Z16344-2758+350@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That still doesn't mean we can't _approximate_ aging in
> another way. With linear page aging (3 up, 1 down) the
> page ages of pages referenced only in the page tables
> will still go up, albeit a tad slower than expected.
> 
> It's exponential aging which makes the page age go into
> the other direction, with linear aging things seem to
> work again.
> 
> I've done some experiments recently and found that (with
> reverse mappings) exponential aging is faster when we have
> a small inactive list and linear aging is faster when we
> have a large inactive list.

Have you tried making the down increment larger and the up increment smaller 
when the active list is larger?  This has a natural interpretation: when the 
active list is large the scanning period is longer.  During this longer scan 
period an active page *should* be more likely to have its ref bit set, so it 
gets a smaller boost if it is.  If not we should penalize it more heavily.

There are three points here:

  - small inactive list really means large active list (and vice versa)
  - aging increments need to depend on the size of the active list
  - "exponential" aging may be completely bogus

> This means we need linear page aging with a large inactive
> list in order to let the page ages move into the right
> direction when we run a system without reverse mapping,
> the patch for that was sent to Alan yesterday.

So, the question is, does my suggestion produce essentially the same 
beneficial effect?  And by the way, what are your test cases?  I'd like to 
see if I can your results here.

--
Daniel
