Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVIFW3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVIFW3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVIFW3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:29:10 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:24479 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751061AbVIFW3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:29:08 -0400
To: Daniel Phillips <phillips@istop.com>
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: RFC: i386: kill !4KSTACKS
X-Message-Flag: Warning: May contain useful information
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	<58d0dbf10509061005358dce91@mail.gmail.com>
	<dfkjav$lmd$1@sea.gmane.org> <200509061819.45567.phillips@istop.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 06 Sep 2005 15:28:59 -0700
In-Reply-To: <200509061819.45567.phillips@istop.com> (Daniel Phillips's
 message of "Tue, 6 Sep 2005 18:19:45 -0400")
Message-ID: <52ll29q190.fsf@cisco.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Sep 2005 22:29:01.0163 (UTC) FILETIME=[6145D3B0:01C5B332]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Daniel> There are only two stacks involved, the normal kernel
    Daniel> stack and your new ndis stack.  You save ESP of the kernel
    Daniel> stack at the base of the ndis stack.  When the Windows
    Daniel> code calls your api, you get the ndis ESP, load the kernel
    Daniel> ESP from the base of the ndis stack, push the ndis ESP so
    Daniel> you can get back to the ndis code later, and continue on
    Daniel> your merry way.

    [...]

    Daniel> You will allocate your own stack once on driver
    Daniel> initialization.

I'm not quite sure it's this trivial.  Obviously there are more than
two stacks involved, since there is more than one kernel stack!  (One
per task plus IRQ stacks)  This is more than just a theoretical
problem.  It seems entirely possible that more than one task could
be in the driver, and clearly they each need their own stack.

So it's going to be at least a little harder than allocating a single
stack for NDIS use when the driver starts up.

I personally like the idea raised elsewhere in this thread of running
the Windows driver in userspace by proxying interrupts, PCI access,
etc.  That seems more robust and probably allows some cool reverse
engineering hacks.

 - R.
