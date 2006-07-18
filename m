Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWGRK0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWGRK0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWGRK0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:26:32 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:8886 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932167AbWGRK0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:26:31 -0400
In-Reply-To: <1153217686.3038.37.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091953.003336000@sous-sol.org> <1153217686.3038.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <214b20545df13e36c91fd1369d57b18a@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 18/33] Subarch support for CPUID instruction
Date: Tue, 18 Jul 2006 11:26:19 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2006, at 11:14, Arjan van de Ven wrote:

>> Allow subarchitectures to modify the CPUID instruction.  This allows
>> the subarch to provide a limited set of CPUID feature flags during CPU
>> identification.  Add a subarch implementation for Xen that traps to 
>> the
>> hypervisor where unsupported feature flags can be hidden from guests.
>
> I'm wondering if this is entirely the wrong level of abstraction; to me
> it feels the subarch shouldn't override the actual cpuid, but the cpu
> feature flags that linux uses. That's a lot less messy: cpuid has many
> many pieces of information which are near impossible to filter in
> practice, however filtering the USAGE of it is trivial; linux basically
> flattens the cpuid namespace into a simple bitmap of "what the kernel
> can use". That is really what the subarch should filter/fixup, just 
> like
> we do for cpu quirks etc etc.

Maybe we should have that *as well*, but it makes sense to allow the 
hypervisor to apply a filter too. For example, whether it supports PSE, 
FXSAVE/FXRSTOR, etc. These are things the 'platform' is telling the OS 
-- not something the OS can filter for itself. To trap on CPUID 
invocations requires the guest to use a special code sequence for 
CPUID, since the instruction will never normally fault. Hence moving to 
mach-* to hide this detail.

  -- Keir

