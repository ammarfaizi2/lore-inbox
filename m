Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265264AbUGSP2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUGSP2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 11:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbUGSP2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 11:28:50 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:38445 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265264AbUGSP2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 11:28:48 -0400
Date: Mon, 19 Jul 2004 19:29:12 +0200
From: sam@ravnborg.org
To: Song Wang <wsonguci@yahoo.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] kbuild support to build one module with multiple separate components?
Message-ID: <20040719172912.GA6988@mars.ravnborg.org>
Mail-Followup-To: Song Wang <wsonguci@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040714211936.GA8888@mars.ravnborg.org> <20040714214044.69938.qmail@web40006.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714214044.69938.qmail@web40006.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 02:40:44PM -0700, Song Wang wrote:
> Hi, Sam
> 
> Thanks for the reply.
> 
> However, in the way you indicate, the
> mainmodule and each submodule will be built
> as separate kernel modules. You will get
> mainmodule.ko, a_sub_module.ko, b_sub_module.ko etc.
> 
> This is not what I tried to get. I tried to
> build a single kernel module, which means that
> mainmodule.o, a_sub_module.o, b_sub_module.o
> should be linked together to produce the single
> module.

OK.

This is even simpler:

Makefile:

EXTRA_CFLAGS := -I $(obj)/include

module-y := file.o dir/file.o
obj-m := module.o


And then code your C files as usual.
Assumig you have a directory named include.
Include header files like this:
#include "header.h"


So you end up having:

module/file.c
module/Makefile
module/dir/file.c
module/include/header.h

And you use:
make -C kernelsrcdir M=$PWD
to compile your module.

If this does not solve your issue please say so.

	Sam
