Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUHPKvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUHPKvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHPKvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:51:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59815 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267535AbUHPKsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:48:33 -0400
Date: Mon, 16 Aug 2004 12:48:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Scott Wood <scott@timesys.com>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-M5
Message-ID: <20040816104811.GA24747@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <1091141622.30033.3.camel@mindpipe> <20040730064431.GA17777@elte.hu> <1091228074.805.6.camel@mindpipe> <s5hfz75sh30.wl@alsa2.suse.de> <1091847265.949.8.camel@mindpipe> <s5h8ycfbc5c.wl@alsa2.suse.de> <1092652981.13981.11.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092652981.13981.11.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> > No, this is not.  It should be a real XRUN, I believe.
> 
> This one has still defied explanation.  The working theory was that it
> was the same bug causing an xrun if an unrelated process called
> mlockall, but now that bug has been fixed, and this xrun at startup
> still happens.

does the first xrun happen right during startup, or only when the first
jack application uses jackd to do audio?

if the former then does jackd set itself up (does an mlockall, etc.) 
before it opens the audio device? If the audio device has an event for
jackd the moment the device is opened, and jackd opens the audio device
early during startup, then jackd might not be able to process this event
until it has started up (which can take milliseconds).

	Ingo
