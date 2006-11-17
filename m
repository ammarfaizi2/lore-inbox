Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162345AbWKQE31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162345AbWKQE31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 23:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162346AbWKQE31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 23:29:27 -0500
Received: from mx1.suse.de ([195.135.220.2]:9388 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162345AbWKQE30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 23:29:26 -0500
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Date: Fri, 17 Nov 2006 05:29:02 +0100
User-Agent: KMail/1.9.5
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061115213241.GC17238@frankl.hpl.hp.com> <455D11B9.4080302@goop.org>
In-Reply-To: <455D11B9.4080302@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611170529.02460.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 02:34, Jeremy Fitzhardinge wrote:
> Stephane Eranian wrote:
> > Here is a small patch that adds two cpufeature bits to represent
> > Intel's Precise-Event-Based Sampling (PEBS) and Branch Trace Store
> > (BTS) features. Those features can be found on Intel P4 and Core 2 
> > processors among others and can be used by perfmon.
> >   
> 
> I've been thinking it would be useful for kernel debugging if kernel
> oops messages could use the branch history to show the last few jumps on
> processors which support it.  It would help a lot with the "oh, an oops
> with eip==esp==0" type crashes, which are otherwise pretty unhelpful.

I have had private patches for that myself, using the MSRs on AMD
and Intel.

The problem is that you have to insert hooks early into the exception
handlers to read the branch history MSRs, and that gets fairly ugly
and a little slow and we can't really enable it by default.

But using BTS with a long in memory buffer would be fine. It would
just be slower so it couldn't be enabled by default. But as a debugging
feature it would be nice.

-Andi
