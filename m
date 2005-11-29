Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVK2XqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVK2XqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVK2XqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:46:21 -0500
Received: from ns2.suse.de ([195.135.220.15]:63447 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751403AbVK2XqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:46:20 -0500
Date: Wed, 30 Nov 2005 00:46:17 +0100
From: Andi Kleen <ak@suse.de>
To: Bernd Schmidt <bernds_cb1@t-online.de>
Cc: Andi Kleen <ak@suse.de>, Nicholas Miell <nmiell@comcast.net>,
       Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [discuss] Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
Message-ID: <20051129234617.GY19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de> <200511291056.32455.raybry@mpdtxmail.amd.com> <20051129180903.GB6611@frankl.hpl.hp.com> <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy> <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy> <20051129224346.GS19515@wotan.suse.de> <438CE416.3060707@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438CE416.3060707@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I happen to have an old program which uses RDTSC frequently for timing 
> purposes.  That seemed like a good idea at the time, but I guess it 
> should be updated.  The question is, what replacement is there?  I don't 
> want to have to use a syscall every 50 instructions or so.  Feel free to 
> laugh, but suggesting a workable replacement might be more helpful.

Well, you're asking me to write all the points from the documentation
in advance. Not tonight (or look up the full thread in the l-k archives,
I think I covered most) 

But right now gettimeofday or clock_gettime(CLOCK_MONOTONIC) is
probably your best option. It tries to be reasonable fast depending 
on hardware capabilities (and when you measure on P4 
even basic RDTSC is quite slow). At least on x86-64 gettimeofday
isn't a real system call, but actually often stays in ring 3.

If you want to measure instructions in cycles in the future you can probably 
use RDPMC 0, but that's not implemented yet. It won't be a replacement
for a timer for other purposes.

-Andi
