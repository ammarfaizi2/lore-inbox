Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270009AbTGPG5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 02:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270158AbTGPG5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 02:57:13 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32517 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270009AbTGPG5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 02:57:12 -0400
Subject: Re: [PATCH] N1int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307160912.05833.kernel@kolivas.org>
References: <200307151355.23586.kernel@kolivas.org>
	 <1058282608.626.4.camel@teapot.felipe-alfaro.com>
	 <200307160912.05833.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058339520.586.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 09:12:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 01:12, Con Kolivas wrote:
> > I can still starve XMMS on 2.5.75-mm1 + patch-O5int-0307150857 +
> > patch-N1int-0307152010:
> >
> > 1. Log on to KDE
> > 2. Launch Konqueror
> > 3. Launch XMMS and make it play
> > 4. Move Konqueror window all over the desktop
> >
> > Step 4 will make XMMS starve for a few seconds. Also, under heavy load
> > (while true; do a=2; done), moving the Konqueror window like crazy makes
> > X go jerky after a few seconds. If I quit moving windows around, after a
> > few other seconds, X returns to normal/smooth behavior.
> 
> I was more concerned to see if the N1 patch added anything to the current 
> behaviour, but that is abandoned work now so don't worry. I can address these 
> further issues incrementally if you're willing to test them. My test boxes 
> have been tamed but I need and appreciate greatly your testing.

Just throw anything to me and I will test it gladly :-)

> > I can fix the starvation/smoothness by setting:
> >
> > #define PRIO_BONUS_RATIO        45
> > #define INTERACTIVE_DELTA       4
> > #define MAX_SLEEP_AVG           (HZ)
> > #define STARVATION_LIMIT        (HZ)
> >
> > For me, 2.6.0-test1 stock scheduler plus above changes makes the most
> > user-friendly desktop I've ever seen.
> 
> With a max sleep avg of just one second you'll never starve X or xmms for 
> sustained periods; but under load X will not be smooth getting jerky even 
> with small bursts of heavy X use; that's why Ingo increased the max sleep avg 
> in the first place... but that led to other issues...

Well, under heavy load (while true ...) X still feels very smooth with
2.6.0-test1 and the above changes. In fact, I was inclined to make those
changes as X didn't feel smooth under load on my system without them.

