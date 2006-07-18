Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWGRKPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWGRKPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWGRKPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:15:46 -0400
Received: from [216.208.38.107] ([216.208.38.107]:50304 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932160AbWGRKPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:15:46 -0400
Subject: Re: [RFC PATCH 18/33] Subarch support for CPUID instruction
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091953.003336000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091953.003336000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:14:46 +0200
Message-Id: <1153217686.3038.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> plain text document attachment (i386-cpuid)
> Allow subarchitectures to modify the CPUID instruction.  This allows
> the subarch to provide a limited set of CPUID feature flags during CPU
> identification.  Add a subarch implementation for Xen that traps to the
> hypervisor where unsupported feature flags can be hidden from guests.

Hi,

I'm wondering if this is entirely the wrong level of abstraction; to me
it feels the subarch shouldn't override the actual cpuid, but the cpu
feature flags that linux uses. That's a lot less messy: cpuid has many
many pieces of information which are near impossible to filter in
practice, however filtering the USAGE of it is trivial; linux basically
flattens the cpuid namespace into a simple bitmap of "what the kernel
can use". That is really what the subarch should filter/fixup, just like
we do for cpu quirks etc etc.

Greetings,
   Arjan van de Ven

