Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVIJWbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVIJWbx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVIJWbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:31:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932336AbVIJWbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:31:52 -0400
Date: Sat, 10 Sep 2005 15:31:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, dwmw2@infradead.org, stern@rowland.harvard.edu,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-Id: <20050910153110.36a44eba.akpm@osdl.org>
In-Reply-To: <43235707.7050909@pobox.com>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
	<Pine.LNX.4.58.0509101410300.30958@g5.osdl.org>
	<43235707.7050909@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Linus Torvalds wrote:
> > Case closed. 
> > 
> > Bogus warnings are a _bad_ thing. They cause people to write buggy code.
> > 
> > That drivers/pci/pci.c code should be simplified to not look at the error
> > return from pci_set_power_state() at all. Special-casing EIO is just
> > another bug waiting to happen.
> 
> As a tangent, the 'foo is deprecated' warnings for pm_register() and 
> inter_module_register() annoy me, primarily because they never seem to 
> go away.

Warnings are irritating.  Several times I've received obviously buggy
patches which generated warnings which pointed out the bug quite clearly. 
Presumably the originator simply failed to notice the warnings amongst all
the other noise.

Who do I bug about these longstanding ppc64 warnings, btw ;)

drivers/scsi/sata_svw.c: In function `k2_sata_tf_load':
drivers/scsi/sata_svw.c:111: warning: passing arg 2 of `eeh_writeb' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:116: warning: passing arg 2 of `eeh_writew' makes pointer from integer without a cast
drivers/scsi/sata_svw.c:117: warning: passing arg 2 of `eeh_writew' makes pointer from integer without a cast

And these:

drivers/pci/probe.c: In function `pci_read_bases':
drivers/pci/probe.c:168: warning: large integer implicitly truncated to unsigned type 
drivers/pci/probe.c:218: warning: large integer implicitly truncated to unsigned type

And these:

drivers/char/drm/drm_bufs.c: In function `drm_addmap_ioctl':
drivers/char/drm/drm_bufs.c:309: warning: cast to pointer from integer of different size
drivers/char/drm/drm_bufs.c:309: warning: cast to pointer from integer of different size
drivers/char/drm/drm_bufs.c:309: warning: cast to pointer from integer of different size

> The only user of inter_module_xxx is CONFIG_MTD -- thus the deprecated 
> warning is useless to 90% of us, who will never use MTD.

Suggest we either undeprecate it, or remove the darn functions.

And in future, only deprecate functions after all callers have been
removed.

>  As for pm_register(), there are tons of users remaining.

Well it would kinda help if people knew what to _do_ about pm_register(). 
Documentation/pm.txt cheerfully tells everyone how to use it in new code
and the comment over the pm_register() implementation doesn't say that it's
deprecated and doesn't tell people what to replace it with.


