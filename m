Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263868AbUECSwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUECSwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUECSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:52:11 -0400
Received: from palrel10.hp.com ([156.153.255.245]:57294 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263868AbUECSvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:51:42 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.38071.912606.952360@napali.hpl.hp.com>
Date: Mon, 3 May 2004 11:51:35 -0700
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [0.5/2] scheduler caller profiling
In-Reply-To: <20040503022346.GG1397@holomorphy.com>
References: <20040503021709.GF1397@holomorphy.com>
	<20040503022346.GG1397@holomorphy.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Bill> On Sun, May 02, 2004 at 07:17:09PM -0700, William Lee Irwin
  Bill> III wrote:
  >> The thundering herd issue in waitqueue hashing has been seen in
  >> practice. In order to preserve the space footprint reduction
  >> while improving performance, I wrote "filtered wakeups", which
  >> discriminate between waiters based on a key.

  Bill> This patch was used to collect the data on the offending
  Bill> callers into the scheduler. It creates a profile buffer
  Bill> completely analogous to its handling to /proc/profile, but
  Bill> registers profile ticks at calls to the various scheduler
  Bill> entry points instead of during timer ticks and rearranges
  Bill> scheduler code for this to be accounted properly. It does not
  Bill> report meaningful statistics in the presence of
  Bill> CONFIG_PREEMPT.

  Bill> Posting this patch is in order to disclose how I obtained the
  Bill> scheduling statistics reported in the first post. This patch
  Bill> is not intended for inclusion.

Note that on ia64, you can use q-syscollect/q-view to collect
call-counts statistically (with zero intrusion to the monitored
program, so it's safe for the kernel).  While the call-graph/counts
won't be perfectly accurate, this has proven to work extremely well in
practice.  In fact, it would be nice if other arches could support the
same.  All you really need for this to work is the ability to count N
call (or return) instructions and record the source and destination
address of the N-th call somewhere (registers or memory).  I looked at
the P4 performance-monitor briefly but I couldn't quite figure out
whether it supports the required functionality (it seemed like it
could only record _all_ branches, which would be a problem).  If a
P4-expert is interested in pursuing this, let me know.  I'd be happy
to help/advise with some of the more subtle issues that need to be
address to get this to work correctly.

	--david
