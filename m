Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266711AbTGFSXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 14:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266714AbTGFSXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 14:23:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:59408 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266711AbTGFSXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 14:23:04 -0400
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307070317.11246.kernel@kolivas.org>
References: <200307070317.11246.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1057516609.818.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 06 Jul 2003 20:36:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-06 at 19:16, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Attached is an incremental patch against 2.5.74-mm2 with more interactivity 
> work. Audio should be quite resistant to skips with this, and it should not 
> induce further unfairness.
> 
> Changes:
> The sleep_avg buffer was not needed with the improved semantics in O2int so it 
> has been removed entirely as it created regressions in O2int.
> 
> A small change to the idle detection code to only make tasks with enough 
> accumulated sleep_avg become idle.
> 
> Minor cleanups and clarified code.
> 
> 
> Other issues:
> Jerky mouse with heavy page rendering in web browsers remains. This is a 
> different issue to the audio and will need some more thought.
> 
> The patch is also available for download here:
> http://kernel.kolivas.org/2.5
> 
> Note for those who wish to get smooth X desktop feel now for their own use, 
> the granularity patch on that website will do wonders on top of O3int, but a 
> different approach will be needed for mainstream consumption.

I'm seeing extreme X starvation with this patch under 2.5.74-mm2 when
starting a CPU hogger:

1. Start a KDE session.
2. Launch a Konsole
3. Launch Konqueror
4. Launch XMMS
5. Make XMMS play an MP3 file
6. On the Konsole terminal, run "while true; do a=2; done"

When the "while..." is run, X starves completely for ~5 seconds (e.g.
the mouse cursor doesn't respond to my input events). After those 5
seconds, the mouse cursor goes jerky for a while (~2 seconds) and then
the system gets responsive.

PS: There are no user processes reniced.

