Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTI3JmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTI3JmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:42:25 -0400
Received: from ltgp.iram.es ([150.214.224.138]:58247 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S261249AbTI3JmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:42:22 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 30 Sep 2003 11:35:56 +0200
To: Jamie Lokier <jamie@shareable.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Andi Kleen <ak@muc.de>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030930093556.GB12970@iram.es>
References: <20030929125629.GA1746@averell> <20030929170323.GC21798@mail.jlokier.co.uk> <20030929174910.GA90905@colin2.muc.de> <20030929200820.GA23444@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929200820.GA23444@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 09:08:20PM +0100, Jamie Lokier wrote:
> Btw, you assume that regs->xcs is a valid segment value.  I think that
> the upper 16 bits are not guaranteed to be zero in general on the
> IA32, although they clearly are zero for the majority of IA-32 chips.
> Are they guaranteed to be zero on AMD's processors?

At least for pushes of segment registers a 486 decrements
the stack pointer by 4 but only writes the 2 least significant
bytes, leaving garbage in the upper half. 

That's documented in the list of differences between 486 and Pentium.
It may be different for the frame pushed on the stack during interrupt
entry; my take on it is that it is inherently dangerous to rely
on the upper 16 bits being zero.

Just my 2 cents,

	Regards,
	Gabriel
