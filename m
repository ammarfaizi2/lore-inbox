Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288799AbSAQORb>; Thu, 17 Jan 2002 09:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSAQORV>; Thu, 17 Jan 2002 09:17:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18970 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288799AbSAQORM>; Thu, 17 Jan 2002 09:17:12 -0500
Date: Thu, 17 Jan 2002 15:17:45 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: async buffer flushing reported slowdown (could be a driver issue?)
Message-ID: <20020117151745.H4847@athlon.random>
In-Reply-To: <20020116200459.E835@athlon.random> <056c01c19ed4$f0e77300$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <056c01c19ed4$f0e77300$02c8a8c0@kroptech.com>; from akropel1@rochester.rr.com on Wed, Jan 16, 2002 at 04:29:54PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 04:29:54PM -0500, Adam Kropelin wrote:
> Andrea Arcangeli wrote:
> <snip>
> >I don't have a single bugreport about the current 2.4.18pre2aa2 VM (except 
> >perhaps the bdflush wakeup that seems to be a little too late and that deals to 
> >lower numbers with slow write load etc.., fixable with bdflush tuning). 
> 
> I don't know if this is a reference to the issue I reported under the "Writeout in
> recent kernels..." thread or not. If not, my apologies for clogging up this new
> "discussion".

yes, I was thinking about you report.

> 
> As reported[0] in the above-mentioned thread, the bdflush tuning parameters
> you suggested made no difference in my test case other than slightly adjusting
> the temporal relationship between writeout and file transfer. -aa still performs
> slightly worse than both 2.4.17 stock and -rmap. 2.4.13-ac7 currently beats
> all competitors.

Then can you verify the bandwith you get out of the network card is the
same across 2.4.13-ac7 and all the other kernels you are trying. Also
please check with an hdparm -t the speed you get out of IDE is the same.
This sounds like some driver changed (note that -ac is used to queue
lots of driver updates) and that made the difference. Otherwise if we
wakeup bdflush early enough I don't see why it takes more time.

Andrea
