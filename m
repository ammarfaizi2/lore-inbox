Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTJaH6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJaH6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:58:25 -0500
Received: from f20.mail.ru ([194.67.57.52]:34318 "EHLO f20.mail.ru")
	by vger.kernel.org with ESMTP id S263064AbTJaH6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:58:24 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Shawn Willden=?koi8-r?Q?=22=20?= 
	<shawn-lkml@willden.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/input/mice doesn't work in test9=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [212.30.182.96]
Date: Fri, 31 Oct 2003 11:03:43 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AFUFz-0008jt-00.arvidjaar-mail-ru@f20.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm sure I'm just missing something stupid, but google doesn't seem to turn 
> up anything, so...

> I'm trying to use 2.6.0-test9 on a machine with a USB mouse.  With 2.4, I 
> have X configured to use /dev/input/mice (c 13 63) as my mouse pointer, 
> and it works great.  With test9, XFree86 fails to start because it can't 
> open the mouse.  The error is "xf86OpenSerial: Cannot open device /dev/
> input/mice  No such device.".

> 'cat /dev/input/mice' also gives me "No such device".

> /dev/input/mouse0 (c 13 32) doesn't work either.

> I believe all of the relevant modules are loaded and the light on my 
> optical mouse is lit, indicating that it has been powered by the usbmouse 
> driver (as I understand it).

You are missing mousedev that is the driver that actually provides
/dev/input/mice. usbmouse (which is actually redundand with hid) speaks
with hardware and mousedev speaks with user :)

The whole input subsystem has changed between 2.4 and 2.6. Unfortunately,
input sysbsystem hotplugging is not currently implemented. Your best bet
is to forcibly load mousedev during boot. Alternatively look into hotplug
for usermap, it allows provide fake mapping for modules - you could add
mapping from UDB IDs of oyur mouse to mousedev. Loading it statically is
likely to be more simple.

regards

-andrey
