Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270057AbTGNPMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270133AbTGNPLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:11:08 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:261 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270465AbTGNPKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:10:15 -0400
Subject: Re: [PATCH] O5int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@arcor.de>,
       Mike Galbraith <efault@gmx.de>
In-Reply-To: <200307142232.05782.kernel@kolivas.org>
References: <200307142232.05782.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058196300.582.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 17:25:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 14:32, Con Kolivas wrote:
> More interactivity work for audio and X smoothness. I have fixed all my test
>  cases and need feedback about others to develop beyond this.
> 
> Changes
> The idle code now gives just under interactive state based on the runtime
>  instead of min_sleep_avg - minor startup speed improvement.
> 
> Tasks that drop their priority while running are now put to the end of the
>  queue to continue their timeslice. Fixes a little flutter when tasks are
> cpu hogs for short periods (eg mozilla).
> 
> Tasks that are complete cpu hogs are put on the expired array every time they
>  run out of timeslice.

Hmmm... Starvation is back for me (Pentium III 700Mhz + ACPI):

1. Log on to X/KDE
2. Launch Konqueror
3. Launch XMMS
4. Make XMMS play a song
5. Move the Konqueror window all over the desktop.

Step 5 causes XMMS to completely starve for exactly 5 seconds. After
those 5 seconds, the XMMS priority gets adjusted and sound comes back
from my speakers.

Another way to starve XMMS for 5 seconds:

1. Launch XMMS
2. Make it play
3. Run a standard CPU hogger: "while true; do a=2; done"

Step 3 will make XMMS starve for exactly 5 seconds. Also, during those 5
seconds, X is completely jerky and moving the mouse makes the pointer
goes jumping all over the screen.

Do you want additional information? Any patch trying?
Thanks!

