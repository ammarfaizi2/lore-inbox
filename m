Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbTGOPPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268442AbTGOPPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:15:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:17413 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S268453AbTGOPIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:08:41 -0400
Subject: Re: [PATCH] N1int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307151355.23586.kernel@kolivas.org>
References: <200307151355.23586.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058282608.626.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 15 Jul 2003 17:23:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 05:55, Con Kolivas wrote:
> I've modified Mike Galbraith's nanosleep work for greater resolution to help 
> the interactivity estimator work I've done in the O*int patches. This patch 
> applies to any kernel patched up to the latest patch-O5int-0307150857 which 
> applies on top of 2.5.75-mm1.
> 
> Please test and comment, and advise what further changes you think are 
> appropriate or necessary, including other archs. I've preserved Mike's code
> unchanged wherever possible. It works well for me, but n=1 does not
> a good sample population make.
> 
> The patch-N1int-0307151249 is available here:
> http://kernel.kolivas.org/2.5

I can still starve XMMS on 2.5.75-mm1 + patch-O5int-0307150857 +
patch-N1int-0307152010:

1. Log on to KDE
2. Launch Konqueror
3. Launch XMMS and make it play
4. Move Konqueror window all over the desktop

Step 4 will make XMMS starve for a few seconds. Also, under heavy load
(while true; do a=2; done), moving the Konqueror window like crazy makes
X go jerky after a few seconds. If I quit moving windows around, after a
few other seconds, X returns to normal/smooth behavior.

I can fix the starvation/smoothness by setting:

#define PRIO_BONUS_RATIO        45
#define INTERACTIVE_DELTA       4
#define MAX_SLEEP_AVG           (HZ)
#define STARVATION_LIMIT        (HZ)

For me, 2.6.0-test1 stock scheduler plus above changes makes the most
user-friendly desktop I've ever seen.

Thanks!

