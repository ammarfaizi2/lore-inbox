Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWCDXOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWCDXOH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 18:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWCDXOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 18:14:07 -0500
Received: from ozlabs.org ([203.10.76.45]:19666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751092AbWCDXOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 18:14:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17418.7988.409791.419494@cargo.ozlabs.ibm.com>
Date: Sun, 5 Mar 2006 10:13:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, anemo@mba.ocn.ne.jp, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org, johnstul@us.ibm.com,
       rth@twiddle.net
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
In-Reply-To: <20060304034050.40f29251.akpm@osdl.org>
References: <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	<20060302190408.1e754f12.akpm@osdl.org>
	<20060303.133125.106438890.nemoto@toshiba-tops.co.jp>
	<20060304.013153.71086081.anemo@mba.ocn.ne.jp>
	<20060304001834.0476e8e9.akpm@osdl.org>
	<20060304112010.GA94875@muc.de>
	<20060304034050.40f29251.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Andi Kleen <ak@muc.de> wrote:
> > Yes maybe it would be better to just use  #define there.
> > jiffies_64 always was a bit too clever.
> 
> hm.   It's actually rather hard.

I think the thing that makes most sense is:

#define jiffies	((unsigned long) jiffies_64)

and fix the few drivers that use `jiffies' as a local variable.
No-one should be trying to write to jiffies, and the compiler will do
the right thing for reads of jiffies on 32-bit platforms (it does on
ppc32 at least).

Paul.

