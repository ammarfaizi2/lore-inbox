Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269596AbUISEtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269596AbUISEtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 00:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269626AbUISEto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 00:49:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:35255 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269596AbUISEt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 00:49:26 -0400
Subject: Re: Design for setting video modes, ownership of sysfs attributes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mike Mestnik <cheako911@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091815125ef78738@mail.gmail.com>
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040918195807.18874.qmail@web11906.mail.yahoo.com>
	 <9e47339104091815125ef78738@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095569317.6670.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 14:48:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 08:12, Jon Smirl wrote:

> I'm still undecided if there needs to be a root priv daemon caching
> the EDID and polling for a monitor change. EDID can be regenerated on
> each request to change mode but it takes a few seconds. The root priv
> daemon will dynamically link to card specific libraries. Initially I'm
> going to add the functions to the mesa libraries but they may get
> broken out later.

I'd rather have the kernel driver do the actual probing and provide
the EDID or other infos for non-EDID capable monitors to userland (via
hotplug maybe ?), though userland can then of course decide to
"override" it and it's still userland that decodes it etc....

There are various cases of HW hackery involved in proper monitor
detection that I'd rather not see in userland anymore. Also, some cards
may provide an interrupt for detecting connector state change.

> > There is another thing I can't see.  Why can't the module for the drm
> > create fb[0-9]* devices, one for each monitor?  This would seam to solve
> > the problem with having another app and ioctl(API).
> 
> The DRM driver I'm working on already creates one DRM device for each
> head. Doing this also creates a sysfs entry for each head too. Each
> head has it's own mode/modes attributes.
> 
> Another item is merged fb. Initially heads will be unowned. Logging
> into a head makes you the owner. If you ask for the modes available on
> your head the list will also contain merged fb mode. If you set a
> merged fb mode, the login process on the secondary screen needs to be
> killed. If some one is logged into the secondary head merged fb modes
> won't be in the list. This scheme has the nice side effect of making
> all heads equal, there is no separate controlling device for the card.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

