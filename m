Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUJQUYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUJQUYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbUJQUX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:23:57 -0400
Received: from zero.aec.at ([193.170.194.10]:48656 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269418AbUJQUXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:23:37 -0400
To: Alexandre Oliva <aoliva@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: K8 Errata #93: adjusting address to a fixup block
References: <2Qpmj-1uX-13@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 17 Oct 2004 22:23:29 +0200
In-Reply-To: <2Qpmj-1uX-13@gated-at.bofh.it> (Alexandre Oliva's message of
 "Sun, 17 Oct 2004 22:00:11 +0200")
Message-ID: <m3is99xfem.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Oliva <aoliva@redhat.com> writes:

> While I investigated the problem of probing the touchpad on a Compaq
> Presario r3004, I'd sometimes get the K8 Errata #93 warning.  One of
> my theories was that we might be missing some fix up because of the
> Errata, or adjusting an address that wasn't the current-instruction

It's more likely the BIOS is executing SMM code to handle
the touch pad and that SMM code doesn't have the correct
workaround for the erratum.

> address, so I came up with this patch.  It turned out to make no
> difference, but it still feels like an improvement to me, since some
> day we might be resuming from halt into a fix-up block.  Thoughts?

The code is already ugly enough and handles most of the cases, 
I don't think it is worth it complicating it even more just
to handle more corner cases of buggy BIOS.

The real fix is to fix your BIOS.

 	static int warned;
+	if ((error_code & 16) == 0)
+		return 0;

This is dubious because the I/D bit is undefined when NX is disabled
in EFER (e.g. with noexec=off or when the CPU doesn't support NX)

-Andi

