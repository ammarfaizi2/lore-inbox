Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263350AbVGOR7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbVGOR7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 13:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbVGOR7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 13:59:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:15262 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263350AbVGOR5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 13:57:02 -0400
Date: Fri, 15 Jul 2005 19:57:01 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, vojtech@suse.cz,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050715175700.GE15783@wotan.suse.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B300410F46A@hdsmsx401.amr.corp.intel.com.suse.lists.linux.kernel> <p73y8889f4v.fsf@bragg.suse.de> <20050715102349.A15791@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715102349.A15791@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't say it is totally impossible. There are ways in which Linux can work
> without a reliable Local APIC timer. One option being - make one CPU that gets 
> the external timer interrupt multicast an IPI to all the other CPUs that
> wants to get periodic timer interrupt.

That doesn't mix very well with variable ticks. And I believe
we really need them.

For no tick in idle you need a timer for each CPU that
can be programmed to a reasonably long interval to wake you
up after longer idleness. And all that
should work without bouncing cache lines around all the time
because that doesn't work on larger systems.

-Andi
