Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVANVDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVANVDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVANUxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:53:49 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:8870 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262134AbVANUwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:52:46 -0500
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Matt Mackall <mpm@selenic.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <87is61b0l4.fsf@sulphur.joq.us>
References: <20050110212019.GG2995@waste.org>
	 <200501111305.j0BD58U2000483@localhost.localdomain>
	 <20050111191701.GT2940@waste.org>
	 <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu>
	 <20050111131400.L10567@build.pdx.osdl.net> <20050111212719.GA23477@elte.hu>
	 <87fz15j325.fsf@sulphur.joq.us> <20050113063446.GV2940@waste.org>
	 <87is61b0l4.fsf@sulphur.joq.us>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 15:52:44 -0500
Message-Id: <1105735965.7258.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 13:17 -0600, Jack O'Quin wrote:
> But there may be other, better solutions to the deadlock problem.
> Several years ago, Roger Larsson wrote a completely user-space
> realtime monitor program that works perfectly well for revoking
> realtime privileges when it detects CPU starvation.  I still use it
> occasionally to help debug problems if the built-in JACK watchdog
> timer doesn't catch them.

Jack,

Do you have a link to Roger Larsson's RT watchdog?

Since we seem to have a consensus that the rlimit approach is the way to
go, I think it will be important to have a generic watchdog thread
running as root at a higher RT prio than the RT group.  JACK solves the
problem with its own watchdog thread but as more and more apps migrate
to (in our opinion) the "correct" RT programming model, where you have
multithreaded apps with normal prio disk and GUI threads feeding an RT
rendering thread, a system wide watchdog daemon becomes more attractive.
Keep in mind there are many other applications than audio, for example
CD burning has an obvious RT constraint and cdrecord will take advantage
of SCHED_FIFO and mlockall() if it can get them.

Lee

