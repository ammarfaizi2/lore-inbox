Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265250AbUFAV6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265250AbUFAV6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUFAV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:58:00 -0400
Received: from mail.homelink.ru ([81.9.33.123]:24810 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S265108AbUFAV5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:57:43 -0400
Date: Wed, 2 Jun 2004 01:57:40 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: two patches - request for comments
Message-Id: <20040602015740.3cedd197.zap@homelink.ru>
In-Reply-To: <40BCF3BF.3020202@pobox.com>
References: <20040529012030.795ad27e.zap@homelink.ru>
	<20040528221006.GB13851@kroah.com>
	<20040529124421.28c776cc.zap@homelink.ru>
	<40BCF3BF.3020202@pobox.com>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2004 17:23:11 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Typical Linux usage to an item being registered is
> 	ptr = alloc_foo()
> 	register_foo(ptr)
> 	unregister_foo(ptr)
> 	free_foo()
In this case it is:

register_lcd_device("foo", ...);
...
unregister_lcd_device("foo");

The name is guaranteed to be unique by sysfs design during the whole
device lifetime, and calling unregister_xxx() outside the lifetime brackets
is clearly an error.

> It is quite unusual to unregister based on name.  Pointers are far more 
> likely to be unique, and the programmer is far less likely to screw up 
> the unregister operation.
I understand this, I see why it looks unusual. I'll fix this if it matters.
It'll be something like:

lcd_device = register_lcd_device ("foo", ...);
...
unregister_lcd_device (lcd_device);

However, this extra pointer will take some memory; not much of course.

--
Greetings,
   Andrew
