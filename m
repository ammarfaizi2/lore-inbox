Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVAPKHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVAPKHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 05:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVAPKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 05:07:19 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:38116 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262470AbVAPKHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 05:07:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: hugang@soulinfo.com
Subject: Re: 2.6.10-mm3: swsusp: out of memory on resume (was: Re: Ho ho ho - Linux v2.6.10)
Date: Sun, 16 Jan 2005 11:07:24 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <200501152220.42129.rjw@sisk.pl> <20050116055420.GA11880@hugang.soulinfo.com>
In-Reply-To: <20050116055420.GA11880@hugang.soulinfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501161107.24883.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 16 of January 2005 06:54, hugang@soulinfo.com wrote:
> On Sat, Jan 15, 2005 at 10:20:42PM +0100, Rafael J. Wysocki wrote:
> > > > > > 
> > > > > > 2.6.11-rc1-mm1 
> > > > > >  -> 2005-1-14.core.diff 	core patch		TEST PASSED
> > > > > >   -> 2005-1-14.x86_64.diff	x86_64 patch	NOT TESTED
> > > > > 
> > > > > Unfortunately, on x86_64 it goes south on suspend, probably somwhere in write_pagedir(),
> > > > > but I'm not quite sure as I can't make it print any useful stuff to the serial console
> > > > > (everything is dumped to a virtual tty only).  Seemingly, it prints some
> > > > > "write_pagedir: ..." debug messages and then starts to print garbage in
> > > > > an infinite loop.
> > 
> > I have some good news for you. :-)
> > 
> > The patch actually works fine on my box.  What I thought was a result of an infinite loop,
> > turned out to be "only" a debug output from it, which is _really_ excessive.  After I had
> > commented out the most of pr_debug()s in your code, it works nicely and I like it very
> > much.  Thanks a lot for porting it to x86_64!
> > 
> Cool, Current I making software suspend also works in Qemu X86_64
> emulation, Here is a update patch to making copyback more safed and 
> possible to improve copyback speed.
> 
> I change the swsusp_arch_resume to nosave section, the in memory copy
> back it not touch this code. before not change that to nosave section,
> I'm also geting a infinite loop in copy_one_page, From the qemu in_asm,
> I sure that loop in copy_one_page, when I change it to nosave section,
> that problem go away, I dont' sure tha't good idea to fixed it, but
> current it works in my qemu, Can someone owner x86_64 test it.
> 
> I disable Flush TLB after copy page, It speedup the in qemu, But I can't
> sure the right thing in real machine, can someone give me point.

Could you, please, make a patch against -rc1-mm1 with your previous patch
applied?  It would be much easier to apply. :-)

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
