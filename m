Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUJRQxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUJRQxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUJRQxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:53:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45013 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266879AbUJRQxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:53:15 -0400
Date: Mon, 18 Oct 2004 18:54:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
Message-ID: <20041018165416.GA31259@elte.hu>
References: <OFF2CA4065.A5BB2E79-ON86256F31.005A287D-86256F31.005A2895@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF2CA4065.A5BB2E79-ON86256F31.005A287D-86256F31.005A2895@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >i have released the -U5 Real-Time Preemption patch:
> >
> >
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5
> 
> I am getting build problems - specifically with:

>   CC [M]  drivers/char/ipmi/ipmi_watchdog.o

> If I read the patch correctly, this should be recoded as
>   DECLARE_MUTEX
> instead, but a quick grep of the source code indicates we have about
> 20 more places where DECLARE_MUTEX_LOCKED is still used. Should I do
> a global replace on that or is something else needed?

it's not normally used, and it's much simpler to rewrite those places
than to implement initialization. (which would be quite hairy)

> I also had a compile failure in XFS. The messages are:
>   CC [M]  fs/xfs/quota/xfs_dquot_item.o
>   CC [M]  fs/xfs/quota/xfs_trans_dquot.o

ok, i've re-uploaded a new version of -U5 that has this and the 
ipmi_watchdog compilation problems fixed.

please check whether it works, XFS does not seem to make use of count>1
semaphores but one never knows ...

	Ingo

