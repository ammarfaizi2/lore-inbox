Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWBBMDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWBBMDr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWBBMDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:03:47 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:5638 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1750926AbWBBMDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:03:46 -0500
Date: Thu, 2 Feb 2006 12:01:10 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] compat: fix compat_sys_openat and friends
Message-ID: <20060202120109.GA5273@linux-mips.org>
References: <20060202161151.58839ffd.sfr@canb.auug.org.au> <Pine.LNX.4.64.0602012134150.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602012134150.21884@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 09:36:40PM -0800, Linus Torvalds wrote:

> > Most of the 64 bit architectures will zero extend the first argument to
> > compat_sys_{openat,newfstatat,futimesat} which will fail if the 32 bit
> > syscall was passed AT_FDCWD (which is a small negative number).  Declare
> > the first argument to be an unsigned int which will force the correct
> > sign extension when the internal functions are called in each case.
> 
> Umm.
> 
> Wouldn't it be _much_ better to declare the argument as a "long", since 
> some architectures (alpha, for example) may assume that 32-bit arguments 
> have been _sign_extended, not zero-extended.

> Then, when the "compat_sys_xxxx()" function passes the "long" down to the 
> _real_ function (which takes an "int"), those architectures (and only 
> those architectures) that actually have assumptions about high bits will 
> have the compiler automatically do the right zero- or sign-extensions at 
> that call-site.

MIPS is one of those architectures where variables are always held
sign-extended to the full 32-bit or 64-bit size of the register.  The
signed-ness of the C data type doesn't matter at all here so Stephen's
change is a nop for MIPS.

  Ralf
