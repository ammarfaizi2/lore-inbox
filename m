Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUGNTPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUGNTPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUGNTPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:15:40 -0400
Received: from mail.homelink.ru ([81.9.33.123]:4268 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S265199AbUGNTOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:14:42 -0400
Date: Wed, 14 Jul 2004 23:14:39 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-Id: <20040714231439.776d7b76.zap@homelink.ru>
In-Reply-To: <20040714061138.GC11803@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru>
	<20040617194739.GA15983@kroah.com>
	<20040618015504.661a50a9.zap@homelink.ru>
	<20040617220510.GA4122@kroah.com>
	<20040618095559.20763766.zap@homelink.ru>
	<20040624213452.GC2477@kroah.com>
	<20040627002152.20e2da7d.zap@homelink.ru>
	<20040714061138.GC11803@kroah.com>
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

On Tue, 13 Jul 2004 23:11:38 -0700
Greg KH <greg@kroah.com> wrote:

> > It's not a question of b/l driver needing the framebuffer driver; it's the
> > other way around: the framebuffer driver needs the b/l drivers (needs so
> > much that it can fail initialization in some cases if it doesn't find the
> > corresponding b/l device).
> Ok, then put a pointer in the fb driver to the backlight.
> And a pointer in the backlight to the fb.  What's wrong with that?
Then arises the same question, but upside down. How the backlight driver will
find the corresponding framebuffer device to put a pointer to himself into?

For example, mediaq 11xx chip can be connected to the PCI bus (apart from the
fact that it can be connected to embedded CPUs directly), so suppose there are
several PCI cards, every card has a LCD connected to it. Now you have a bl/lcd
driver that can drive those LCDs; how you can know which LCD is connected to
which framebuffer? You will have to do the same: examine the device structure
and find the PCI device id, slot number and such - there are simply no other
ways.

So I basically propose the same way - but unified from the bl/lcd driver
perspective: bl/lcd looks at the framebuffer device structure and decides
if it corresponds to the respective device or not. But this operation is
initiated by the framebuffer device, not by bl/lcd, since the bl/lcd
infrastructure already has a list of all bl/lcd drivers.

--
Greetings,
   Andrew
