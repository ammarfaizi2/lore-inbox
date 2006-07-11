Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWGKQEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWGKQEw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWGKQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:04:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60093 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751123AbWGKQEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:04:50 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [discuss] Re: [PATCH] Allow all Opteron processors to change pstate at same time
Date: Tue, 11 Jul 2006 18:04:28 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       Joachim Deguara <joachim.deguara@amd.com>,
       Mark Langsdorf <mark.langsdorf@amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk,
       vojtech@suse.cz
References: <Pine.LNX.4.64.0607061519040.9066@solonow.amd.com> <1152623675.3128.41.camel@laptopd505.fenrus.org> <1152634538.18028.23.camel@localhost.localdomain>
In-Reply-To: <1152634538.18028.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607111804.28741.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 July 2006 18:15, Alan Cox wrote:
> Ar Maw, 2006-07-11 am 15:14 +0200, ysgrifennodd Arjan van de Ven:
> > if you have per cpu offset and speed, then you don't even need to tie
> > all frequencies together... sounds like the best solution to me..
> 
> CPU clocks on some systems are not stable relative to one another. Doing
> the maths only works if you know the divergence isn't cause by
> independant clock sources

You misunderstood the proposal  (actually there is a prototype, so it's
more than that)

The reason the TSCs need to be synchronized is that gettimeofday always
takes the offset against a global variable set by the last timer interrupt.
So your TSC needs to be synchronized to the CPU of the TSC that runs
the timer interrupt.

If instead the per CPU timers set a cpu local variable then you
can do the offset calculation per CPU. 

The scheduler already uses this trick by keeping sched_clock comparisions
always CPU local.

In practice there are a few more complications, but that's it in a nutshell.

-Andi
