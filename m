Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267860AbRGZMIh>; Thu, 26 Jul 2001 08:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267825AbRGZMIa>; Thu, 26 Jul 2001 08:08:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58887 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267859AbRGZMIT>; Thu, 26 Jul 2001 08:08:19 -0400
Date: Thu, 26 Jul 2001 07:38:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <0107261406290L.00907@starship>
Message-ID: <Pine.LNX.4.21.0107260736360.3707-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Thu, 26 Jul 2001, Daniel Phillips wrote:

> There does seem to be a dangling thread here though - when a process 
> page is unmapped and added to swap cache in try_to_swap_out then later 
> faulted back in, I don't see where we "rescue" the page from the 
> inactive queue.  Maybe I'm just not looking hard enough.

do_swap_page()->lookup_swap_cache()->__find_page_nolock()->SetPageReferenced().

The referenced bit will make page_launder/reclaim_page move the page to
the active list.



