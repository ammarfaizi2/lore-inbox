Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKXMnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKXMnk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVKXMnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:43:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19421 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750714AbVKXMnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:43:39 -0500
Date: Thu, 24 Nov 2005 04:43:13 -0800
From: Paul Jackson <pj@sgi.com>
To: Marcel Zalmanovici <MARCEL@il.ibm.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, mulix@mulix.org
Subject: Re: Inconsistent timing results of multithreaded program on an SMP
 machine.
Message-Id: <20051124044313.6259092d.pj@sgi.com>
In-Reply-To: <OF7B1C41C0.7F24B72C-ONC22570C3.003663BE-C22570C3.0036F687@il.ibm.com>
References: <200511242041.00586.kernel@kolivas.org>
	<OF7B1C41C0.7F24B72C-ONC22570C3.003663BE-C22570C3.0036F687@il.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel,

I condensed the results you attached to another reply earlier
today on this query into a little table, showing for each of
8 threads, in order, which of the two CPUs 0 or 1 they finished
on, and the real (elapsed) time:

    0 0 0 1 0 1 0 0 14.49
    1 1 0 0 1 1 1 1 15.18
    0 1 0 1 0 0 1 1 14.64
    1 1 0 0 0 1 0 0 14.65
    0 0 0 1 1 1 1 1 14.61
    1 1 0 0 1 1 1 1 18.89
    0 1 0 0 1 1 0 1 14.62
    1 1 0 1 0 0 1 1 14.51
    0 0 1 1 0 0 0 1 14.54
    0 1 0 1 1 1 1 1 14.73
    0 1 0 1 0 1 1 1 14.78
    0 1 1 1 0 0 0 1 18.90
    0 0 0 1 1 1 0 1 14.57
    1 1 0 1 0 1 0 0 17.07
    0 1 1 1 0 1 1 1 14.56
    0 1 0 0 1 1 0 0 14.49
    0 1 1 1 0 1 0 0 17.80
    0 1 0 1 1 1 1 1 14.62
    0 1 0 1 0 1 0 0 19.55
    0 1 0 1 0 0 1 1 19.57

I notice that the deviation of the faster runs is very low,
with the best 13 of 20 runs all finishing in times between
14.49 and 14.78 seconds, but the slower runs have a higher
deviation, with the worst 7 of 20 runs finishing in times
between 15.18 and 19.57 seconds, a wider range of times.

That is, the best 13 runs differ in time by only 0.29 secs,
but the worst 7 runs differ in time by 4.39 seconds, a much
wider range.

I agree with you that I don't see a pattern in which CPU
the threads finished on or any relation between that and
the real times.

However this skewed distribution of times does suggest that
something is intruding - something that only happens perhaps
a third of the time is running or making things worse.

What I might suggest next is that you look for nice ways
that fit on a page or less and condense out all nonessential
detail to present these timing results.  People have a
tendency to dump a big attachment of raw output data onto
email lists, which almost no one ever reads closely,
especially if it is in some homebrew format perculiar to
that particular inquiry.  Time spent cleaning up the show
of data is often well spent, because then others might
actually look at the data and recognize a pattern that
they have something useful to say about.

Then after you have it collapsed to a nice table format,
go even the next step and describe in words any patterns
that are apparent, which will catch another chunk of
potential readers, who will skim over a data table without
really thinking.  Then fine tune that wording, until it
would be understood by someone, the first time they heard
it, standing at the coffee urn, discussing sports.  Often
times, by the time you get that far, you will have an
'aha' moment, leading to further experiments and insights,
before you even get a chance to ask someone else.

Question - how do you know its the multithreading that
is causing the variance?  Try this with single threads,
just one per cpu, with or without hyperthread perhaps.
Never assume that you know the cause of something until
you have bracketed the tests with demonstrations that
all else being equal (or as close as can be) just adding
or removing the one suspect element causes the observed
affect to come and go.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
