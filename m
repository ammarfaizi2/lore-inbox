Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWJMXck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWJMXck (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWJMXck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:32:40 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:30681 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751983AbWJMXcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:32:39 -0400
Date: Sat, 14 Oct 2006 01:32:38 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: John Richard Moser <nigelenki@comcast.net>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Can context switches be faster?
Message-ID: <20061013233238.GA6038@rhlx01.fht-esslingen.de>
References: <452E62F8.5010402@comcast.net> <452E9E47.8070306@nortel.com> <452EA441.6070703@comcast.net> <452EA700.9060009@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452EA700.9060009@goop.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 01:35:12PM -0700, Jeremy Fitzhardinge wrote:
> John Richard Moser wrote:
> >That's a load more descriptive :D
> >
> >0.890 uS, 0.556uS/cycle, that's barely 2 cycles you know.  (Pentium M)
> >PPC performs similarly, 1 cycle should be about 1uS.
> >  
> 
> No, you're a factor of 1000 off - these numbers show the context switch 
> is around 1600-75000 cycles.  And that doesn't really tell the whole 
> story: if caches/TLB get flushed on context switch, then the newly 
> switched-to task will bear the cost of having cold caches, which isn't 
> visible in the raw context switch time.
> 
> But modern x86 processors have a very quick context switch time, and I 
> don't think there's much room for improvement aside from 
> micro-optimisations (though that might change if the architecture grows 
> a way to avoid flushing the TLB on switch).

OK, so since we've now amply worked out in this thread that TLB/cache flushing
is a real problem for context switching management, would it be possible to
smartly reorder processes on the runqueue (probably works best with many active
processes with the same/similar priority on the runqueue!) to minimize
TLB flushing needs due to less mm context differences of adjacently scheduled
processes?
(i.e. don't immediately switch from user process 1 to user process 2 and
back to 1 again, but always try to sort some kernel threads in between
to avoid excessive TLB flushing)

See also my new posting about this at
http://bhhdoa.org.au/pipermail/ck/2006-October/006442.html

Andreas Mohr
