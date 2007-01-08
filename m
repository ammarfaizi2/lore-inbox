Return-Path: <linux-kernel-owner+w=401wt.eu-S1750744AbXAIATr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbXAIATr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbXAIATr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:19:47 -0500
Received: from ozlabs.org ([203.10.76.45]:38836 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbXAIATq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:19:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17826.46886.680834.928790@cargo.ozlabs.ibm.com>
Date: Tue, 9 Jan 2007 08:27:02 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up PPC code to use canonical alignment macros from
 kernel.h.
In-Reply-To: <Pine.LNX.4.64.0701081535140.2965@localhost.localdomain>
References: <Pine.LNX.4.64.0701081535140.2965@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day writes:

>   Clean up some PowerPC source files to use the canonical alignment
> macros from kernel.h, and add an ALIGN_DOWN() macro to kernel.h for
> symmetry.

[snip]

>   and, no, i didn't test-compile this as i don't have a PPC
> cross-compiler at the moment.  sorry.

Yeah.  I would be surprised if it did build, since you are removing
definitions without adding any #includes to make sure we get the
global definition.

>  arch/powerpc/boot/addRamDisk.c               |    3 +--
>  arch/powerpc/boot/of.c                       |    2 +-
>  arch/powerpc/boot/page.h                     |    9 +--------
>  arch/powerpc/boot/simple_alloc.c             |    8 ++++----

NAK.  Stuff in arch/powerpc/boot intentionally *doesn't* depend on
Linux kernel headers, since it runs outside of the kernel, either on
the build machine (addRamDisk.c) or before the kernel.

Paul.
