Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTGFU6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTGFU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:58:40 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:8119 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263496AbTGFU6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:58:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Mon, 7 Jul 2003 07:14:09 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307070317.11246.kernel@kolivas.org> <1057516609.818.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1057516609.818.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307070714.09694.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003 04:36, Felipe Alfaro Solana wrote:
> On Sun, 2003-07-06 at 19:16, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Attached is an incremental patch against 2.5.74-mm2 with more
> > interactivity work. Audio should be quite resistant to skips with this,
> > and it should not induce further unfairness.
> >
> > Changes:
> > The sleep_avg buffer was not needed with the improved semantics in O2int
> > so it has been removed entirely as it created regressions in O2int.
> >
> > A small change to the idle detection code to only make tasks with enough
> > accumulated sleep_avg become idle.
> >
> > Minor cleanups and clarified code.
> >
> >
> > Other issues:
> > Jerky mouse with heavy page rendering in web browsers remains. This is a
> > different issue to the audio and will need some more thought.
> >
> > The patch is also available for download here:
> > http://kernel.kolivas.org/2.5
> >
> > Note for those who wish to get smooth X desktop feel now for their own
> > use, the granularity patch on that website will do wonders on top of
> > O3int, but a different approach will be needed for mainstream
> > consumption.
>
> I'm seeing extreme X starvation with this patch under 2.5.74-mm2 when
> starting a CPU hogger:
>
> 1. Start a KDE session.
> 2. Launch a Konsole
> 3. Launch Konqueror
> 4. Launch XMMS
> 5. Make XMMS play an MP3 file
> 6. On the Konsole terminal, run "while true; do a=2; done"
>
> When the "while..." is run, X starves completely for ~5 seconds (e.g.
> the mouse cursor doesn't respond to my input events). After those 5
> seconds, the mouse cursor goes jerky for a while (~2 seconds) and then
> the system gets responsive.

Cool you beat the idle detection code. Leave the konsole for just a few 
seconds before trying this and see if it's any different. Having not slept 
because of this patch and now going to work I think it can wait a little 
before I work on it any more.

Con

