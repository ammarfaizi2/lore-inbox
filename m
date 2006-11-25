Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757890AbWKYIac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890AbWKYIac (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 03:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757891AbWKYIab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 03:30:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32974 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757890AbWKYIab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 03:30:31 -0500
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
From: Arjan van de Ven <arjan@infradead.org>
Reply-To: arjan@infradead.org
To: Wink Saville <wink@saville.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <4567B0CC.4030802@saville.com>
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de>
	 <20061124202514.GA7608@elte.hu>  <4567B0CC.4030802@saville.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 25 Nov 2006 09:30:23 +0100
Message-Id: <1164443423.3147.51.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-24 at 18:56 -0800, Wink Saville wrote:
> Ingo Molnar wrote:
> > * Andi Kleen <ak@suse.de> wrote:
> > 
> > a new CPU is added. If the TSC isnt sync on SMP then it quickly gets 
> > pretty messy, and we should rather take a look at /why/ these apps are 
> > using RDTSC.
> > 
> > 	Ingo
> > -
> 
> I use RDTSC in get a cheap method of measuring time. What other choices are
> there for a low overhead high frequency time source?
> 
> By low overhead a kernel call is way to expensive, I want to minimally impact
> the code and have many of these calls through out the code. One of the
> ways I use it is to instrument multi-threaded applications and then use
> the TSC to compare when actions occur between threads. i.e. I use it as a
> time stamp counter and neither precision or accuracy is too important.
> On the other hand the more precise and accurate the better:)

so you can live with an occasional jump of seconds/minutes between
threads? Or when a thread moves to another cpu?
(yes on many PCs you won't see minutes, but on others you will)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

