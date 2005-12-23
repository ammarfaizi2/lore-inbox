Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbVLWWyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbVLWWyU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVLWWyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:54:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:46543 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161097AbVLWWtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:24 -0500
Date: Fri, 23 Dec 2005 14:48:41 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dtor@mail.ru, vojtech@suse.cz
Subject: [patch 15/19] [PATCH] Input: fix an OOPS in HID driver
Message-ID: <20051223224841.GO19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-fix-an-OOPS-in-HID-driver.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Dmitry Torokhov <dtor_core@ameritech.net>

This patch fixes an OOPS in HID driver when connecting simulation
devices generating unknown simulation events.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/input/hid-input.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.14.4.orig/drivers/usb/input/hid-input.c
+++ linux-2.6.14.4/drivers/usb/input/hid-input.c
@@ -137,6 +137,7 @@ static void hidinput_configure_usage(str
 			switch (usage->hid & 0xffff) {
 				case 0xba: map_abs(ABS_RUDDER); break;
 				case 0xbb: map_abs(ABS_THROTTLE); break;
+				default:   goto ignore;
 			}
 			break;
 

--
