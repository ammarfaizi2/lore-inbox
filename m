Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271664AbRH0HKK>; Mon, 27 Aug 2001 03:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271663AbRH0HKB>; Mon, 27 Aug 2001 03:10:01 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:21777 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S271658AbRH0HJz>; Mon, 27 Aug 2001 03:09:55 -0400
Message-ID: <3B89F1FC.40F747D4@idb.hist.no>
Date: Mon, 27 Aug 2001 09:08:44 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <20010824222226Z16116-32383+1242@humbolt.nl.linux.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On August 24, 2001 09:02 pm, Rik van Riel wrote:
> > I guess in the long run we should have automatic collapse
> > of the readahead window when we find that readahead window
> > thrashing is going on, in the short term I think it is
> > enough to have the maximum readahead size tunable in /proc,
> > like what is happening in the -ac kernels.
> 
> Yes, and the most effective way to detect that the readahead window is too
> high is by keeping a history of recently evicted pages.  When we find
> ourselves re-reading pages that were evicted before ever being used we know
> exactly what the problem is.

Counting how much we are reading ahead and comparing with total RAM
(or total cache) might also be an idea.  We may then read ahead
a lot for those who runs a handful of processes, and
do smaller readahead for those that runs thousands of processes.

Helge Hafting
