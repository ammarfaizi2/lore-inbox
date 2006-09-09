Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWIILth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWIILth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWIILth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:49:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6582 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932075AbWIILth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:49:37 -0400
Subject: Re: 2.6.18-rc6-mm1 breaks glibc build
From: David Woodhouse <dwmw2@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1157809454.19305.17.camel@Homer.simpson.net>
References: <1157809454.19305.17.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:49:14 +0100
Message-Id: <1157802554.2977.79.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 13:44 +0000, Mike Galbraith wrote:
> For whatever reason, glibc sets sysincludes to point to the running
> kernel's include directory ala...
>         sysincludes = -I /lib/modules/2.6.18-rc6-mm1-smp/build/include
> in it's config.make instead of using installed headers, and this leads
> to the compile failure below.

That's wrong. When you run 'make headers_install', the result is placed
in /lib/modules/`uname -r`/abi/include/ 

It looks like glibc is pointed at the raw kernel headers in the build
tree.

> I just edited config.make to point to different headers, dunno if it
> _should_ work as before (2.6.18-rc6 does) or not. 
>
> /lib/modules/2.6.18-rc6-mm1-smp/build/include/linux/err.h: Assembler messages:

Don't care. <linux/err.h> is not a header which is exported to userspace
by 'make headers_install'. No userspace build, including glibc, should
ever be able to see it.

-- 
dwmw2

