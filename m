Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRKFNhE>; Tue, 6 Nov 2001 08:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279313AbRKFNgy>; Tue, 6 Nov 2001 08:36:54 -0500
Received: from sushi.toad.net ([162.33.130.105]:51176 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S279250AbRKFNgj>;
	Tue, 6 Nov 2001 08:36:39 -0500
Subject: Re: [PATCH] PnP BIOS support for OPL3-SA1 sound driver
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrey Panin <pazke@orbita1.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 06 Nov 2001 08:35:57 -0500
Message-Id: <1005053761.20873.26.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You define a table of struct pnpbios_device_id's containing
the IDs plus pointers to structs containing info about which
ioports reported by pnpbios do which things.  Okay.

But rather than search for each ID in the table using
pnpbios_find_device(), why not use pnpbios_register_driver()?

To use this, you define a struct pnpbios_driver, which contains among
other things a pointer to your table of struct pnpbios_device_id's
and callback handles for adding ("probing") and removing the device.
You call pnpbios_register_driver() with a pointer to this
struct pnpbios_driver; it searches the devlist and table
for matches and for each one calls the callback function.

--
Thomas

