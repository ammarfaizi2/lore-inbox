Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTJDKEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTJDKEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 06:04:54 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:17869 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261970AbTJDKEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 06:04:53 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: mlockall and mmap of IO devices don't mix
Date: Sat, 4 Oct 2003 12:02:08 +0200
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@muc.de>, Joe Korty <joe.korty@ccur.com>,
       linux-kernel@vger.kernel.org
References: <CFYv.787.23@gated-at.bofh.it> <20031004091703.GB23306@colin2.muc.de> <20031004102221.A18928@flint.arm.linux.org.uk>
In-Reply-To: <20031004102221.A18928@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310041202.08742.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Saturday 04 October 2003 11:22, you wrote:
> On Sat, Oct 04, 2003 at 11:17:03AM +0200, Andi Kleen wrote:
> > > This check is only done, if it is a valid pfn (pfn_valid()) of a
> > > present pte.
> >
> > pfn_valid is useless, it doesn't handle all IO holes on x86 for examples.
>
> Sounds like pfn_valid() is buggy on x86.  It's supposed to definitively
> indicate whether the PFN is a valid page of ram (and has a valid struct
> page entry.)  If it doesn't do that, the architecture implementation is
> wrong.

Looks like it. But it also has to be fast (see include/asm-i386/mmzone.h) 
and doesn't even hide the holes in NUMA machines. 

We had a page_is_ram() for this somewhere. I don't know, why this is
gone. It would be useful in other places as well.

If the page_is_ram() test could be done using the vma only now, this
would be even better and should be called vma_is_ram() to generalize
these corner cases (today and in the future) and make more
clear what these kind of tests want to do.

Regards

Ingo Oeser


