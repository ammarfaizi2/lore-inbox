Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269828AbTGOWyw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269833AbTGOWyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:54:52 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:27881 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S269828AbTGOWyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:54:50 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] N1int for interactivity
Date: Wed, 16 Jul 2003 09:12:05 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>
References: <200307151355.23586.kernel@kolivas.org> <1058282608.626.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1058282608.626.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307160912.05833.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 01:23, Felipe Alfaro Solana wrote:
> On Tue, 2003-07-15 at 05:55, Con Kolivas wrote:
> > I've modified Mike Galbraith's nanosleep work for greater resolution to
> > help the interactivity estimator work I've done in the O*int patches.
> > This patch applies to any kernel patched up to the latest
> > patch-O5int-0307150857 which applies on top of 2.5.75-mm1.
> >
> > Please test and comment, and advise what further changes you think are
> > appropriate or necessary, including other archs. I've preserved Mike's
> > code unchanged wherever possible. It works well for me, but n=1 does not
> > a good sample population make.
> >
> > The patch-N1int-0307151249 is available here:
> > http://kernel.kolivas.org/2.5
>
> I can still starve XMMS on 2.5.75-mm1 + patch-O5int-0307150857 +
> patch-N1int-0307152010:
>
> 1. Log on to KDE
> 2. Launch Konqueror
> 3. Launch XMMS and make it play
> 4. Move Konqueror window all over the desktop
>
> Step 4 will make XMMS starve for a few seconds. Also, under heavy load
> (while true; do a=2; done), moving the Konqueror window like crazy makes
> X go jerky after a few seconds. If I quit moving windows around, after a
> few other seconds, X returns to normal/smooth behavior.

I was more concerned to see if the N1 patch added anything to the current 
behaviour, but that is abandoned work now so don't worry. I can address these 
further issues incrementally if you're willing to test them. My test boxes 
have been tamed but I need and appreciate greatly your testing.

> I can fix the starvation/smoothness by setting:
>
> #define PRIO_BONUS_RATIO        45
> #define INTERACTIVE_DELTA       4
> #define MAX_SLEEP_AVG           (HZ)
> #define STARVATION_LIMIT        (HZ)
>
> For me, 2.6.0-test1 stock scheduler plus above changes makes the most
> user-friendly desktop I've ever seen.

With a max sleep avg of just one second you'll never starve X or xmms for 
sustained periods; but under load X will not be smooth getting jerky even 
with small bursts of heavy X use; that's why Ingo increased the max sleep avg 
in the first place... but that led to other issues...

Con

