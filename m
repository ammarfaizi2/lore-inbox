Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbWJPJDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWJPJDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161244AbWJPJDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:03:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:45724 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161243AbWJPJDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:03:02 -0400
X-Authenticated: #14349625
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
From: Mike Galbraith <efault@gmx.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0610160144y2a432683s886c1a19b33a91ee@mail.gmail.com>
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
	 <1160899154.5935.19.camel@Homer.simpson.net>
	 <1160976752.6477.3.camel@Homer.simpson.net>
	 <b0943d9e0610160107qff115d2r8adef99452560e16@mail.gmail.com>
	 <1160989710.17131.14.camel@Homer.simpson.net>
	 <b0943d9e0610160144y2a432683s886c1a19b33a91ee@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 09:33:35 +0000
Message-Id: <1160991215.17131.26.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 09:44 +0100, Catalin Marinas wrote:
> On 16/10/06, Mike Galbraith <efault@gmx.de> wrote:
> > On Mon, 2006-10-16 at 09:07 +0100, Catalin Marinas wrote:
> > > Kmemleak introduces some overhead but shouldn't be that bad.
> > > DEBUG_SLAB also introduces an overhead by erasing the data in the
> > > allocated blocks.
> >
> > 2.6.18 with your rc6 patch booted normally with stack unwind enabled.
> 
> The only difference is that kmemleak now uses save_stack_trace() to
> generate the call chain. In the previous versions I implemented a
> simple stack backtrace myself, with the disadvantage that it only
> worked on ARM and x86.
> 
> I think kmemleak should use the common stack trace API and investigate
> why it is slower (either save_stack_trace is slower with stack unwind
> enabled or kmemleak doesn't use these functions properly).

The stack traces look fine without unwind, and at a glance looked fine
with unwind as well, so I speculate you must be using save_stack_trace
properly.  The only difference I noticed was the incredible speed
difference.  I gave up on getting to run level 5 with unwind, getting to
level 2 took ages, and the box was horribly slow at everything.

	-Mike

