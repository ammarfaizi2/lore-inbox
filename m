Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWBNGN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWBNGN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWBNGN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:13:26 -0500
Received: from fmr22.intel.com ([143.183.121.14]:17307 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030484AbWBNGNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:13:25 -0500
Message-Id: <200602140613.k1E6DDg19350@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>
Cc: <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch 0/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Mon, 13 Feb 2006 22:13:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxGWS/I8eOWBiNQ9mjzO4cEX/yFwAEQA6Q
In-Reply-To: <43F15211.2090206@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Monday, February 13, 2006 7:44 PM
> Andrew Morton wrote:
> > Well I don't see any benchmark numbers in the original patch.  Just an
> > assertion that it "should" help something.
> > 
> The regression was in a Ken's commercial database benchmark. I couldn't
> reproduce it but presumably it did fix it otherwise Ken would would have
> piped up?

I wasn't entirely happy though ;-)


> > I'm more inclined to revert it and not add the sysctl (ugh) until we have a
> > good reason to do so.
> > 
> 
> If you revert this then Ken's database benchmark gets worse. Hence the
> sysctl.

Yes, Nick is correct.  For db workload, the wake-ups type are mixed.
Some of them are random, some of them are not because we do interrupt
binding.  The break down between random/fixed is about 30/70.  Thus,
Nick's patch helps 30% of time.  With sysctl, we can regain the entire
up side for db workload while retain workload on the other end of
spectrum.

- Ken

