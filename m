Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTFFXlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTFFXlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:41:06 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:27785 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262358AbTFFXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:41:05 -0400
Message-Id: <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 12:54:16 -0300."
             <20030606125416.C3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 19:52:42 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606125416.C3232@almesberger.net>,Werner Almesberger writes:
>Even with the route, the destination can remain "fixed".
>The VCC only makes sense in the context of the device, which
>is fully visible to the user. (It's different in the case of
>SVCs, but they're managed by a user space demon. Besides, if
>their device goes away, they die too.)

actually i think its a good idea to uncouple the atm
devices and the vcc.  while the vcc is useless w/o the
atm dev, there are quite a few resources tied to the vcc
(via sk side).  not having them seperate orignally led
to the 'nodev' atm device as a place to keep track of 
vcc that are going away.

once the atm device/vcc are uncoupled they can easily be
converted to a net device.  this keeps me from needing to
replicate the net device code (particularly the sysfs
stuff -- or so i hope).   netdevices already have a handy
register/unregister that works (and will keep working).
why would i want to duplicate the net device work?
