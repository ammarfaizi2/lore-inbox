Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315452AbSEGXjf>; Tue, 7 May 2002 19:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSEGXje>; Tue, 7 May 2002 19:39:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47352 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315452AbSEGXjd>; Tue, 7 May 2002 19:39:33 -0400
Subject: Re: O(1) scheduler gives big boost to tbench 192
From: Robert Love <rml@tech9.net>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rwhron@earthlink.net, mingo@elte.hu,
        gh@us.ibm.com, linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <20020507154322.F1537@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 07 May 2002 16:39:34 -0700
Message-Id: <1020814775.2084.43.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-07 at 15:43, Mike Kravetz wrote:

> I'm not doing any prefetches in the code (if that is what you are
> talking about).  The code just moves the pipe reader to the same
> CPU as the pipe writer (which is about to block).  Certainly, the
> pipe reader could take advantage of any data written by the writer
> still being in the cache.

Hm, interesting.  When Ingo removed the sync variants of wake_up he did
it believing the load balancer would handle the case.  Apparently, at
least in this case, that assumption was wrong.

I agree with your earlier statement, though - this benchmark may be a
case where it shows up negatively but in general the balancing is
preferred.  I can think of plenty of workloads where that is the case. 
I also wonder if over time the load balancer would end up putting the
tasks on the same CPU.  That is something the quick pipe benchmark would
not show.

> I'm not sure if 'synchronous' is still being passed all the way
> down to try_to_wake_up in your tree (since it was removed in 2.5).
> This is based off a back port of O(1) to 2.4.18 that Robert Love
> did.  The rest of try_to_wake_up (the normal/common path) remains
> the same.

In 2.5 nor the 2.4 backport I did (what is in -ac) I don't think the
sync flag is being passed down since the functionality was removed.  The
functions were rewritten I believe to not have that parameter at all.

It is just for pipes we previously used sync, no?

	Robert Love

