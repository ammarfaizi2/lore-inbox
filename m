Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUHPKxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUHPKxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHPKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:53:08 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41451 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267519AbUHPKvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:51:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
In-Reply-To: <20040816104811.GA24747@elte.hu>
References: <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu>
	 <1091228074.805.6.camel@mindpipe> <s5hfz75sh30.wl@alsa2.suse.de>
	 <1091847265.949.8.camel@mindpipe> <s5h8ycfbc5c.wl@alsa2.suse.de>
	 <1092652981.13981.11.camel@krustophenia.net>
	 <20040816104811.GA24747@elte.hu>
Content-Type: text/plain
Message-Id: <1092653547.13981.15.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 06:52:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-16 at 06:48, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > No, this is not.  It should be a real XRUN, I believe.
> > 
> > This one has still defied explanation.  The working theory was that it
> > was the same bug causing an xrun if an unrelated process called
> > mlockall, but now that bug has been fixed, and this xrun at startup
> > still happens.
> 
> does the first xrun happen right during startup, or only when the first
> jack application uses jackd to do audio?
> 

It happens when the jackd server starts up, before any clients connect.

> if the former then does jackd set itself up (does an mlockall, etc.) 
> before it opens the audio device? If the audio device has an event for
> jackd the moment the device is opened, and jackd opens the audio device
> early during startup, then jackd might not be able to process this event
> until it has started up (which can take milliseconds).

This is probably what is happening, the kernel-side issue seems fixed,
but I will have to test some more and look at the source tomorrow, it's
getting late.

Lee


