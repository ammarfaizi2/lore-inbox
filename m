Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265669AbUABU3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUABU3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:29:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:32944 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265669AbUABU3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:29:04 -0500
Date: Fri, 2 Jan 2004 12:28:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       albert.cahalan@ccur.com, jim.houston@ccur.com
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility
 mode
In-Reply-To: <20040102194909.GA2990@rudolph.ccur.com>
Message-ID: <Pine.LNX.4.58.0401021226150.5282@home.osdl.org>
References: <20040102194909.GA2990@rudolph.ccur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Jan 2004, Joe Korty wrote:
>
> siginfo_t processing is fragile when in 32 bit compatibility mode on
> a 64 bit processor.

It shouldn't be.

Inside the kernel, we should always use the "native" format (ie 64-bit). 
The fact that 64-bit architectures are broken is their bug, and the proper 
way to fix it is to make sure that everything always uses the native 
format.

We should _not_ play games with si_code etc. There is no reason to do so, 
since every entrypointe knows _statically_ whether it is given a 32-bit or 
64-bit version. That's a lot less fragile than depending on a field that 
is filled in by the user.

		Linus
