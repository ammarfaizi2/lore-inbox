Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265181AbSJWTmr>; Wed, 23 Oct 2002 15:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265182AbSJWTmr>; Wed, 23 Oct 2002 15:42:47 -0400
Received: from mail.ccur.com ([208.248.32.212]:14600 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S265181AbSJWTmp>;
	Wed, 23 Oct 2002 15:42:45 -0400
Message-ID: <3DB6FD0A.74BB3AD0@ccur.com>
Date: Wed, 23 Oct 2002 15:48:26 -0400
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: jim.houston@attbi.com, linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] alternate Posix timer patch
References: <200210230838.g9N8cac00490@linux.local> <3DB6ED10.A81B0429@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Jim Houston wrote:
> I have also looked at the timer index stuff and made a few
> changes.  If it get it working today, I will include it
> also.  My changes mostly revolved around not caring about
> reusing a timer id.  Would you care to comment on why you
> think reuse is bad?
> 
> With out this feature the code is much simpler and does not
> keep around dead trees.
> 
> -g

Hi George,

I assume the rationale is that not reusing the same id immediately helps
catch errors in user code.  Since the id space is global, there
is more chance that one process may be manipulating another processes
timer.  Reusing the same id makes this sort of problem harder to 
catch.

The main reason I changed this in my patch is to avoid the CONFIG
limit on the number of timers.  Since I don't have the fixed array,
I need a way to safely translate a user-space id into a kernel pointer.

Jim Houston Concurrent Computer Corp.
