Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVAKVb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVAKVb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVAKV3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:29:15 -0500
Received: from mx2.elte.hu ([157.181.151.9]:47299 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262829AbVAKV1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:27:36 -0500
Date: Tue, 11 Jan 2005 22:27:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Chris Wright <chrisw@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, Paul Davis <paul@linuxaudiosystems.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       arjanv@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111212719.GA23477@elte.hu>
References: <20050110212019.GG2995@waste.org> <200501111305.j0BD58U2000483@localhost.localdomain> <20050111191701.GT2940@waste.org> <20050111125008.K10567@build.pdx.osdl.net> <20050111205809.GB21308@elte.hu> <20050111131400.L10567@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111131400.L10567@build.pdx.osdl.net>
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


* Chris Wright <chrisw@osdl.org> wrote:

> Hmm, I wonder if this could have anything to do with it.  These are
> within striking range:
> 
>   PID COMMAND          NI PRI
>     9 events/1        -10  34
>   931 kcryptd/1       -10  33
>   930 kcryptd/0       -10  34
>     8 events/0        -10  34
>   892 ata/1           -10  34
>   891 ata/0           -10  34
>  3747 udevd           -10  33
>    26 kacpid          -10  31
>   238 aio/1           -10  34
>   237 aio/0           -10  31
>   117 kblockd/1       -10  34
>   116 kblockd/0       -10  34
>    10 khelper         -10  34

you are right, i forgot about kernel threads. If they are nice -10 on
Jack's system too then they are within striking range indeed, especially
since they are typically idle and if then they are active for short
bursts of time and get the maximum boost. Jack, could you renice these
to -5, to make sure they dont interfere?

btw., why are these at nice -10? workqueue.c sets nice value to -5
normally.

	Ingo
