Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUE3Uu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUE3Uu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 16:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUE3Uu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 16:50:58 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21632 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264368AbUE3Uu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 16:50:56 -0400
Date: Sun, 30 May 2004 22:51:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>, tuukkat@ee.oulu.fi
Subject: Re: SERIO_USERDEV patch for 2.6
Message-ID: <20040530205119.GD1971@ucw.cz>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <200405301009.21202.dtor_core@ameritech.net> <20040530155821.GC1479@ucw.cz> <200405301116.31356.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405301116.31356.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 11:16:31AM -0500, Dmitry Torokhov wrote:

> Well, my argument is that we only have immediate need for raw access to 
> PC-style AUX ports because of wide variety of connected devices. Serial
> ports have other historical means of accessing them, busmice ports have
> well known devices attached.

Busmice don't even have a byte-oriented protocol, so they're not
relevant here, and indeed for serial ports we can use ttyS.

Now there are a few drivers for the KBD/AUX interface that are not
i8042-based - most drivers in the serio directory. Those all would need
to be patched for enabling raw mode.

> Once we have sysfs integration in place I imagine we will be able to
> implement dynamic binding of serio drivers and ports, atkbd and psmouse
> being default ones and user will be able to rebind a specific port to
> let's say serio-raw or some other driver that does not have automatic
> hardware detection yet.

If we can do that reasonably easily via sysfs, then I'm all for that
route.

> But in the meantime marking several ports raw will allow most of the users
> use old means of communicating with their pointing devices without too
> much effort.

It'd be good to find out what devices we don't support yet (I know of
ALPS, which we have a patch pending for and IBM TouchPoints), too. 

As an interim solution, your patch plus a simple serio->userspace driver
would work, too.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
