Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275368AbTHSGXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 02:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275372AbTHSGXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 02:23:09 -0400
Received: from f6.mail.ru ([194.67.57.36]:44040 "EHLO f6.mail.ru")
	by vger.kernel.org with ESMTP id S275368AbTHSGXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 02:23:05 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6 - synaptics touchpad not handled by any driver
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Tue, 19 Aug 2003 10:23:06 +0400
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19ozta-0002R3-00.arvidjaar-mail-ru@f6.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appeared recently on a.o.l.m. Synaptics touchpad is not handled
by any driver except evdev. It is located in drivers/input/mouse and
is part of psmouse so one would logically assume it is handled by
mousedev - but it does not advertise any capability accepted by mousedev.

I: Bus=0011 Vendor=0002 Product=0007 Version=0000
N: Name="Synaptics Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
H: Handlers=
B: EV=1b
B: KEY=670000 0 0 0 0 0 0 0 0
B: ABS=1000003
B: MSC=4

the buttons advertised are

BTN_LEFT, BTN_RIGHT, BTN_MIDDLE, BTN_FORWARD, BTN_BACK.

mousedev accepts device with absolute coordinates only if it
advertises BTN_TOUCH:

        {
              .flags    = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_KE
YBIT | INPUT_DEVICE_ID_MATCH_ABSBIT,
              .evbit    = { BIT(EV_KEY) | BIT(EV_ABS) },
              .keybit   = { [LONG(BTN_TOUCH)] = BIT(BTN_TOUCH) },
              .absbit   = { BIT(ABS_X) | BIT(ABS_Y) },
         },/* A tablet like device, at least touch detection, two absolute axes

the same as tsdev.

something is fishy :) poor guy expected it to work like a mouse -
just like 2.4 did.

-andrey

