Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272712AbRIPTin>; Sun, 16 Sep 2001 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRIPTie>; Sun, 16 Sep 2001 15:38:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42757 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272712AbRIPTiZ>; Sun, 16 Sep 2001 15:38:25 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: broken VM in 2.4.10-pre9
Date: Sun, 16 Sep 2001 19:37:31 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9o2v1r$85g$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance> <9o1dev$23l$1@penguin.transmeta.com> <1000722338.14005.0.camel@x153.internalnet>
X-Trace: palladium.transmeta.com 1000669100 4710 127.0.0.1 (16 Sep 2001 19:38:20 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 16 Sep 2001 19:38:20 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1000722338.14005.0.camel@x153.internalnet>,
Tonu Samuel  <tonu@please.do.not.remove.this.spam.ee> wrote:
>
>Problem still exists and persists. Not long time ago man from Yahoo
>described well case when change from 2.2.19 to 2.4.x caused performance
>problems. On 2.2.19 everything ran fine. They have MySQL running+did
>backups from disk. After upgrade to 2.4.x MySQL performance felt down on
>backup time. They investigated stuff and found that MySQL daemon gets
>swapped out in the middle of usage to make room for buffers.

Note that if you're using a raw device backup strategy (ie "e2dump" or
similar), that is expected: 2.4.x up until about 2.4.7 gave _much_ too
much preference to the buffer cache. 

That should actually have been fixed in 2.4.8. We used to mark buffer
pages much too active.

> In summary:
>this made both sql and backup double slow. Even increasing memory from
>1G->2G didn't helped. Finally they disabled swap at all and problem
>lost.

You just hid the problem - by disabling swap the buffer cache couldn't
grow without bounds any more, and the proper buffer cache shrinking
couldn't happen.

Try 2.4.8 or later.

>If you do not want to change it back as it was in 2.2.x then would be
>good if this is tunable somehow. 

Tuning for bugs?

What do you want to happen? You want to have an interface like

	echo 0 > /proc/bugs/mm

that makes mm bugs go away?

		Linus
