Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbVKZEue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbVKZEue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 23:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbVKZEue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 23:50:34 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:2642 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932722AbVKZEud convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 23:50:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Fri, 25 Nov 2005 23:50:27 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Marc Koschewski <marc@osknowledge.org>,
       Ed Tomlinson <tomlins@cam.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <200511242220.25702.rjw@sisk.pl> <200511252254.53128.dtor_core@ameritech.net>
In-Reply-To: <200511252254.53128.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511252350.28129.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 22:54, Dmitry Torokhov wrote:
> > Actually, it works on the console (ie with gpm), but X is unable to use it,
> > apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
> > non-mm kernel I've been able to test quickly on this box).
> >
> 
> Rafael,
> 
> does reverting the following patch makes touchpad work?

Or, try dropping this patch on top of -mm.

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/evdev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/input/evdev.c
===================================================================
--- work.orig/drivers/input/evdev.c
+++ work/drivers/input/evdev.c
@@ -205,11 +205,11 @@ static int evdev_event_to_user(const cha
 		compat_event.code = event->code;
 		compat_event.value = event->value;
 
-		if (copy_to_user(&compat_event, buffer, sizeof(struct input_event_compat)))
+		if (copy_to_user(buffer, &compat_event, sizeof(struct input_event_compat)))
 			return -EFAULT;
 
 	} else {
-		if (copy_to_user(event, buffer, sizeof(struct input_event)))
+		if (copy_to_user(buffer, event, sizeof(struct input_event)))
 			return -EFAULT;
 	}
 
