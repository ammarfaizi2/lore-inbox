Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264402AbRFHXYx>; Fri, 8 Jun 2001 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264403AbRFHXYn>; Fri, 8 Jun 2001 19:24:43 -0400
Received: from waste.org ([209.173.204.2]:40542 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S264402AbRFHXY1>;
	Fri, 8 Jun 2001 19:24:27 -0400
Date: Fri, 8 Jun 2001 18:26:57 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] 15 probable security holes in 2.4.5-ac8
In-Reply-To: <200106082134.OAA12792@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.30.0106081808420.16106-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Dawson Engler wrote:

> You can look at this checker as essentially tracking whether the
> information from an untrusted source (e.g., from copy_from_user) can reach
> a trusting sink (e.g., an array index).  The main limiting factor on its
> effectiveness is that we have a very incomplete notion of trusting sinks.
> If anyone has suggestions for other general places where it's dangerous
> to consume bad data, please send me an email.

I wrote something similar to this for userspace (via ld preload). Most of
my checks followed strings around and made sure they were length checked
so as to avoid stack overflows, but I also checked args to open, etc..

In your case, basically all destinations are trusting sinks at some level:
userspace gives you data to put it somewhere. You might want to instead
check that data is passing through functions that 'detaint', by checking
capabilities, etc. I bet that you'll find that something like 90% of code
paths are covered by a few common security checks. And that most of the
remainder could be rewritten to be.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

