Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUE1Se4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUE1Se4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 14:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUE1Se4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 14:34:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17381 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263776AbUE1Sex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 14:34:53 -0400
Date: Fri, 28 May 2004 11:33:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Arjan van de Ven <arjanv@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: RE: CONFIG_IRQBALANCE for AMD64?
Message-ID: <2750000.1085769212@flay>
In-Reply-To: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com>
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Fri, May 28, 2004 at 10:46:18AM -0700, Martin J. Bligh wrote:
>>> 
>>> Personally, I find the argument that it's hardware-specific control
> code
>>> a much better reason for it to belong in the kernel.
>> 
>> Is it really hardware specific ??
> 
> I think automatic IRQ binding business should belong to the user-level;
> it can use generic statistics, application, or platform configuration
> knowledge.
> 
> The kernel-level should have some simple chipset model, such as lowest
> priority delivery mode with finer granularity of control. The kirqd at
> this point, is doing automatic IRQ binding business as well today,
> although it does not literally bind them. So I think we need to remove
> that part of code from kirqd. 

My personal feeling is that we can't get to happen from userspace what 
really needs to happen .... but we're going about this ass-backwards.
Instead of starting with a solution, and seeing what we can wedge into
it ... what do we actually want to do?

Here's my start at a list ... I'm sure it's woefully incomplete.

1. Utilize all CPUs roughly evenly for IRQ processing load (anything that's
not measured by the scheduler at least, because it's unfair to other 
processes). Also, we may well have more than 1 CPU's worth of traffic to
process in a large network server.

2. Provide some sort of cache-affinity for network interrupt processing,
which also helps us not get into out-of-order packet situations.

3. Utilize idle CPUs where possible to shoulder the load.

4. Provide such a solution for all architectures.

What else? I think we started doing this because of (1 & 2) mainline, 
especially as the P4 is moronically stupid by default but I know Dave 
Olien looked at 3 as well at some point past. 

ISTR one of the objections to the in-kernel stuff was that the way it
calculated costs was to look only at the in_interrupt() part of the
processing ... does the backend stuff get accounted currently to the
poor sucker who is currently running, in the same was as the interrupt?

Whatever we do ... all arches are going to need to provide a way to direct
interrupts to a certain CPU, or group thereof. Can they all do that already?
I'll confess to not having looked at non-i386 arches. And are others as
brain damaged as the P4? or do they do something round-robin by default?

M.
