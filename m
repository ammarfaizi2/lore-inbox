Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUJQFVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUJQFVA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUJQFVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:21:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61825 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269056AbUJQFU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:20:57 -0400
Date: Sun, 17 Oct 2004 07:21:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041017052157.GA28067@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <200410162230.14363.dominik.karall@gmx.net> <1097958703.2148.27.camel@krustophenia.net> <200410162344.41533.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410162344.41533.dominik.karall@gmx.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dominik Karall <dominik.karall@gmx.net> wrote:

> > The trace looks like mplayer reading from a FAT filesystem.  Can you
> > reproduce the problem if you do whatever you were doing with mplayer
> > again?
> 
> i could reproduce it now, but only once. it appeared when i started an
> avi movie from my fat32 partition. mplayer stopped at buffering 2% and
> does not play the movie. i tried to start mplayer again and reproduce
> it, but the bug does not appear again. mplayer only stopped at 2%
> buffering and does nothing more. it seems like the file couldn't be
> read clearly now from the fat32 partition, as it does not work with
> xine and others too. here is the bug i get now:

did you retry after rebooting the box? Such bugs can easily depend on IO
patterns (and code sequences) that only happen the first time the file
is accessed in such way (inode init, delays due to IO, etc.). So what
would be nice to try (if you havent tried it already) is to:

 - reboot the box into this same kernel and retry - do you get the oops?

 - if you can reproduce the oops this way in a more or less reliable way
   then please try the same with 2.6.9-rc4-mm1 too.

it _looks_ like a bug not related to the RT patch but a connection
cannot be ruled out: the mutex based kernel changes locking for fatfs
too, and could trigger hidden or hard-to-trigger bugs in an easier way.

In the locking sense the RT kernel can be considered equivalent to an
SMP box with an infinite number of CPUs, even on a uniprocessor. It
tests SMP locking in way nothing else does.

	Ingo
