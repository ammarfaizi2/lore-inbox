Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272338AbRHXWWe>; Fri, 24 Aug 2001 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272340AbRHXWWY>; Fri, 24 Aug 2001 18:22:24 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:37896 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272339AbRHXWWP>; Fri, 24 Aug 2001 18:22:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Sat, 25 Aug 2001 00:29:03 +0200
X-Mailer: KMail [version 1.3.1]
Cc: "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824222226Z16116-32383+1242@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2001 09:02 pm, Rik van Riel wrote:
> On Fri, 24 Aug 2001, Roger Larsson wrote:
> 
> > Not having the patch gives you another effect - disk arm is
> > moving from track to track in a furiously tempo...
> 
> Fully agreed, but remember that when you reach the point
> where the readahead windows are pushing each other out
> you'll be off even worse.
> 
> I guess in the long run we should have automatic collapse
> of the readahead window when we find that readahead window
> thrashing is going on, in the short term I think it is
> enough to have the maximum readahead size tunable in /proc,
> like what is happening in the -ac kernels.

Yes, and the most effective way to detect that the readahead window is too 
high is by keeping a history of recently evicted pages.  When we find 
ourselves re-reading pages that were evicted before ever being used we know 
exactly what the problem is.

--
Daniel
