Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316127AbSE3CC0>; Wed, 29 May 2002 22:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316132AbSE3CC0>; Wed, 29 May 2002 22:02:26 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:54778 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316127AbSE3CCY>; Wed, 29 May 2002 22:02:24 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15605.34861.599803.405864@wombat.chubb.wattle.id.au>
Date: Thu, 30 May 2002 12:02:21 +1000
To: linux-kernel@vger.kernel.org
Subject: Strange code in ide_cdrom_register
CC: axboe@sues.de
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	This code snippet in ide_cdrom_register() seems really
strange...

	devinfo->ops = &ide_cdrom_dops;
	devinfo->mask = 0;
>>>	*(int *)&devinfo->speed = CDROM_STATE_FLAGS (drive)->current_speed;
>>>	*(int *)&devinfo->capacity = nslots;
	devinfo->handle = (void *) drive;
	strcpy(devinfo->name, drive->name);

devinfo->speed and devinfo->capacity are both ints.  So the casts are
just a disaster waiting to happen, if the types of capacity or speed
ever change?

Peter C
--
You are lost in a maze of bitkeeper repositories, all slightly different.
