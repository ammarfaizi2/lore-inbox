Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSKNRiK>; Thu, 14 Nov 2002 12:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbSKNRgi>; Thu, 14 Nov 2002 12:36:38 -0500
Received: from dp.samba.org ([66.70.73.150]:57580 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265096AbSKNRgQ>;
	Thu, 14 Nov 2002 12:36:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug 
In-reply-to: Your message of "Thu, 14 Nov 2002 08:19:20 -0800."
             <3DD3CD08.7080003@pacbell.net> 
Date: Fri, 15 Nov 2002 04:42:11 +1100
Message-Id: <20021114174310.8CFAC2C2A2@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD3CD08.7080003@pacbell.net> you write:
> Consider two instances of such a device.  Hotplug one, the driver
> is loaded, refcount zero since it's not opened.  Then rmmod on
> unplug would be appropriate:  the hardware is gone.
> 
> But instead of unplugging it, plug in a second.  Now rmmod is no
> longer an appropriate default policy on unplug, even though the
> module "refcount" is still zero, since the user could still try
> access the other device.  (Maybe they were plugging in devices
> until they found the one with the data they were after, and just
> hadn't looked at that the other one yet.)

Hmmm, interesting problem.  Perhaps your idea of having drivers hold a
refcount for every device they control makes sense in this case, but
as you point out, it's a significant departure from current policy.

With "rmmod -f" it's not quite reboot time, though.

Anyway, I don't think this is a battle I want to fight 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
