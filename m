Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWGRKjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWGRKjz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGRKjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:39:55 -0400
Received: from [216.208.38.107] ([216.208.38.107]:4225 "EHLO OTTLS.pngxnet.com")
	by vger.kernel.org with ESMTP id S1751290AbWGRKjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:39:54 -0400
Subject: Re: [RFC PATCH 18/33] Subarch support for CPUID instruction
From: Arjan van de Ven <arjan@infradead.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <214b20545df13e36c91fd1369d57b18a@cl.cam.ac.uk>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091953.003336000@sous-sol.org>
	 <1153217686.3038.37.camel@laptopd505.fenrus.org>
	 <214b20545df13e36c91fd1369d57b18a@cl.cam.ac.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:38:48 +0200
Message-Id: <1153219128.3038.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 11:26 +0100, Keir Fraser wrote:
> On 18 Jul 2006, at 11:14, Arjan van de Ven wrote:
> 
> >> Allow subarchitectures to modify the CPUID instruction.  This allows
> >> the subarch to provide a limited set of CPUID feature flags during CPU
> >> identification.  Add a subarch implementation for Xen that traps to 
> >> the
> >> hypervisor where unsupported feature flags can be hidden from guests.
> >
> > I'm wondering if this is entirely the wrong level of abstraction; to me
> > it feels the subarch shouldn't override the actual cpuid, but the cpu
> > feature flags that linux uses. That's a lot less messy: cpuid has many
> > many pieces of information which are near impossible to filter in
> > practice, however filtering the USAGE of it is trivial; linux basically
> > flattens the cpuid namespace into a simple bitmap of "what the kernel
> > can use". That is really what the subarch should filter/fixup, just 
> > like
> > we do for cpu quirks etc etc.
> 
> Maybe we should have that *as well*, but it makes sense to allow the 
> hypervisor to apply a filter too. For example, whether it supports PSE, 
> FXSAVE/FXRSTOR, etc. These are things the 'platform' is telling the OS 
> -- not something the OS can filter for itself.

To some degree "Xen" is just a magic type of cpu that can/should have a
quirk to filter these out... it just feels wrong and fragile to me to do
it via a cpuid filter... once you have the "other" filter as I suggested
I bet the need for the cpuid filter just goes away...


