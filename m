Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbTGGI70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbTGGI70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:59:26 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3601 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266867AbTGGI7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:59:25 -0400
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200307071319.57511.kernel@kolivas.org>
References: <200307070317.11246.kernel@kolivas.org>
	 <1057516609.818.4.camel@teapot.felipe-alfaro.com>
	 <200307071319.57511.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1057569235.848.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 07 Jul 2003 11:13:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-07 at 05:19, Con Kolivas wrote:
> On Mon, 7 Jul 2003 04:36, Felipe Alfaro Solana wrote:
> > I'm seeing extreme X starvation with this patch under 2.5.74-mm2 when
> > starting a CPU hogger:
> >
> > 1. Start a KDE session.
> > 2. Launch a Konsole
> > 3. Launch Konqueror
> > 4. Launch XMMS
> > 5. Make XMMS play an MP3 file
> > 6. On the Konsole terminal, run "while true; do a=2; done"
> >
> > When the "while..." is run, X starves completely for ~5 seconds (e.g.
> > the mouse cursor doesn't respond to my input events). After those 5
> > seconds, the mouse cursor goes jerky for a while (~2 seconds) and then
> > the system gets responsive.
> 
> Aha!
> 
> Thanks to Felipe who picked this up I was able to find the one bug causing me 
> grief. The idle detection code was allowing the sleep_avg to get to 
> ridiculously high levels. This is corrected in the following replacement 
> O3int patch. Note this fixes the mozilla issue too. Kick arse!!

Yeah! I can't reproduce the bug anymore :-) Good work!

Is there any tunable to make the scheduler adjust the interactivity/CPU
usage a little bit faster? Just after launching XMMS and make it play,
moving the Konqueror window like crazy makes XMMS skip for a few
seconds.

