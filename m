Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287636AbRLaU1m>; Mon, 31 Dec 2001 15:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287640AbRLaU1c>; Mon, 31 Dec 2001 15:27:32 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20742 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287639AbRLaU10>; Mon, 31 Dec 2001 15:27:26 -0500
Message-ID: <3C30C951.DC96E2B6@zip.com.au>
Date: Mon, 31 Dec 2001 12:23:45 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: alad@hss.hns.com, linux-kernel@vger.kernel.org
Subject: Re: locked page handling
In-Reply-To: <65256B33.0039476C.00@sandesh.hss.hns.com> <3C30BE70.6E5E95CE@zip.com.au>,
		<3C30BE70.6E5E95CE@zip.com.au> <E16L8aA-0000at-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> I think we want the pages in process of being written to live on a separate
> list.  Pages can be pulled of that list by a separate thread, or perhaps in
> the IO completion interrupt (opportunistically, if the list lock is available)
> meaning kswapd would block less and waste less time examining locked pages.

Yes, possibly.  Also the unlocked pages which have locked buffers,
which tends to be 99% of the pages...

But then again:

- I've never seen this code disgrace itself in profiler output unless
  it's in already-hopelessly-confused mode.

- Personally, I wouldn't recommend anything like that without having
  previously done a deep analysis of the existing implementation's
  dynamics and behaviour.  Something which would take a week (or two,
  given the way the elevator analysis is shaping up).

  This activity is something which I have never countenanced because
  the code has been under continual futzing for a year.

-
