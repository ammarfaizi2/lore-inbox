Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266558AbUGKKc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUGKKc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUGKKc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:32:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44501 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266557AbUGKKcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:32:11 -0400
Date: Sun, 11 Jul 2004 12:30:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711103020.GA24797@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <20040711093209.GA17095@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org> <20040711095039.GA22391@elte.hu> <20040711025855.08afbca1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711025855.08afbca1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9,
	autolearn=not spam
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> OK, but most of the new ones are unneeded with CONFIG_PREEMPT=y.  I'm
> still failing to see why a non-preempt, voluntary preemption kernel
> even needs to try to be competitive with a preemptible kernel?

the reason is difference in overhead (codesize, speed) and risks (driver
robustness). We do not want to enable preempt for Fedora yet because it
breaks just too much stuff and is too heavy. So we looked for a solution
that might work for a generic distro.

here are the code size differences. With a typical .config (debugging
options disabled), the 2.6.7-mm7(+voluntary-preempt) UP x86 kernel gets
the following .text sizes:

   orig:      1776911 bytes
   preempt:   1855519 bytes  (+4.4%)
   voluntary: 1783407 bytes  (+0.3%)

so if voluntary-preempt can get close to real preempt's numbers for
practical stuff then we get most of the benefits while excluding some of
the nastiest risks and disadvantages.

(Long-term i'd like to see preempt be used unconditionally - at which
point the 10-line CONFIG_VOLUNTARY_PREEMPT Kconfig and kernel.h change
could go away.)

	Ingo
