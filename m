Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbUC1X7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 18:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUC1X7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 18:59:36 -0500
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:35284 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262496AbUC1X7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 18:59:34 -0500
Date: Sun, 28 Mar 2004 17:59:28 -0600
From: Dan Hopper <ku4nf@austin.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-ID: <20040328235928.GA32243@obiwan.dummynet>
Mail-Followup-To: Dan Hopper <ku4nf@austin.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1E741-Sh-5@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1E741-Sh-5@gated-at.bofh.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> remarked:
> 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc2/2.6.5-rc2-mm4/

Hi Andrew,

On a Thinkpad T40p, 2.6.5-rc2-mm4 does not boot successfully,
whereas 2.6.5-rc2 does.  All the typical things (ACPI, CPUFREQ, APIC
& IOAPIC, etc.) are built in.  The -mm4 kernel config was derived
from the working config for 2.6.5-rc2.  

I have to pass the nolapic kernel option to disable the local APIC
in order to successfully boot 2.6.x kernels.  It appears that with
2.6.5-rc2-mm4, this option is ignored, or perhaps there's a ordering
issue with when it is checked.  With -mm4, a message saying that it
is enabling the local APIC appears _before_ the "Kernel command
line: ... nolapic" line appears.

Without the -mm4 patch, the nolapic command line option is parsed
before it would have tried to reenable the local APIC.  With -mm4,
it is parsed after it tries to renable it.  Boom, and then it locks
on "Calibrating delay loop...".

Any relevant config options I should try with/without to help narrow
it down?

Thanks,
Dan
