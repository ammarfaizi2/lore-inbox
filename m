Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316981AbSEaT4s>; Fri, 31 May 2002 15:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSEaT4r>; Fri, 31 May 2002 15:56:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43532 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316981AbSEaT4q>;
	Fri, 31 May 2002 15:56:46 -0400
Message-ID: <3CF7D52C.A8E98B81@zip.com.au>
Date: Fri, 31 May 2002 12:55:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org, Andrey Nekrasov <andy@spylog.ru>
Subject: Re: 2.4.19pre9aa2
In-Reply-To: <20020531051841.GA1172@dualathlon.random> <20020531131306.GA29960@spylog.ru> <20020531184014.GJ1172@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> if it's a userspace-cpu intensive background load, most probably because
> of o1. The dyn-sched (before I integraed o1 that obsoleted it) was very
> good at detecting cpu hogs and to avoid them to disturb interactive
> tasks like ssh-shell, of course o1 also has a sleep_time/sleep_avg
> derived from the dyn-sched idea from Davide, but maybe the constants are
> tuned in a different manner.
> 

I've been running 2.5.16+akpmhacks on my desktop (10 days uptime!).
Two impressions:  It's a bit swappy (it's basically the 2.4.15 VM,
so no surprises there).

But it's also quite markedly sluggish in the user interface when the
machine is compiling stuff.

While running a kernel build (-j0) and leaning on the spacebar in 
an X application I see occasional pauses of tens of keystrokes at
the autorepeat rate.  There was no swapin or out according to vmstat
at the time.   So I'd be suspecting that the interactivity heuristics
in the scheduler aren't working.  Renicing ksoftirqd to -19 doesn't
make any difference.

-
