Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUDOXIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 19:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUDOXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 19:08:05 -0400
Received: from zero.aec.at ([193.170.194.10]:52235 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262810AbUDOXIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 19:08:02 -0400
To: Len Brown <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] 
	for idle=C1halt, 2.6.5
References: <1KkKQ-2v9-9@gated-at.bofh.it> <1Kqdx-6E1-5@gated-at.bofh.it>
	<1KH4I-3W9-11@gated-at.bofh.it> <1LgOQ-7px-3@gated-at.bofh.it>
	<1LlEY-36q-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 16 Apr 2004 01:07:56 +0200
In-Reply-To: <1LlEY-36q-11@gated-at.bofh.it> (Len Brown's message of "Thu,
 15 Apr 2004 22:30:16 +0200")
Message-ID: <m3k70gx2k3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> writes:

> While I don't want to get into the business of maintaining
> a dmi_scan entry for every system with this issue, I think
> it might be a good idea to add a couple of example entries
> for high volume systems for which there is no BIOS fix available.

Or do a generic fix: check for the PCI-ID of the Nforce2 and when
it is true and the timer is wrong just correct it. That's ugly,
but it's probably the best solution for such a common issue
(and the IO-APIC code is already filled with workarounds anyways)

One problem is that this likely must happen before the PCI quirks
run. In the x86-64 code I have special "early PCI scanning" code 
for this that could be copied. I don't have a Nforce2, but when
someone is willing to test I can do a patch for this.

-Andi

P.S.: This problem of reference BIOS bugs getting haunting Linux
even after they are long fixed is unfortunately common :-(

