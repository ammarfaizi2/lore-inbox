Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRCKIQf>; Sun, 11 Mar 2001 03:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131379AbRCKIQZ>; Sun, 11 Mar 2001 03:16:25 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:16876 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131376AbRCKIQJ>; Sun, 11 Mar 2001 03:16:09 -0500
Message-ID: <3AAB3461.D0AB56F9@uow.edu.au>
Date: Sun, 11 Mar 2001 19:16:33 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog
In-Reply-To: Your message of "Sun, 11 Mar 2001 08:53:40 BST."
	             <Pine.LNX.4.30.0103110852160.1152-100000@elte.hu> <15973.984297609@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 11 Mar 2001 08:53:40 +0100 (CET),
> Ingo Molnar <mingo@elte.hu> wrote:
> >it sure has an alternative. The 'cpus spinning' code calls touch_nmi()
> >within the busy loop, the polling code on the control CPU too. This is
> >sure more robust and catches lockup bugs in kdb too ...
> 
> Works for me.  It even makes kdb simpler.

humm...

OK, this seems doable in the case of serial console.
For CONFIG_LP_CONSOLE (which has the same problem) it
looks like we can just call touch_nmi() in lp_console_write().

I'll see what Tim has to say.

-
