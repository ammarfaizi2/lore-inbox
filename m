Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRHWPkM>; Thu, 23 Aug 2001 11:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268970AbRHWPjx>; Thu, 23 Aug 2001 11:39:53 -0400
Received: from ns.ithnet.com ([217.64.64.10]:5894 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S268957AbRHWPjq>;
	Thu, 23 Aug 2001 11:39:46 -0400
Date: Thu, 23 Aug 2001 17:39:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, riel@conectiva.com.br
Subject: Re: 2.4.8/2.4.9 problem
Message-Id: <20010823173920.652a175a.skraw@ithnet.com>
In-Reply-To: <20010823144024Z16183-32384+397@humbolt.nl.linux.org>
In-Reply-To: <200108171310.PAA26032@lambik.cc.kuleuven.ac.be>
	<20010820211403Z16263-32383+585@humbolt.nl.linux.org>
	<20010823140444.A14798@spylog.ru>
	<20010823144024Z16183-32384+397@humbolt.nl.linux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001 16:46:54 +0200
Daniel Phillips <phillips@bonn-fries.net> wrote:

> Marcelo already posted a patch to fix this problem (bounce buffer allocation). 
> Look under subject "Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on
> 7899P)" with a correction in his next post.

Aehm, Daniel, just to inform you: Marcelos patch does not solve the problem. I just proofed it here. Is completely the same with or without patch.
I tried another thing which might be interesting. I think your opinion is that page_launder gives you free memory if available when the system runs short. But it does not. I tried the following:
DEF_PRIORITY in vmscan.c set to 0. This should come out as page_launder doing the complete pagelist over in search of free pages. And guess what: it does not find enough to keep the system running. In other words: at least the search strategy in page_launder is broken, too. I can see 500 Megs of Inact_dirty mem, but page_launder cannot find enough clean ones to keep a simple filecopy running.
Any ideas left.

Regards,
Stephan

