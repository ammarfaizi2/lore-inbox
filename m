Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269143AbUHaUOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269143AbUHaUOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 16:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHaUMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:12:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62678 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269139AbUHaUKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:10:38 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Daniel Schmitt <pnambic@unu.nu>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mark_H_Johnson@raytheon.com
In-Reply-To: <20040831200912.GA32378@elte.hu>
References: <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu> <1093934448.5403.4.camel@krustophenia.net>
	 <20040831070658.GA31117@elte.hu> <1093980065.1603.5.camel@krustophenia.net>
	 <20040831193734.GA29852@elte.hu> <1093981634.1633.2.camel@krustophenia.net>
	 <20040831195107.GA31327@elte.hu>  <20040831200912.GA32378@elte.hu>
Content-Type: text/plain
Message-Id: <1093983034.1633.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 16:10:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 16:09, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > it's more complex than that - MTRR's are caching attributes that the
> > CPU listens to. Mis-setting them can cause anything from memory
> > corruption to hard lockups. The question is, does any of the Intel (or
> > AMD) docs say that the CPU cache has to be write-back flushed when
> > setting MTRRs, or were those calls only done out of paranoia?
> 
> the Intel docs suggest a cache-flush when changing MTRR's, so i guess
> we've got to live with this. _Perhaps_ we could move the cache-disabling
> and the wbinvd() out of the spinlocked section, but this would make it
> preemptable, possibly causing other tasks to run with the CPU cache
> disabled! I'd say that is worse than a single 0.5 msec latency during
> MTRR setting.
> 

File under boot-time stuff, I guess.  This could be bad if X crashes,
but I can't remember the last time this happened to me, and I use xorg
CVS.

Lee

