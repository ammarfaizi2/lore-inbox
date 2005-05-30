Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVE3UBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVE3UBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVE3UBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:01:16 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6062 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261728AbVE3UBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:01:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17051.28464.67012.631845@alkaid.it.uu.se>
Date: Mon, 30 May 2005 21:53:20 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Adrian Bunk <bunk@stusta.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] document that gcc 4 is not supported
In-Reply-To: <20050530192835.GK10441@stusta.de>
References: <20050530192835.GK10441@stusta.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:
 > gcc 4 is not supported for compiling kernel 2.4, and I don't see any 
 > compelling reason why kernel 2.4 should ever be adapted to gcc 4.
...
 > --- linux-2.4.31-rc1-full/init/main.c.old	2005-05-30 21:20:00.000000000 +0200
 > +++ linux-2.4.31-rc1-full/init/main.c	2005-05-30 21:21:19.000000000 +0200
 > @@ -84,6 +84,13 @@
 >  #error Sorry, your GCC is too old. It builds incorrect kernels.
 >  #endif
 >  
 > +/*
 > + * gcc >= 4 is not supported by kernel 2.4
 > + */
 > +#if __GNUC__ > 3
 > +#error Sorry, your GCC is too recent for kernel 2.4
 > +#endif
 > +
 >  extern char _stext, _etext;
 >  extern char *linux_banner;
 >  

This is redundant. Any attempt to compile vanilla 2.4 with gcc4
will fail with compilation errors. (And except for one issue on
x86-64 which actually was a kernel bug, those are the only known
issues with using gcc4 for 2.4.)

OTOH, for those of us that do use gcc4, this just gets in the way
and forces the gcc4 fixes kit for 2.4 to be even larger.

Since distributors won't use gcc4 for 2.4, and naive users won't
succeed anyway, what's the point?

/Mikael
