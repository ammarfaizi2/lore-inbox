Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbUKIJlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUKIJlf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbUKIJle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:41:34 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:53009 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261459AbUKIJfJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:35:09 -0500
Date: Tue, 9 Nov 2004 10:29:00 +0100 (CET)
To: greg@kroah.com, akpm@osdl.org
Subject: Re: [BK PATCH] I2C update for 2.6.10-rc1
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <vYBFH9gE.1099992539.9943000.khali@gcu.info>
In-Reply-To: <20041109052229.GA5117@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

>Greg Kroah-Hartman:
>  o I2C: delete normal_i2c_range logic from sensors as there are no more
>         users
>  o I2C: moved from all sensor drivers from normal_i2c_range to normal_i2c
>  o I2C: fix i2c_detect to allow NULL fields in adapter address structure
>  o I2C: remove normal_isa_range from I2C sensor drivers, as it's not used
>  o I2C: remove ignore_range from I2C sensor drivers, as it's not used
>  o I2C: remove probe_range from I2C sensor drivers, as it's not used

I'm very happy with that :) A documentation update will be needed though.

Also, while we're at it, is there any reason why I2C_CLIENT_END and
I2C_CLIENT_ISA_END are two different constants? We could probably go
with 0xffff (or 0xfffd if you don't like 0xffff) for both. We never saw
a non-even-aligned ISA address anyway, did we? Just a though anyway, I
agree it doesn't matter much.

As a side note, I could never understand why the I2C-ISA kind of
emulation was implemented the way it is. It could make sense if the
clients really didn't know that they are accessing the ISA bus. It's
not the case though, clients are accessing the ISA I/O space directly.
The i2c-isa driver is almost empty. Client drivers with both I2C and ISA
bus accesses (lm78, w83781d, it87) are a mess. I understand that the
original idea was to avoid code duplication for chips supporting both
bus interfaces, but in the end the benefit is questionable. In
particular, people only using ISA chips have to bear the overhead of the
whole I2C subsystem with little benefit. There must be a better way.
Greg, do you have plans to clean it up? I can think of two completely
different approaches, either a true i2c-isa emulation, or a complete
separation of the ISA stuff. We may consider different approaches for
I2C+ISA chips and ISA only chips, by the way.

Thanks,
Jean
