Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSHDSy6>; Sun, 4 Aug 2002 14:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318171AbSHDSy6>; Sun, 4 Aug 2002 14:54:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:65509 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S318168AbSHDSy5>;
	Sun, 4 Aug 2002 14:54:57 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 4 Aug 2002 20:58:23 +0200 (MEST)
Message-Id: <UTC200208041858.g74IwNr05640.aeb@smtp.cwi.nl>
To: greg@kroah.com
Subject: usb devicefs flaw
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/usb/core/usb.c the routine usb_alloc_dev() will
set the devpath for the root hub to "/".
Then usb_find_drivers() constructs a filename used by driverfs
using

                sprintf (&interface->dev.bus_id[0], "%s-%s:%d",
                         dev->bus->bus_name, dev->devpath,
                         interface->altsetting->bInterfaceNumber);

This leads to filenames like "00:07.2-/:0" with embedded '/'.

Andries
