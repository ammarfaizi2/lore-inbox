Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbUAOXWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 18:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUAOXWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 18:22:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:19645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265151AbUAOXV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 18:21:58 -0500
Date: Thu, 15 Jan 2004 14:55:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute
In-Reply-To: <20040115074834.GA38796@colin2.muc.de>
Message-ID: <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org>
 <20040115074834.GA38796@colin2.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Jan 2004, Andi Kleen wrote:
> 
> Actually you would get a non booting system because the broken mount
> ABI does a stress test of EFAULT on every boot.

There is somethinglike _three_ exceptions that get any kind of testing: 
the WP bit, the mount interface, and the FP fault check. 

That's three out of several thousand, so coverage really sucks. That's why 
I'd rather just sort the damn thing once and for all, and not have that 
issue pop up every once in a while.

> That's fine for me. In fact I did this some time ago on x86-64 when I 
> ran into similar problems. Here's a port of the x86-64 sort function.

Ugh. Can't we just make this be generic code (and that means calling it in
the module loading code too..)?

As to bubble sort (which is fine for something that is 99% sorted anyway),
isn't it better to continue pushing the entry down when you find something 
out of order? That way you don't have to repeat the whole scan, you just 
continue with the next entry once the unsorted entry has percolated to its 
place (ie keep entries "0..n-1" sorted at all times). That should make the 
code cleaner too.

		Linus
