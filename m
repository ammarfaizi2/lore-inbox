Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTF3H4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTF3H4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:56:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53451 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264477AbTF3H4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:56:20 -0400
Date: Mon, 30 Jun 2003 01:03:37 -0700 (PDT)
Message-Id: <20030630.010337.74723316.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: rol@as2917.net, cfriesen@nortelnetworks.com, paulus@samba.org,
       linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [BUG]: problem when shutting down ppp connection since 2.5.70
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030630090507.A32593@flint.arm.linux.org.uk>
References: <3EFFA1EA.7090502@nortelnetworks.com>
	<005e01c33ecd$e20ce6e0$4100a8c0@witbe>
	<20030630090507.A32593@flint.arm.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Mon, 30 Jun 2003 09:05:07 +0100
   
   People with PCMCIA cards have been reporting the same thing.  It sounds
   like something's up with the netdev layer, and it has persisted until
   2.5.73 thus far.

If there are bugs in pcmcia drivers, they are _really_ going to show
now.  The change is that 'rmmod' is allowed even if the device is
"up".  We don't grab/drop module reference counts when the device is
brought up/down.  We simply "down" up net devices at
unregister_netdevice() time.

So if a device is racey, it's going to be "really" racey now.

If people mention which devices give the problems (with current
kernels, we've fixed a lot of bugs as of late) the drivers can
be audited for register/unregister bugs.

