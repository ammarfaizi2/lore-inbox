Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFOHlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTFOHlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:41:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21700 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261989AbTFOHlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:41:06 -0400
Date: Sun, 15 Jun 2003 00:50:55 -0700 (PDT)
Message-Id: <20030615.005055.55726223.davem@redhat.com>
To: shemminger@osdl.org
Cc: greg@kroah.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] network hotplug via class_device/kobject
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030613164119.15209934.shemminger@osdl.org>
References: <20030613164119.15209934.shemminger@osdl.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: Fri, 13 Jun 2003 16:41:19 -0700

   This patch changes network devices to run hotplug out of the
   kobject/class_device infrastructure rather than calling it from the
   network core. The code gets simpler and there is only one place for
   Greg to fix when he changes the API ;-)

I'll apply this patch, looks fine.
   
   Paranoid about some driver doing something like:
   	rtnl_lock(); register_netdevice(); unregister_netdevice(); rtnl_unlock() BOOM

These sorts of turds exist at least in two places:

1) drivers/net/wan/comx.c
2) drivers/net/wan/hdlc_fr.c

But it is pretty clear that these two drivers have been
tried by nobody in recent years.  They both call into
{un,}register_netdevice without the RTNL semaphore held.
