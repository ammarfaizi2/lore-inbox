Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTEVOaa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 10:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTEVOaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 10:30:30 -0400
Received: from holomorphy.com ([66.224.33.161]:61067 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261893AbTEVOa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 10:30:29 -0400
Date: Thu, 22 May 2003 07:43:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-ID: <20030522144306.GQ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	James Cleverdon <jamesclv@us.ibm.com>,
	Gerrit Huizenga <gh@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, haveblue@us.ibm.com,
	pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
	johnstul@us.ibm.com, mannthey@us.ibm.com
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> <E19Idxq-0001LD-00@w-gerrit2> <20030522020443.GN2444@holomorphy.com> <200305220718.06982.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305220718.06982.jamesclv@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 07:18:06AM -0700, James Cleverdon wrote:
> Here's my old very stupid TPR patch .  It lacks TPRing soft ints for kernel 
> preemption, etc.  Because the xTPR logic only compares the top nibble of the 
> TPR and I don't want to mask out IRQs unnecessarily, it only tracks busy/idle 
> and IRQ/no-IRQ.
> Simple enough for you, Bill?   8^)

Simple enough, yes. But I hesitate to endorse it without making sure
it's not too simple.

It's much closer to the right direction, which is actually following
hardware docs and then punting the fancy (potentially more performant)
bits up into userspace. When properly tuned, it should actually have a
useful interaction with explicit irq balancing via retargeting IO-APIC
RTE destinations as interrupts targeted at a destination specifying
multiple cpus won't always target a single cpu when TPR's are adjusted.

The only real issue with the TPR is that it's an spl-like ranking of
interrupts, assuming a static prioritization based on vector number.
That doesn't really agree with the Linux model and is undesirable in
various scenarios; however, it's how the hardware works and so can't
be avoided (and the disastrous attempt to avoid it didn't DTRT anyway).


-- wli
