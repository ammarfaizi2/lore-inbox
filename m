Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131366AbRCKHzd>; Sun, 11 Mar 2001 02:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131367AbRCKHzX>; Sun, 11 Mar 2001 02:55:23 -0500
Received: from chiara.elte.hu ([157.181.150.200]:20237 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131366AbRCKHzS>;
	Sun, 11 Mar 2001 02:55:18 -0500
Date: Sun, 11 Mar 2001 08:53:40 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog 
In-Reply-To: <15829.984297122@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.30.0103110852160.1152-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Mar 2001, Keith Owens wrote:

> kdb has to completely disable the nmi counter while it is in control.
> All interrupts are disabled, all but one cpus are spinning, the
> control cpu does busy wait while it polls the input devices.  With
> that model there is no alternative to a complete disable.

it sure has an alternative. The 'cpus spinning' code calls touch_nmi()
within the busy loop, the polling code on the control CPU too. This is
sure more robust and catches lockup bugs in kdb too ...

	Ingo


