Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWHNOOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWHNOOF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbWHNOOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:14:05 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:27342 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751943AbWHNOOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:14:04 -0400
Date: Mon, 14 Aug 2006 15:14:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Sam Ravnborg <sam@ravnborg.org>, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: stack-protect in conflict with CROSS_COMPILE
Message-ID: <20060814141404.GA4074@linux-mips.org>
References: <20060814120729.GB4340@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814120729.GB4340@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 06:07:29AM -0600, Matthew Wilcox wrote:

> Hi Sam,
> 
> We've stumbled on a problem with -fno-stack-protector and CROSS_COMPILE:
> 
> CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>                    -fno-strict-aliasing -fno-common
> # Force gcc to behave correct even for buggy distributions
> CFLAGS          += $(call cc-option, -fno-stack-protector)
> 
> round about line 310 of Makefile will cause CC to be called before we
> get a chance to set CROSS_COMPILE in arch/parisc/Makefile.  For people
> who are compiling 64-bit parisc kernels, this means the wrong gcc gets
> called, and sometimes the compiler versions are out of sync.
> 
> We will have similar problems with:
> 
> CFLAGS          += -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
> 
> Should we include the arch Makefile earlier in the proceedings?

The -fno-stack-protector issue also affects MIPS.

  Ralf
