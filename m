Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbTGOR33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269210AbTGOR32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:29:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:3478 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S269207AbTGOR30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:29:26 -0400
Date: Tue, 15 Jul 2003 18:43:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Kathy Frazier <kfrazier@mdc-dayton.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Message-ID: <20030715174337.GC1491@mail.jlokier.co.uk>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com> <3F14348B.4050606@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F14348B.4050606@didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> >>>dmatimer.expires = jiffies + 0.5*HZ;
> >>
> >>That's a serious bug. You cannot use floating point in the kernel.
> >>It will corrupt the FP state of the user process.
> >
> >HZ on the INTEL platform is 100, so this should simply add 50 to the 
> >current
> >value of jiffies.  Besides, assigning the value to the unsigned int field
> >(expires) will truncate it to an integer anyway.
> 
> Use HZ/2 instead.  GCC doesn't optimize floating point constants to the 
> same degree it does integers, because it doesn't know what mode 
> (rounding, precision) the FPU is in.

Optimising this to an integer add of 50 would be incorrect anyway.
Think about jiffies == 0xfffffffe.

The first statement is equivalent to:

	dmatimer.expires = (unsigned long) ((double) + 50)

and would set dmatimer.expires to 0xffffffff.

Whereas the HZ/2 form is correct!

Have a nice day,
-- Jamie
