Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVKAAeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVKAAeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVKAAeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:34:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964928AbVKAAeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:34:07 -0500
Date: Mon, 31 Oct 2005 16:34:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: zippel@linux-m68k.org, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-Id: <20051031163408.41a266f3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
	<20051031001647.GK2846@flint.arm.linux.org.uk>
	<20051030172247.743d77fa.akpm@osdl.org>
	<200510310341.02897.ak@suse.de>
	<Pine.LNX.4.61.0511010039370.1387@scrub.home>
	<20051031160557.7540cd6a.akpm@osdl.org>
	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Mon, 31 Oct 2005, Andrew Morton wrote:
> > 
> > Are you sure these kernels are feature-equivalent?
> 
> They may not be feature-equivalent in reality, but it's hard to generate 
> something that has the features (or lack there-of) of old kernels these 
> days. Which is problematic.

Probably.

> But some of it is likely also compilers. gcc does insane padding in many 
> cases these days. 

2.6.14 `make allnoconfig':

gcc-2.95.4:

	bix:/usr/src/25> size vmlinux 
	   text    data     bss     dec     hex filename
	 665502  152379   55120  873001   d5229 vmlinux

gcc version 4.1.0 20050513 (experimental):

	bix:/usr/src/25> size vmlinux
	   text    data     bss     dec     hex filename
	 761415  151851   55280  968546   ec762 vmlinux

(There's a new reason for retaining gcc-2.95.x support)

(gcc-4.x can probably be tuned up with appropriate `-malign' options)

> And a lot of it is us just being bloated. Argh.

2.5.71, gcc-2.95.4:

	bix:/usr/src/aa/linux-2.5.71> size vmlinux 
	   text    data     bss     dec     hex filename
	 501892   54163   40420  596475   919fb vmlinux

yes, it got bigger.   .data went through the roof - maybe inlined debug stuff?

2.6.8.1, gcc-2.95.4:

	bix:/usr/src/aa/linux-2.6.8.1> size vmlinux
	   text    data     bss     dec     hex filename
	 605032  153817   58176  817025   c7781 vmlinux


It happened somewhere between 2.5.71 and 2.6.8.

2.4.x doesn't have allnoconfig, so no numbers for that.
