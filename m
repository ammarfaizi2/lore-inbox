Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265869AbUAUAJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUAUAJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:09:28 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:1458 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265869AbUAUAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:09:24 -0500
Subject: Re: [Dri-devel] [2.6 patch] disallow DRM on 386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040120212421.GF12027@fs.tum.de>
References: <20040120212421.GF12027@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074643498.25861.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 21 Jan 2004 00:04:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-01-20 at 21:24, Adrian Bunk wrote:
> I got the following compile error in 2.6.1-mm5 with X86_CMPXCHG=n.
> This problem is not specific to -mm, and it always occurs when you 
> include support for the 386 cpu (oposed to the 486 or later cpus) since 
> in this case X86_CMPXCHG=n and therefoore cmpxchg isn't defined in 
> include/asm-i386/system.h .
> 
> The patch below disallows DRM if X86_CMPXCHG=n.

Ugly.

Fix system.h to always define cmpxchg.h and check its presence at
runtime when the DRM module loads, then you can build 386 kernels that
support DRI on higher machines.

The problem isnt that cmpxchg definitely doesn't exist, so system.h is
wrong IMHO

