Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263247AbTCSXjw>; Wed, 19 Mar 2003 18:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263250AbTCSXjw>; Wed, 19 Mar 2003 18:39:52 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:21261
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S263247AbTCSXju>; Wed, 19 Mar 2003 18:39:50 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DEF@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: Linux-2.4.20 modem control
Date: Wed, 19 Mar 2003 15:50:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 2:32 PM, Richard B. Johnson wrote:
> On Wed, 19 Mar 2003, Ed Vance wrote:
> [SNIPPED...]
> 
> > Hi Richard,
> >
> > The following patch to serial.c in 2.4.20 is a brute-force addition
> > of a hang-up delay of 0.5 sec just before close returns to the user,
> > if the hupcl flag is set. Please try this to determine if there are
> > any other issues with the remote login. If it works, I'll write a
> > better patch that does not duplicate other delays, etc.
> >
> > Cheers,
> > Ed
> >
> 
> Well, it's the "right church, but wrong pew". As soon as anything
> closes STDIO_FILENO, **bang** the modem hangs up. NotGood(tm)!
> So as long as I just execute the shell which was exec'ed ...
> getty...rlogin...bash never called close. However, `ls` on my
> machine is `color-ls` when it calls exit(0)... well you get
> the idea! I can log in, but can't actually execute anything that
> terminates, closing STDIO_FILENO...
> 
> 
Hi Richard,

Bummer! Do you think that each of those events was a "last close" 
of the port? Doesn't bash hold the port open while the `color-ls` 
runs? 

Since the path only delays (doesn't change modem control), these 
closes must have been hidden by quick reopens. Does the unmodified 
agetty set the baud rate to zero to hangup, or was that your change? 
I was thinking that I could move the delay to the code that 
disconnects when baud rate zero is set. 

your thoughts?

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
