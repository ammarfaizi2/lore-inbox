Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSBGPxC>; Thu, 7 Feb 2002 10:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSBGPww>; Thu, 7 Feb 2002 10:52:52 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:26768 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S287193AbSBGPwm>; Thu, 7 Feb 2002 10:52:42 -0500
Message-ID: <3C62A47C.3BA52818@nortelnetworks.com>
Date: Thu, 07 Feb 2002 10:59:56 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <3C6192A5.911D5B4F@nortelnetworks.com.suse.lists.linux.kernel> <p73it9a9mvc.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Chris Friesen <cfriesen@nortelnetworks.com> writes:
> 
> > I've been looking around in the 2.4 networking stack, and I noticed that when
> > the tulip (and no doubt many other) driver cannot put any more outgoing packets
> > on the queue, it calls netif_stop_queue().  Then, in dev_queue_xmit() we check
> > this flag by calling netif_queue_stopped().  My concern is that if this flag is
> > true, we return -ENETDOWN.  Is this really the proper return code for this? If
> > anything, the network is too active.  It seems to me that it would make more
> > sense to have some kind of congestion return code rather than claiming that the
> > network is down.
> 
> The ENETDOWN path you're seeing only applies to queueless devices (like
> loopback or a tunnel device). These should only set the queued stopped
> flag when something is terrible wrong.
> 
> All real network devices have a queue and go through the qdisc.

Okay, I must be missing something, so can you enlighten me?  I can't figure out
where the qdisc is attached to the ethernet device.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
