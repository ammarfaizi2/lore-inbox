Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWENRfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWENRfL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWENRfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:35:11 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:42209 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751495AbWENRfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:35:10 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Date: Sun, 14 May 2006 19:32:10 +0200
User-Agent: KMail/1.9.1
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <9a8748490605131042w3214a7b8lb9a862798e3131d4@mail.gmail.com> <4466DB13.5090104@gmail.com>
In-Reply-To: <4466DB13.5090104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605141932.10799.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Sunday, 14. May 2006 09:24, Catalin Marinas wrote:
> >> +#if 0
> >> +       /* make some orphan pointers for testing */
> >> +       kmalloc(32, GFP_KERNEL);
> >> +       kmalloc(32, GFP_KERNEL);
> >> +       kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
> >> +       kmem_cache_alloc(pointer_cache, GFP_ATOMIC);
> >> +       vmalloc(64);
> >> +       vmalloc(64);
> >> +#endif
> > 
> > Stuff for testing is nice, but do we have to add it to the kernel? - I
> > assume you are done testing :-)
> > We have waay too much code already in the kernel inside  #if 0
> 
> The best would be to test it using a loadable module but I did most of
> the work on an embedded ARM platform where it was much easier to add
> some code directly. The code will be cleaned up in subsequent versions.

Fair enough. Just put it in a seperate file, 
add a Kconfig "TEST_MEMLEAK_DETECTOR" tristate option,
depending on "DEBUG_MEMLEAK" and adjust the Makefile accordingly.

That way we can activate it from time to time by loading that module
and you can test it by compiling a new kernel.

RCU and CRYPTO have similiar features.


Regards

Ingo Oeser
