Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130915AbQKJBzl>; Thu, 9 Nov 2000 20:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130451AbQKJBzb>; Thu, 9 Nov 2000 20:55:31 -0500
Received: from smtp2.Mountain.Net ([198.77.1.5]:15004 "EHLO
	nabiki.mountain.net") by vger.kernel.org with ESMTP
	id <S130915AbQKJBzT>; Thu, 9 Nov 2000 20:55:19 -0500
Message-ID: <3A0B5356.4276498C@mountain.net>
Date: Thu, 09 Nov 2000 20:45:58 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11-p1-davem i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: andrewm@uow.edu.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] NE2000
In-Reply-To: <200011082031.XAA20453@ms2.inr.ac.ru> (kuznet@ms2.inr.ac.ru),
			<200011082031.XAA20453@ms2.inr.ac.ru> <200011090127.RAA17691@pizda.ninka.net> <3A0A8236.2166E00@uow.edu.au> <200011091120.DAA27190@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    Date: Thu, 09 Nov 2000 21:53:42 +1100
>    From: Andrew Morton <andrewm@uow.edu.au>
> 
>    "David S. Miller" wrote:
>    > I will compose a patch to fix all this.
> 
>    I've quickly been through just about all of the kernel wrt
>    waitqueues.
> 
> My analysis was in error, BEWARE!
> 
> Being on multiple wait queues at once is just fine.  I verified this
> with Linus tonight.
> 
> The problem case is in mixing TASK_EXCLUSIVE and non-TASK_EXCLUSIVE
> sleeps, that is what can actually cause problems.
> 
> Everything else is fine.  Anyways, the (untested) patch below should
> cure the lock_sock() cases.
> 
> --- ./net/ipv4/af_inet.c.~1~    Tue Oct 24 14:26:18 2000
> +++ ./net/ipv4/af_inet.c        Wed Nov  8 17:28:47 2000
[...]
> --- ./net/ipv4/tcp.c.~1~        Fri Oct  6 15:45:41 2000
> +++ ./net/ipv4/tcp.c    Wed Nov  8 17:35:31 2000

This touches the places where I saw hangs, so I'm testing.
Too soon to have statistics, but with this patch I have
observed no more failures to wake (what I referred  to as
"soft hangs").

I have seen a total I/O lockup, but no info escapes to
indicate its source. No NMI wakeup available, maybe I should
rig a pushbutton.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
