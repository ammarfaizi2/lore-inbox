Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269549AbUJLJQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269549AbUJLJQY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUJLJQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:16:24 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60844 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269549AbUJLJQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:16:14 -0400
Date: Tue, 12 Oct 2004 11:17:40 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
Message-ID: <20041012091740.GA18736@elte.hu>
References: <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu> <20041007105230.GA17411@elte.hu> <1097555404.1553.18.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097555404.1553.18.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Just to recap, these are the three problem areas that still produce
> latencies over 500 usec on my machine.
> 
> 	journal_clean_checkpoint_list

you might want to send this trace to Andrew too - the primary master of
ext3 latency-breaking.

> 	rt_garbage_collect

this one is still nasty and needs revisiting.

> 	vga console
> 
> I have found that the latter does not require switching back and forth
> to X; anything that produces a lot of console output can trigger 500
> usec latencies.

the vga console one we got rid of at a certain stage and it now
resurfaced. The issue was doing VGA-text-RAM copies/memsets under the
vga_lock. Maybe there were changes in vgacon recently that moved some of
those back under the lock?

	Ingo
