Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270971AbRHOASX>; Tue, 14 Aug 2001 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270970AbRHOASN>; Tue, 14 Aug 2001 20:18:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59013 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270964AbRHOAR7>;
	Tue, 14 Aug 2001 20:17:59 -0400
Date: Tue, 14 Aug 2001 17:16:09 -0700 (PDT)
Message-Id: <20010814.171609.75760869.davem@redhat.com>
To: andrea@suse.de
Cc: thockin@sun.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010815021110.F4304@athlon.random>
In-Reply-To: <20010814.163804.66057702.davem@redhat.com>
	<3B79BA07.B57634FD@sun.com>
	<20010815021110.F4304@athlon.random>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 15 Aug 2001 02:11:10 +0200

   On Tue, Aug 14, 2001 at 04:53:43PM -0700, Tim Hockin wrote:
   > -	if (nfds > NR_OPEN)
   > +	if (nfds > current->rlim[RLIMIT_NOFILE].rlim_cur)
   
   Here SuS speaks about OPEN_MAX, not sure if OPEN_MAX corresponds to the
   current ulimit or to the absolute maximum (to me it sounds more like our
   NR_OPEN).

Right, and our equivalent is "NR_OPEN".

Ok, I think I see what you and Tim are trying to say.
I'm thinking in a select() minded way which is why I didn't
understand :-)

Yeah, the check can be removed, but anyone who cares about
performance won't pass in huge arrays of -1 entries if only
the low few pollfd entries are actually useful.

Later,
David S. Miller
davem@redhat.com


