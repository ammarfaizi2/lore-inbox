Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268580AbRGZRu5>; Thu, 26 Jul 2001 13:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268592AbRGZRur>; Thu, 26 Jul 2001 13:50:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49679 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268580AbRGZRui>; Thu, 26 Jul 2001 13:50:38 -0400
Subject: Re: IGMP join/leave time variability
To: torrey.hoffman@myrio.com (Torrey Hoffman)
Date: Thu, 26 Jul 2001 18:51:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), nat.ersoz@myrio.com (Nat Ersoz),
        linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <no.id> from "Torrey Hoffman" at Jul 26, 2001 10:47:05 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PpHy-0004Ch-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> >From this, I infer that there should be _no_ initial delay on sending 
> the IGMP join.  In fact, a quick peek at the source confirms this: 
> (net/ipv4/igmp.c):
> 
> #define IGMP_Initial_Report_Delay               (1*HZ)
> 
> /* IGMP_Initial_Report_Delay is not from IGMP specs!
>  * IGMP specs require to report membership immediately after
>  * joining a group, but we delay the first report by a
>  * small interval. It seems more natural and still does not
>  * contradict to specs provided this delay is small enough.
>  */
> 
> But this "small interval" is actually very noticeable in our application.

I suspect the small interval for the first one should be 1 not 1*HZ. That
would keep a little bit of jitter which is good to avoid the multicast
receive/join group problem

[Lots of clients all running an app listening for multicast packets, one
 packet says 'do xyz on this group' and they all then send joins at the same
 instant]

Alan
