Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271878AbRH1SBN>; Tue, 28 Aug 2001 14:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269229AbRH1SBD>; Tue, 28 Aug 2001 14:01:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:47369 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267650AbRH1SAy>; Tue, 28 Aug 2001 14:00:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: page_launder() on 2.4.9/10 issue
Date: Tue, 28 Aug 2001 20:07:02 +0200
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0108272356100.7602-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108272356100.7602-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010828180108Z16193-32383+2058@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 28, 2001 05:36 am, Marcelo Tosatti wrote:
> Linus,
> 
> I just noticed that the new page_launder() logic has a big bad problem.
> 
> The window to find and free previously written out pages by page_launder()
> is the amount of writeable pages on the inactive dirty list.
> 
> We'll keep writing out dirty pages (as long as they are available) even if
> have a ton of cleaned pages: its just that we don't see them because we
> scan a small piece of the inactive dirty list each time.
> 
> That obviously did not happen with the full scan behaviour.
> 
> With asynchronous i_dirty->i_clean movement (moving a cleaned page to the
> clean list at the IO completion handler. Please don't consider that for
> 2.4 :)) this would not happen, too.

Or we could have parallel lists for dirty and clean.

--
Daniel
