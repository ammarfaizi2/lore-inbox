Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWF2CHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWF2CHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 22:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWF2CHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 22:07:13 -0400
Received: from hera.kernel.org ([140.211.167.34]:59273 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750958AbWF2CHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 22:07:11 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: vmalloc kernel parameter
Date: Wed, 28 Jun 2006 19:07:03 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e7vck7$v1g$1@terminus.zytor.com>
References: <44A272CA.5000209@nrao.edu> <20060628163339.d2110437.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1151546823 31793 127.0.0.1 (29 Jun 2006 02:07:03 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Thu, 29 Jun 2006 02:07:03 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060628163339.d2110437.vsu@altlinux.ru>
By author:    Sergey Vlasov <vsu@altlinux.ru>
In newsgroup: linux.dev.kernel
> 
> > Hi, I'm having troubles when using the vmalloc kernel parameter.
> > 
> > My grub config looks as shown below. If I set vmalloc to anything
> > bigger than 128M (the default) then the kernel will not boot and it
> > will log the following on the console:
> > 
> > VFS: Cannot open root device "LABEL=/" or unknown-block(0,0)
> > Please append a correct "root=" boot option
> > Kernel Panic - not syncing: VFS Unable to mount root fs on
> > unknown-block(0,0)
> > 
> > If I specify 128M or less then the kernel will boot just fine and
> > /proc/meminfo will show the effect in VmallocTotal.
> > 
> > Any hint on what I'm crashing with?
> 
> This is a known problem with GRUB: it tries to put initrd at the highest
> possible address in memory, and assumes the standard vmalloc area size.
> You need to trick GRUB into thinking that your machine has less memory
> by using "uppermem 524288" (512M) or even lower - then the initrd data
> will still be accessible for the kernel even with larger vmalloc area.
> 

Grub is just following protocol in that way.  The kernel really ought
to move the initrd to the spot that it wants, preferrably as early as
possible in the boot.  On i386, it could do it in assembly before even
enabling paging; on x86-64 none of this is an issue...

	-hpa

