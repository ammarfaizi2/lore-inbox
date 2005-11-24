Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVKXOnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVKXOnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 09:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVKXOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 09:43:19 -0500
Received: from [81.2.110.250] ([81.2.110.250]:58246 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751134AbVKXOnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 09:43:18 -0500
Subject: Re: [patch] SMP alternatives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20051124142200.GH20775@brahms.suse.de>
References: <p7364qjjhqx.fsf@verdi.suse.de>
	 <1132764133.7268.51.camel@localhost.localdomain>
	 <20051123163906.GF20775@brahms.suse.de>
	 <1132766489.7268.71.camel@localhost.localdomain>
	 <20051123165923.GJ20775@brahms.suse.de>
	 <1132783243.13095.17.camel@localhost.localdomain>
	 <20051124131310.GE20775@brahms.suse.de>
	 <m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
	 <20051124133907.GG20775@brahms.suse.de>
	 <1132842847.13095.105.camel@localhost.localdomain>
	 <20051124142200.GH20775@brahms.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Nov 2005 15:15:24 +0000
Message-Id: <1132845324.13095.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-24 at 15:22 +0100, Andi Kleen wrote:
> What do you need a special driver for if the northbridge just
> can do the scrubbing by itself?

You need a driver to collect and report all the ECC single bit errors to
the user so that they can decide if they have problem hardware.

EDAC is more than one thing
	- Control response to a fatal error
	- Report non-fatal events for analysis/user decision making

Hardware scrubbing is good, but knowing the rate of non-fatal errors and
the trend in rate of errors is essential to planning and management of
systems.

> On the modern systems I'm familiar with it's an machine check (although
> not necessarily a recoverable one and there might be other bad
> side effects) 

The Intel I have looked at generates MCE if the L2/L1/bus parity errors
but not on a RAM ECC error as that is memory controller not CPU level.
That usually asserts NMI. Same for most older chips PIII/AMD Athlon etc

> > The -mm EDAC code works on the basic assumption that unrecovered ECC is
> > a system halter although that is configurable.
> 
> I don't know what you could do over the default code for K8 at least.
> And on modern Intel server chipsets I would expect it also to not
> be needed.

Varies a lot again. Hopefully that'll simplify as/when/if Intel put the
memory controller on CPU.

Alan

