Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276406AbRJHFxh>; Mon, 8 Oct 2001 01:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRJHFx2>; Mon, 8 Oct 2001 01:53:28 -0400
Received: from rj.sgi.com ([204.94.215.100]:23276 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276406AbRJHFxN>;
	Mon, 8 Oct 2001 01:53:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zisofs doesn't compile in 2.4.10-ac7 
In-Reply-To: Your message of "Sun, 07 Oct 2001 16:11:04 +0200."
             <200110071411.f97EB4o26001@ns.caldera.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 15:53:20 +1000
Message-ID: <2772.1002520400@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001 16:11:04 +0200, 
Christoph Hellwig <hch@ns.caldera.de> wrote:
>It should be tested with the following patch instead:
>
>--- linux/Makefile~	Wed Oct  3 15:31:07 2001
>+++ linux/Makefile	Sun Oct  7 17:04:39 2001
>@@ -94,7 +94,8 @@
> # standard CFLAGS
> #
> 
>-CPPFLAGS := -D__KERNEL__ -I$(HPATH)
>+GCCINC := $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/\1include/gp')
>+CPPFLAGS := -D__KERNEL__ -nostdinc -I$(HPATH) -I$(GCCINC)
> 
> CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
> 	  -fomit-frame-pointer -fno-strict-aliasing -fno-common
>

Good idea.  kbuild 2.5 starting with 2.4.11-pre5 forces the kernel to
only use its own includes plus gcc install includes.  No more scanning
/usr/include for kernel compiles.

