Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTLLSeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTLLSeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:34:25 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:30616 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261754AbTLLSeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:34:23 -0500
Date: Fri, 12 Dec 2003 18:25:56 +0000
From: Dave Jones <davej@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide
Message-ID: <20031212182556.GB10584@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Keith Owens <kaos@ocs.com.au>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20031212154401.GA10584@redhat.com> <4939.1071246352@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4939.1071246352@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 03:25:52AM +1100, Keith Owens wrote:
 > On Fri, 12 Dec 2003 15:44:01 +0000, 
 > Dave Jones <davej@redhat.com> wrote:
 > > Might be worth mentioning in the Per-CPU data section that code doing
 > >operations on CPU registers (MSRs and the like) needs to be protected
 > >by an explicit preempt_disable() / preempt_enable() pair if it's doing
 > >operations that it expects to run on a specific CPU.
 > 
 > Also calls to smp_call_function() need to be wrapped in preempt_disable,
 > plus any work that is done on the current cpu before/after calling a
 > function on the other cpus.  Lack of preempt disable could result in
 > the operation being done twice on one cpu and not at all on another.

And where you want to do the same thing on every processor, there's a
handy on_each_cpu() which takes care of this for you.

		Dave

