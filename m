Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbRCCEWu>; Fri, 2 Mar 2001 23:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130271AbRCCEWb>; Fri, 2 Mar 2001 23:22:31 -0500
Received: from server.divms.uiowa.edu ([128.255.28.165]:28179 "EHLO
	server.divms.uiowa.edu") by vger.kernel.org with ESMTP
	id <S130270AbRCCEWX>; Fri, 2 Mar 2001 23:22:23 -0500
From: Doug Siebert <dsiebert@divms.uiowa.edu>
Message-Id: <200103030422.WAA27608@server.divms.uiowa.edu>
Subject: Re: strange nonmonotonic behavior of gettimeoftheday -- seen similar problem on PPC
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 22:22:19 -0600 (CST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
>
>I think it's a math problem in the test code. Try this:
>
[code deleted]
>
>Note that two subsequent calls to gettimeofday() must not return the 
>same time even if your CPU runs infinitely fast. I haven't seen any 
>kernel in the past few years that fails this test.


I find that claim to be pretty ridiculous, I have never seen such a
thing in any standard.  I was writing code allowing the for '='
condition five years ago, because I was assuming that it might live
long enough for this sort of thing to start happening.  Simple defensive
programming (probably smart even if POSIX was to declare this to be
the case)

So then I was I was curious if I could find any systems fast enough to
violate this.  I didn't have to look far, my new laptop with a 600MHz
Pentium III (running kernel 2.2.16, not that it matters) hits the "break"
in your program (i.e., same time from the two gettimeofday() calls) every
single time I run it.  If I add another identical call to gettimeofday()
immediately after the second one, that makes the result of the (now)
third call 1us greater so the code loops as you intended.

What you claim may have been true due to the inability of CPUs to execute
two system calls within a microsecond, but that horse has now left the
barn.  You will need to request a getnanotimeofday() be created if you
want to allow two consecutive calls to always return different values
(modulo SMP systems and ~13 more years of Moore's Law)

-- 
Douglas Siebert
douglas-siebert@uiowa.edu

A computer without Microsoft software is like chocolate cake without ketchup.
