Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWJXNWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWJXNWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 09:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbWJXNWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 09:22:23 -0400
Received: from [198.99.130.12] ([198.99.130.12]:50823 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964827AbWJXNWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 09:22:22 -0400
Date: Tue, 24 Oct 2006 09:20:25 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Mitch <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1
Message-ID: <20061024132025.GA4190@ccure.user-mode-linux.org>
References: <453DC147.2020508@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453DC147.2020508@0Bits.COM>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 11:31:19AM +0400, Mitch wrote:
> I'm still having build failures on 2.6.18.1 and even the latest -rc3
> 
> home /usr/src/sources/kernel/linux-2.6.18% !ma
> make ARCH=um
>   SYMLINK arch/um/include/kern_constants.h
>   CC      arch/um/sys-i386/user-offsets.s
> arch/um/sys-i386/user-offsets.c: In function 'foo':
> arch/um/sys-i386/user-offsets.c:19: warning: implicit declaration of 
> function 'offsetof'

The last time I saw this, someone had replaced the glibc kernel
headers with a link to include/ within a kernel pool.  There, offsetof
is wrapped in #ifdef __KERNEL__, and inaccessible to userspace.

The glibc headers have a usable offsetof, so fix that, and UML should
build.

				Jeff
