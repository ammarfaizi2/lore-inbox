Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUIIWEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUIIWEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUIIWDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:03:35 -0400
Received: from holomorphy.com ([207.189.100.168]:51379 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267999AbUIIWAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:00:48 -0400
Date: Thu, 9 Sep 2004 15:00:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040909220040.GM3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Matt Mackall <mpm@selenic.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16704.52551.846184.630652@cargo.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> Checking in_lock_functions() (not sure what the name in Zwane's code
>> was) for non-leaf functions in get_wchan() in addition to
>> in_sched_functions() should do. e.g.

On Fri, Sep 10, 2004 at 07:38:15AM +1000, Paul Mackerras wrote:
> Well, no, not if we are two levels deep at this point (i.e. something
> calls _spin_lock which calls __preempt_spin_lock).  I really don't
> want to have to start doing a stack trace in profile_pc().

The semantics of profile_pc() have never included backtracing through
scheduling primitives, so I'd say just report __preempt_spin_lock().


-- wli
