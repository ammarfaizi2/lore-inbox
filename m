Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUAHDwo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 22:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAHDwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 22:52:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:24023 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263185AbUAHDwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 22:52:43 -0500
Date: Wed, 7 Jan 2004 19:52:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Use of floating point in the kernel
In-Reply-To: <3FFCCFAE.8090302@zytor.com>
Message-ID: <Pine.LNX.4.58.0401071948470.2131@home.osdl.org>
References: <20040107235912.GA23812@ee.oulu.fi> <3FFCCFAE.8090302@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Jan 2004, H. Peter Anvin wrote:
>
> Pekka Pietikainen wrote:
> > 
> > There are a few instances of use of floating point in 2.6,
> 
> Has anyone considered asking the gcc people to add an -fno-fpu (or 
> -mno-fpu) option, throwing an error if any FP instructions are used?

We really should, but there really are some rare cases where it is 
actually ok.

In particular, you _can_ do math, if you just do the proper
"kernel_fpu_begin()"/"kernel_fpu_end()" around it, and you have reason to 
believe that you can assume a math processor exists. 

Is it needed? I dunno. I'd frown on it in general, but I don't see it 
being fundamentally wrong under the rigth circumstances.

		Linus
