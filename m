Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTFHGaA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264643AbTFHG37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:29:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:32642 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264606AbTFHG37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:29:59 -0400
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
	(take 2)
From: "David S. Miller" <davem@redhat.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
In-Reply-To: <20030608004540.P3232@almesberger.net>
References: <20030606125416.C3232@almesberger.net>
	 <200306062354.h56NsWsG002919@ginger.cmf.nrl.navy.mil>
	 <20030606212026.I3232@almesberger.net>
	 <20030606.235811.39162108.davem@redhat.com>
	 <20030608004540.P3232@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055054601.30054.4.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jun 2003 23:43:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-07 at 20:45, Werner Almesberger wrote:
> Well, that's just the good old broken module API problem again.
> Under the premise that modules can't be fixed, but the world
> around them can, try_module_get is an adequate band-aid for
> this API bug, but I wouldn't apply Kant's formula of universal
> law quite so literally here :-)

Netdevices NO LONGER use module refcounts in any way shape or form. They
are not needed to fix problems of this nature.

They way to fix it is to always dynamically allocate your netdevice
objects, and mark them dead.  The final kfree() of the object can be
deferred until the final reference goes away, and that could be 10 years
from now, it doesn't matter and the module can be unloaded NOW and
without any delay.

-- 
David S. Miller <davem@redhat.com>
