Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131365AbRCKHxN>; Sun, 11 Mar 2001 02:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131366AbRCKHxD>; Sun, 11 Mar 2001 02:53:03 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:59665 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131365AbRCKHwt>;
	Sun, 11 Mar 2001 02:52:49 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: mingo@elte.hu
cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog 
In-Reply-To: Your message of "Sun, 11 Mar 2001 08:44:24 BST."
             <Pine.LNX.4.30.0103110841110.987-100000@elte.hu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Mar 2001 18:52:02 +1100
Message-ID: <15829.984297122@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Mar 2001 08:44:24 +0100 (CET), 
Ingo Molnar <mingo@elte.hu> wrote:
>Andrew,
>
>your patch looks too complex, and doesnt cover the case of the serial
>driver deadlocking. Why not add a "touch_nmi_watchdog_counter()" function
>that just changes last_irq_sums instead of adding locking? This way
>deadlocks will be caught in the serial code too. (because touch_nmi() will
>only "postpone" the NMI watchdog lockup event, not disable it.)

kdb has to completely disable the nmi counter while it is in control.
All interrupts are disabled, all but one cpus are spinning, the control
cpu does busy wait while it polls the input devices.  With that model
there is no alternative to a complete disable.

