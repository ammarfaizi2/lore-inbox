Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTFOTlK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbTFOTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:41:10 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:61327 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262818AbTFOTlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:41:09 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: shemminger@osdl.org, greg@kroah.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network hotplug via class_device/kobject
References: <20030613164119.15209934.shemminger@osdl.org>
	<20030615.005055.55726223.davem@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 15 Jun 2003 21:32:38 +0200
In-Reply-To: <20030615.005055.55726223.davem@redhat.com>
Message-ID: <m31xxvgmqx.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    Paranoid about some driver doing something like:
>    	rtnl_lock(); register_netdevice(); unregister_netdevice();
> rtnl_unlock() BOOM
> 
> These sorts of turds exist at least in two places:
> 
> 1) drivers/net/wan/comx.c
> 2) drivers/net/wan/hdlc_fr.c
> 
> But it is pretty clear that these two drivers have been
> tried by nobody in recent years.  They both call into
> {un,}register_netdevice without the RTNL semaphore held.

Not sure about 1), but 2) calls (un)register_netdevice() with rtnl_lock,
from ioctl.
-- 
Krzysztof Halasa
Network Administrator
