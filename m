Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbUCZSIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUCZSIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:08:46 -0500
Received: from palrel12.hp.com ([156.153.255.237]:58516 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264101AbUCZSIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:08:44 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16484.29095.842735.102236@napali.hpl.hp.com>
Date: Fri, 26 Mar 2004 10:08:39 -0800
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040326110619.GA25210@redhat.com>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
	<20040326110619.GA25210@redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 26 Mar 2004 11:06:19 +0000, Dave Jones <davej@redhat.com> said:

  Dave> On Thu, Mar 25, 2004 at 06:00:14PM -0800, Andrew Morton wrote:
  >> +static inline void prefetch_range(void *addr, size_t len) +{
  >> +#ifdef ARCH_HAS_PREFETCH + char *cp; + char *end = addr + len; +
  >> + for (cp = addr; cp < end; cp += PREFETCH_STRIDE) +
  >> prefetch(cp); +#endif +} + #endif

  Dave> I think this may be dangerous on some CPUs, if may prefetch
  Dave> past the end of the buffer. Ie, if PREFETCH_STRIDE was 32, and
  Dave> len was 65, we'd end up prefetching 65->97. As well as being
  Dave> wasteful to cachelines, this can crash if theres for eg
  Dave> nothing mapped after the next page boundary.

Huh?  It only ever prefetches addresses that are _within_ the
specified buffer.  Of course it will prefetch entire cachelines, but I
hope you're not worried about cachlines crossing page-boundaries! ;-))

	--david
