Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267144AbUBRXVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267168AbUBRXVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:21:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:22763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267158AbUBRXVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:21:16 -0500
Date: Wed, 18 Feb 2004 15:21:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
In-Reply-To: <Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0402181516300.18038@home.osdl.org>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
 <Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Linus Torvalds wrote:
> 
> How about this patch?

Btw, it does show a bug in our "wrmsr()" macro on x86.

We should make sure to cast the values to 32-bit values in wrmsr(), or use
an inline function to make sure that the right conversions happen. Because
we arguably shouldn't give some meaningless error message just because we
passed in a 64-bit argument.

So in addition to fixing "microcode.c" to not do the silly thing in the 
first place, we should probably clean up wrmsr().

I'll think about it. In one sense it was _useful_ to see that the 
microcode update tried to do something that was nonsensical on a 32-bit 
x86. On the other hand, the compiler should do the right thing regardless, 
and it might be useful to allow 64-bit values to be silently truncated 
for compatibility reasons.

I'll commit the microcode fix, and think a bit more about the wrmsr() 
thing.

		Linus
