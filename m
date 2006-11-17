Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162060AbWKQH6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162060AbWKQH6U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162428AbWKQH6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:58:20 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:57821 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1162060AbWKQH6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:58:19 -0500
Date: Thu, 16 Nov 2006 23:57:51 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
Message-ID: <20061117075750.GA19907@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061115213241.GC17238@frankl.hpl.hp.com> <455D11B9.4080302@goop.org> <200611170529.02460.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611170529.02460.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy,

On Fri, Nov 17, 2006 at 05:29:02AM +0100, Andi Kleen wrote:
> On Friday 17 November 2006 02:34, Jeremy Fitzhardinge wrote:
> > Stephane Eranian wrote:
> > > Here is a small patch that adds two cpufeature bits to represent
> > > Intel's Precise-Event-Based Sampling (PEBS) and Branch Trace Store
> > > (BTS) features. Those features can be found on Intel P4 and Core 2 
> > > processors among others and can be used by perfmon.
> > >   
> > 
> > I've been thinking it would be useful for kernel debugging if kernel
> > oops messages could use the branch history to show the last few jumps on
> > processors which support it.  It would help a lot with the "oh, an oops
> > with eip==esp==0" type crashes, which are otherwise pretty unhelpful.
> 
> I have had private patches for that myself, using the MSRs on AMD
> and Intel.
> 
> The problem is that you have to insert hooks early into the exception
> handlers to read the branch history MSRs, and that gets fairly ugly
> and a little slow and we can't really enable it by default.
> 
There are two ways of capturing branches on the Intel processors (I have not
looked at AMD): Last Branch Record (LBR) and Branch Trace Store (BTS). The former
stores from/to information into MSRs and is very small (4 branches). The later could
be as big as you want. On recent processors LBR and BTS can be constrained by priv level.
The issue is that they capture ALL taken branches, not just taken function call or return.

> But using BTS with a long in memory buffer would be fine. It would
> just be slower so it couldn't be enabled by default. But as a debugging
> feature it would be nice.
> 

Yes, I think it could be used for debugging, you'd need to reserve a few pages
and initialize a single MSR (32_DEBUGCTL).

-- 
-Stephane
