Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316968AbSF0Uyl>; Thu, 27 Jun 2002 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSF0Uyk>; Thu, 27 Jun 2002 16:54:40 -0400
Received: from aboukir-101-1-23-willy.adsl.nerim.net ([62.212.114.60]:41490
	"EHLO www.home.local") by vger.kernel.org with ESMTP
	id <S316968AbSF0Uyj>; Thu, 27 Jun 2002 16:54:39 -0400
From: Willy Tarreau <willy@w.ods.org>
Message-Id: <200206272056.g5RKunvS009052@alpha.home.local>
Subject: Re: 2.4.19-rc1 proc_get_inode Unresolved in /net/wan/comx.o
To: linux@cedar-astronomers.org (Jason Alexander)
Date: Thu, 27 Jun 2002 22:56:49 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206271539190.24838-100000@cedar-astronomers.org> from "Jason Alexander" at Jun 27, 2002 03:44:58 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.19-rc1; fi
> depmod: *** Unresolved symbols in /lib/modules/2.4.19-rc1/kernel/drivers/net/wan/comx.o
> depmod:         proc_get_inode

I noticed it in february, and wrote a patch which allowed it to at least compile,
link and load properly, but I couldn't check if it worked, not having the hardware.
Someone told be that the driver was borken anyway and that even with my patch it
was unusable, so I gave up and simply disabled it in my .config.

> What would be the best way to proceed.

I simply removed comx_delete_dentry() and comx_lookup(), and assigned
comx_root_inode_ops.lookup from comx_root_dir->proc_iops->lookup in comx_init().

Better luck with CONFIG_COMX=n IMHO.

Cheers,
Willy

