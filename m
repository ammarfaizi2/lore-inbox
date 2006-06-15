Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWFOLEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWFOLEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 07:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWFOLEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 07:04:08 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:18657 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S964992AbWFOLEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 07:04:06 -0400
Date: Thu, 15 Jun 2006 13:03:36 +0200
From: Voluspa <lista1@comhem.se>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, len.brown@intel.com,
       rdreier@cisco.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Message-Id: <20060615130336.176f527c.lista1@comhem.se>
In-Reply-To: <4490B48E.5060304@oracle.com>
References: <20060615010850.3d375fa9.lista1@comhem.se>
	<4490B48E.5060304@oracle.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 18:14:54 -0700 Randy Dunlap wrote:
> updated version:

As a user, it's great if this fixes people's keyboards and mice. But it's
not a panacea. Gkrellm reads CPU temperatures from
/proc/acpi/thermal_zone/*/temperature and that disturbs a time-critical
application like mplayer, both when reading normal video and hacked mms:
sound streams (ogg sound is OK, though):

rtc: lost some interrupts at 1024Hz.
rtc: lost some interrupts at 1024Hz.

The loss frequency is much lower with this patch, by something like an
estimated 5-10 times.

Also, here the notebook's touchpad gets clobbered by temperature reads
when dragging a small xterm window around:

psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: issuing reconnect request
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.

So, here temperature reading stays off even if this patch hits mainline.
Battery reading is fine, strangely enough. Perhaps because I've set
a period of 30 seconds between updates.

Or it might be that a lot of work has gone in regarding acpi BAT...

Mvh
Mats Johannesson
--
