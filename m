Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUBVUdP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbUBVUdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:33:15 -0500
Received: from terminus.zytor.com ([63.209.29.3]:44947 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261748AbUBVUdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:33:09 -0500
Message-ID: <403911FD.6070505@zytor.com>
Date: Sun, 22 Feb 2004 12:33:01 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net> <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz> <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org> <c1b2f9$sfj$1@terminus.zytor.com> <Pine.LNX.4.58.0402221230390.1395@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402221230390.1395@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> No. Because on x86-64 it is NOT zero. Because there "unsigned long" is
> 64-bit, and it results in the high 32 bits. Which is, again, exactly what
> we want.
> 

Ah yes, dual-mode code.  Should have figured.

> Guys, give it up. The code is not only already committed, it's simply the 
> best way to do what it does.

Perhaps an even better thing to have would be a wrmsr64() and rdmsr64() 
routines, for the MSRs which genuinely are a 64-bit item.  Splitting 
them up is rather ugly when it's a real 64-bit value.

Then the code would just be:

	/* 32 bits on x64, 64 bits on x86-64 */
	wrmsr64(MSR_NUMBER, (unsigned long)value);

I think the comment would be justified.

If you agree I'll send a patch.

	-hpa
