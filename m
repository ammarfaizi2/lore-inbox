Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUDCOaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 09:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUDCOaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 09:30:23 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:54022 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261757AbUDCOaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 09:30:21 -0500
Date: Sat, 3 Apr 2004 16:30:31 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michael Hunold <m.hunold@gmx.de>, Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
 isolation
Message-Id: <20040403163031.122b5df8.khali@linux-fr.org>
In-Reply-To: <406EBA38.1030203@gmx.de>
References: <40686476.7020603@convergence.de>
	<20040330213418.195dc972.khali@linux-fr.org>
	<406EBA38.1030203@gmx.de>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is where your approach looks slightly better than mine. With my
> > method, backward compatibility isn't provided. However, fixing
> > existing drivers would be rather easy, and I share Greg KH's view
> > that drivers living outside the kernel tree get the pain they
> > deserve.
> 
> 8-) If this is the way to go, I totally agree, even if that means that
> some drivers will fail to work in the beginning.

As the movie goes: "A beginning is a very delicate time."

> Hm, perhaps we should add another method where an adapter can specify 
> the I2C_DRIVERID_*s from the clients it's expecting. The rationale 
> behind this is, that most PCI cards can be identified uniquely by
> their vendor/subvendor ids, so the driver author definately knows
> which i2c clients are on the card and what are expected to be present.
> No need to probe every i2c client.
> 
> What do you think?

I'm a bit surprised because I thought such a function already existed.
After a quick glance I couldn't find it though. This would tend to prove
that the chip driver IDs were never used anywhere (since this is the
only use I can think of for them).

I think I remember Greg was even thinking of getting rid of them.

I'm not sure that the function you propose would be really useful. I
guess that most people don't load i2c chip drivers they don't need. The
class filter you propose, added to the different I2C addresses, should
do the rest.

On the hardware monitoring side, we usually have a detection function in
all chip drivers, which has the responsability to make sure that the
chip is actually one which the driver is supposed to support. I admit
it's not necessarily easy since there is no official ID such as for the
PCI cards. But we do it and in most cases it's efficient. Maybe you
don't have such a mechanism for the video i2c chip drivers? This would
explain why you feel the need of such a function when I do not.

I don't really see where/how such a function be, but if you want to take
a try and propose a patch, I'll take a look.

That said, it seems to be something different from the class bitfields
we were discussing so far, so it would be better to first go on with the
classes, and see the ids later.

Greg, any comment? Is the approach I suggested OK with you, or do you
prefer Michael's one (with the additional flag)?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
