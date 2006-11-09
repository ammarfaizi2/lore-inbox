Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161807AbWKIFzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161807AbWKIFzQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965954AbWKIFzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:55:15 -0500
Received: from dsl093-039-086.pdx1.dsl.speakeasy.net ([66.93.39.86]:14285 "EHLO
	mauritius.dodds.net") by vger.kernel.org with ESMTP id S965953AbWKIFzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:55:13 -0500
Date: Wed, 8 Nov 2006 21:55:10 -0800
From: Steve Langasek <vorlon@debian.org>
To: Jason Harrison <jharrison@linuxbs.org>
Cc: Eki <eki@sci.fi>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org, thias.lelourd@gmail.com
Subject: Re: [patch] video: support for VGA hoses on alpha TITAN, TSUNAMI systems (ES45, DS25)
Message-ID: <20061109055510.GH5314@mauritius.dodds.net>
References: <20061102083718.GC12267@mauritius.dodds.net> <20061102131443.918d6c2e.akpm@osdl.org> <20061104063510.GA7268@mauritius.dodds.net> <200611082104.37349.jharrison@linuxbs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611082104.37349.jharrison@linuxbs.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Nov 08, 2006 at 09:04:37PM -0500, Jason Harrison wrote:

> Just wanted to let you know I tested this patch 
> http://people.debian.org/~vorlon/alpha-titan-video.patch on 2.6.18.2 sources 
> and got the following errors during the compile.  The same 2.6.18.2 sources 
> compile ok so I think this has something to do with the alpha-titan-video 
> patch.  I hope this information is useful.  I do not know too much about 
> debugging yet or I would have tried to provide more.

> In file included from include/asm/io.h:250,
>                  from include/linux/dmapool.h:14,
>                  from include/linux/pci.h:564,
>                  from arch/alpha/kernel/alpha_ksyms.c:16:
> include/asm/core_titan.h: In function 'titan_ioportmap':
> include/asm/core_titan.h:386: error: dereferencing pointer to incomplete type
> make[1]: *** [arch/alpha/kernel/alpha_ksyms.o] Error 1
> make: *** [arch/alpha/kernel] Error 2

Ok; evidently, the reference to asm/pci.h really *was* required, because
otherwise the definition of FIXUP_IOADDR_VGA() is used well before struct
pci_controller is defined when building with CONFIG_ALPHA_TITAN.  I've
re-added this to the test patch, please feel free to re-download and test.

-- 
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
vorlon@debian.org                                   http://www.debian.org/
