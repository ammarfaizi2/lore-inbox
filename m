Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUG3UCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUG3UCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUG3UCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:02:11 -0400
Received: from relay1.eltel.net ([195.209.236.38]:31210 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S267807AbUG3UCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:02:08 -0400
Date: Sat, 31 Jul 2004 00:02:05 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: John Lenz <jelenz@students.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-Id: <20040731000205.4b0d8f01.zap@homelink.ru>
In-Reply-To: <20040730004950.GA11828@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru>
	<20040725215917.GA7279@hydra.mshome.net>
	<20040728221141.158d8f14.zap@homelink.ru>
	<20040729232547.GA4565@hydra.mshome.net>
	<20040730040645.169e4024.zap@homelink.ru>
	<20040730004950.GA11828@hydra.mshome.net>
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

On Thu, 29 Jul 2004 19:49:50 -0500
John Lenz <jelenz@students.wisc.edu> wrote:

> The only problem is that what happens if the fb device is registered before
> the lcd device?  So that means you still need to keep around a list of fb
> devices that have been registered so that when a new lcd device is
> registered it can check if it matches an old fb device.
Right now it happens in a different way. The patch I've published earlier uses
notifier objects (linux/notifier.h) so that if framebuffer can't find the
matched lcd device, it registers to be notified when new lcd devices appear in
the system; when it does it proceeds like usual (e.g. calls lcd_device_find).
Until it finds the LCD device framebuffer device cannot even initialize
(without powering on the LCD controller in some circumstances it's impossible
to do anything useful).

> The only advantage is we let the core class code take care of managing the 2
> lists of devices for us (which it is doing anyway).
These lists are anyway maintained by the class.c core. You just need a pointer
to the 'struct class' variable for classes you are interested in, and locking
also comes for free - everything is already implemented. Look in class.c for
list_for_each_entry macros - they all are traveling along these lists.

I personally don't like to make this device matching too generalized - if we
need it for b/l, that's fine, we'll have to implement it for b/l.
But it doesn't look too sane, so I'd rather leave it l/b specific.

--
Greetings,
   Andrew
