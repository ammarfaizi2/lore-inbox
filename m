Return-Path: <linux-kernel-owner+w=401wt.eu-S932587AbXAGPSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbXAGPSV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbXAGPSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:18:20 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:58493 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586AbXAGPST (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:18:19 -0500
Date: Sun, 7 Jan 2007 08:18:17 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Christoph Hellwig <hch@infradead.org>,
       Kyle McMartin <kyle@parisc-linux.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org
Subject: Re: [PATCH] Common compat_sys_sysinfo
Message-ID: <20070107151817.GN24620@parisc-linux.org>
References: <20070107144850.GB3207@athena.road.mcmartin.ca> <20070107151319.GA23478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107151319.GA23478@infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 03:13:19PM +0000, Christoph Hellwig wrote:
> and last but not least we probably want a unified mechanisms to deal
> with the 64bit arguments that are broken up into two 32bit ones (not just
> for emulation but also for 32it BE architectures)

It's not BE that is the problem -- drepper thought of that.

What he fundamentally missed was the calling convention where 64-bit
arguments have to be 64-bit aligned, even when they're passed through
registers.  So:

int foo(int, long long);

takes its arguments in arg0, arg2 and arg3, but glibc passes the syscall
arguments in arg0, arg1 and arg2.

I think the Right Way to fix this is for some gcc hacker to implement an
__attribute__((packed_args)) that changes the calling convention for
that function, then we can define asmlinkage to use that on mips and
parisc.

Any budding gcc hackers out there?  ;-)
