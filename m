Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVGGFZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVGGFZJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 01:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVGGFZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 01:25:09 -0400
Received: from web81302.mail.yahoo.com ([206.190.37.77]:47449 "HELO
	web81302.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262151AbVGGFZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 01:25:07 -0400
Message-ID: <20050707052506.2345.qmail@web81302.mail.yahoo.com>
Date: Wed, 6 Jul 2005 22:25:06 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: overriding keyboard driver in a module
To: Genadz Batsyan <gbatyan@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200507070341.41095.gbatyan@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Genadz Batsyan <gbatyan@gmx.net> wrote:
> I'm writing a little tool to allow intercepting keyboard events and 
> substituting them with other events / swallowing events / emitting
> additional 
> events on a low level before normal processing by kernel.
> http://kbd-mangler.sourceforge.net/
> 
> Currently to have precedense over the keyboard driver I'm using a patch 
> against drivers/input/keyboard/atkbd.c
> 
> Well, I guess, patching kernel is unthinkable for most linux users, so I 
> thought, maybe there is a way to do it without the kernel patch.
> Is it possible to write a kernel module to intercept keyboard events
> and have precedense over the kernel driver?
> 

You can try opening corresponding event device (/dev/input/eventX),
grabbing it so nobody except for your process would get any events
from the corresponding keyboard (EVIOCGRAB ioctl), and then read
events, mangle them and inject them back into kernel through uinput
driver.

As an additional plus it should work for any keyboard (or rather any
input device), not only PS/2 keyboard.

-- 
Dmitry
