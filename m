Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUCDS5M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUCDS4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:56:37 -0500
Received: from mail6.iserv.net ([204.177.184.156]:60588 "EHLO mail6.iserv.net")
	by vger.kernel.org with ESMTP id S262083AbUCDSys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:54:48 -0500
Message-ID: <40477B7C.4050809@didntduck.org>
Date: Thu, 04 Mar 2004 13:54:52 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PnP BIOS exception fixes
References: <Pine.GSO.4.44.0403041657430.10910-100000@math.ut.ee> <404769B5.7080900@quark.didntduck.org> <Pine.LNX.4.58.0403041051430.1047@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403041051430.1047@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 4 Mar 2004, Brian Gerst wrote:
> 
>>This patch fixes two errors in fixup_exception() for PnP BIOS faults:
>>- Check for the correct segments used for the BIOS
>>- Fix asm constraints so that EIP and ESP are properly reloaded
> 
> 
> I'm almost certain that you should NOT use "g" as a constraint, since that 
> allows the address to be on the stack frame, so when we compile without 
> frame pointers and the compiler uses a %esp-relative thing for the branch 
> address, that will totally screw up when we just re-loaded %esp inside the 
> asm.
> 
> Can you use "r" instead, and test that it all works for you, and send an 
> updated patch? Or just explain why I'm wrong.
> 
> 		Linus
> 

The inputs are global variables, with absolute addresses.

--
				Brian Gerst
