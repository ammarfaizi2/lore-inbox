Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264033AbTKTIDA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 03:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTKTIDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 03:03:00 -0500
Received: from [202.81.18.30] ([202.81.18.30]:39623 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264033AbTKTIC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 03:02:59 -0500
Subject: Re: setcontext syscall
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: gfa@sensaco.com
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <3FBC6728.7030504@sensaco.com>
References: <3FBC6728.7030504@sensaco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1069315322.31665.197.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 20 Nov 2003 19:02:03 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-20 at 18:03, George Fankhauser wrote:
> Hi there!
> 
> I wonder why linux i386 does not implement setcontext as a syscall. 
> Instead it's in in glibc in userspace.

On ppc32, we have started doing just that, a syscall called
sys_swapcontext that does all the variations of get/set_context.
We'll do as well on ppc64 soon.

It also helps perfs because on ppc, the kernel actually knows if
things like the FPU or the Altivec unit were ever used by the
process, and so if it's worth saving/restoring those registers
as part of the context.

Ben.

