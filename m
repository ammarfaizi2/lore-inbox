Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280401AbRJaSgm>; Wed, 31 Oct 2001 13:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280400AbRJaSgc>; Wed, 31 Oct 2001 13:36:32 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:51210 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280405AbRJaSgY>; Wed, 31 Oct 2001 13:36:24 -0500
Date: Wed, 31 Oct 2001 19:35:47 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.30.0110311902410.29481-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.30.0110311926360.29572-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to set INITIAL_JIFFIES to zero before posting the patch.

Testing with high INITIAL_JIFFIES values unfortunately still discloses
instability after the wraparound even for an otherwise unpatched kernel.

I also forgot to mention that the introduced jiffies_high variable is
useless on 64 bit systems, so we might #ifdef it out there.

Tim


On Wed, 31 Oct 2001, Tim Schmielau wrote:

[parts of patch snipped]

> --- kernel/timer.c.orig	Wed Oct 31 17:24:36 2001
> +++ kernel/timer.c	Wed Oct 31 18:38:47 2001
> @@ -65,7 +65,9 @@
>
>  extern int do_setitimer(int, struct itimerval *, struct itimerval *);
>
> -unsigned long volatile jiffies;
> +#define INITIAL_JIFFIES 0xFFFFD000ul
> +unsigned long volatile jiffies = INITIAL_JIFFIES;
> +unsigned long volatile jiffies_high, jiffies_high_shadow;
>

This of course needs to be
   #define INITIAL_JIFFIES 0
for correct uptime display

