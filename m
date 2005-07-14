Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262976AbVGNKF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbVGNKF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbVGNKF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:05:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61961 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262976AbVGNKEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:04:10 -0400
Date: Thu, 14 Jul 2005 11:04:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
In-Reply-To: <20050713195349.GE26172@kvack.org>
Message-ID: <Pine.LNX.4.61L.0507141058030.31857@blysk.ds.pg.gda.pl>
References: <200507122239.03559.kernel@kolivas.org> <200507122253.03212.kernel@kolivas.org>
 <42D3E852.5060704@mvista.com> <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz>
 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <20050713193540.GD26172@kvack.org>
 <20050713194115.GA2272@ucw.cz> <20050713195349.GE26172@kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2005, Benjamin LaHaise wrote:

> That's one thing I truely dislike about the current timer code.  If we 
> could program the RTC interrupt to come into the system as an NMI (iirc 
> oprofile already has code to do this), we could get much better TSC 
> interpolation since we would be sampling the TSC at a much smaller, less 
> variable offset, which can only be a good thing.

 And we'd get a lot more crashes on broken systems that do not handle NMIs 
in the SMM -- this is the very reason the NMI watchdog is disabled these 
days by default.  A whole lot of systems simply cannot handle NMIs 
happening randomly.

 Programming an I/O APIC to deliver the RTC interrupt (or any other that's 
edge-triggered) as an NMI is itself trivial (we can do this for the PIT 
for the NMI watchdog already).

  Maciej
