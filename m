Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbSLJWsV>; Tue, 10 Dec 2002 17:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbSLJWsU>; Tue, 10 Dec 2002 17:48:20 -0500
Received: from h-64-105-35-2.SNVACAID.covad.net ([64.105.35.2]:45456 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266959AbSLJWsT>; Tue, 10 Dec 2002 17:48:19 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 10 Dec 2002 14:55:36 -0800
Message-Id: <200212102255.OAA00649@baldur.yggdrasil.com>
To: bwindle@fint.org
Subject: Re: [2.5.51] unknown field 'driver_data' compiling cs4243
Cc: ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle writes:
>I'm getting an error compiling cs4232 in 2.5.51. It built fine in 50-bk6.
[...]
>sound/oss/cs4232.c:361: unknown field `driver_data' specified in initializer
[etc.]

	This is not due to the change that I submitted removing
driver_data from struct pci_dev, although it looks like a similar change
for isapnp devices.  I started to make a change to convert
the references to driver_data to
dev_set_drvdata(&isapnpdev->dev,...) and dev_get_drvdata(&isapnpdev->dev),
but got a little confused by the multiple classes of isapnp drivers:

	Driver structure	Device structure	ID structure

include/linux/isapnp.h:
	isapnp_driver		pci_dev			isapnp_device_id
	(none)			pci_bus			isapnp_card_id

include/linux/pnp.h:
	pnpc_driver		pnp_card		pnp_card_id
	pnp_driver		pnp_dev			pnp_id


	From ChangeLog-2.5.51, I see mention of isapnp changes
associated with Adam Belay.  So, I'm cc'ing him as he is probably
much better qualified to explain.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
