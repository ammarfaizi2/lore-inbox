Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275045AbRIYQDM>; Tue, 25 Sep 2001 12:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275062AbRIYQDD>; Tue, 25 Sep 2001 12:03:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:17936 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S275045AbRIYQCu>; Tue, 25 Sep 2001 12:02:50 -0400
Date: Tue, 25 Sep 2001 12:03:12 -0400
Message-Id: <200109251603.f8PG3Cj06561@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux VM design
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20010924182948Z16175-2757+1593@humbolt.nl.linux.org>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010924182948Z16175-2757+1593@humbolt.nl.linux.org> phillips@bonn-fries.net wrote:

| You might want to have a look at this:
| 
|    http://archi.snu.ac.kr/jhkim/seminar/96-004.ps
|    (lrfu algorithm)
| 
| To tell the truth, I don't really see why the frequency information is all
| that useful either.  Rik suggested it's good for streaming IO but we already 
| have effective means of dealing with that that don't rely on any frequency 
| information.

  A count which may actually be useful is a count of how many time the
page has been swapped in (after being swapped out) as a predictor that
it will be a good page to keep. The problem is that there are many
things which help, and I don't think we have the balance quite right
yet. I suspect that there need to be some hysteresis and runtime tuning
over seconds to get optimal performance. Of course systems with really
odd loads will still need to have hand tuning, and the /proc/sys
interface should include sensible ways to do this.

| So the list of reasons why aging is good is looking really short.

  The primary reason on my list is that under some load conditions it
produces much better response. Note that I didn't say all conditions
before you rush to disagree with me. Sometimes people will trade a
little steady state performance to avoid a really bad worst case.

  How the problem is solved really isn't the issue, but responsiveness
is important. Right now it seems some people are reporting that their
loads work better with aging.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
