Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTJSVO6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTJSVO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:14:58 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:25617 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262201AbTJSVO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:14:56 -0400
Date: Sun, 19 Oct 2003 23:13:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Sinelnikov Evgeny <linux4sin@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.0-test5: ioctl.h: _IOC_TYPECHECK: Is it a bug?
Message-ID: <20031019211340.GA7524@win.tue.nl>
References: <200310090253.01449.sin@info.sgu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310090253.01449.sin@info.sgu.ru>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 11:39:04PM +0400, Sinelnikov Evgeny wrote:

> I have problem with linux-utils.2.12 compile on 2.6.0-test5 headers. From this 
> version instead 2.6.0-test4 was changed next file where added next string:
> 
> include/asm-i386/ioctl.h:
> #define _IOC_TYPECHECK(t) \
>         ((sizeof(t) == sizeof(t[1]) && \
>           sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
>           sizeof(t) : __invalid_size_argument_for_IOC)
> 
> This string have problems with compiling files using _IOR macros from ioctl.h
> Here is example from util-linux-2.12:
> #define BLKBSZGET  _IOR(0x12,112,sizeof(int))

Normally, user space includes <sys/ioctl.h>, which again includes
<asm/ioctl.h> which defines _IOR etc.

It sounds like you use a symlink /usr/include/asm into a kernel source tree.
Doing such things is discouraged. For people that follow kernel development
the kernel source tree changes from day to day. When some utility shows
obscure errors it would be necessary to recall when, and with what kernel
headers it was last compiled in order to debug the problem. That is not good
for stability and reproducibility.

Moreover, there are no guarantees that kernel headers work in user space.
Often they do for some kernel versions and don't for other kernel versions.
It is the task of the distributor of include files to pick a suitable set.

Finally, when something is wrong with util-linux, please tell aeb@cwi.nl.
(There used to be a mailing list but I think it has been killed since
the recent spam floods.)

Andries

