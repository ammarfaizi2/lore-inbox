Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbRGZMNr>; Thu, 26 Jul 2001 08:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267850AbRGZMNh>; Thu, 26 Jul 2001 08:13:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:45577 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267743AbRGZMNW>; Thu, 26 Jul 2001 08:13:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Thu, 26 Jul 2001 14:17:58 +0200
X-Mailer: KMail [version 1.2]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.21.0107260736360.3707-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0107260736360.3707-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <0107261417580M.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 26 July 2001 12:38, Marcelo Tosatti wrote:
> On Thu, 26 Jul 2001, Daniel Phillips wrote:
> > There does seem to be a dangling thread here though - when a
> > process page is unmapped and added to swap cache in try_to_swap_out
> > then later faulted back in, I don't see where we "rescue" the page
> > from the inactive queue.  Maybe I'm just not looking hard enough.
>
> do_swap_page()->lookup_swap_cache()->__find_page_nolock()->SetPageRef
>erenced().
>
> The referenced bit will make page_launder/reclaim_page move the page
> to the active list.

Yes.  And there I set ->age to a known state (START_AGE), so everything 
seems to be in order.

--
Daniel
