Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUCDSrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUCDSrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:47:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:51405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262072AbUCDSrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:47:02 -0500
Date: Thu, 4 Mar 2004 10:53:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@didntduck.org>
cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PnP BIOS exception fixes
In-Reply-To: <404769B5.7080900@quark.didntduck.org>
Message-ID: <Pine.LNX.4.58.0403041051430.1047@ppc970.osdl.org>
References: <Pine.GSO.4.44.0403041657430.10910-100000@math.ut.ee>
 <404769B5.7080900@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Mar 2004, Brian Gerst wrote:
>
> This patch fixes two errors in fixup_exception() for PnP BIOS faults:
> - Check for the correct segments used for the BIOS
> - Fix asm constraints so that EIP and ESP are properly reloaded

I'm almost certain that you should NOT use "g" as a constraint, since that 
allows the address to be on the stack frame, so when we compile without 
frame pointers and the compiler uses a %esp-relative thing for the branch 
address, that will totally screw up when we just re-loaded %esp inside the 
asm.

Can you use "r" instead, and test that it all works for you, and send an 
updated patch? Or just explain why I'm wrong.

		Linus
