Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267562AbUG3ALN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267562AbUG3ALN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267535AbUG3AJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:09:14 -0400
Received: from mail.homelink.ru ([81.9.33.123]:44719 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S267551AbUG3AGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:06:47 -0400
Date: Fri, 30 Jul 2004 04:06:45 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: John Lenz <jelenz@students.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [2]
Message-Id: <20040730040645.169e4024.zap@homelink.ru>
In-Reply-To: <20040729232547.GA4565@hydra.mshome.net>
References: <20040617223517.59a56c7e.zap@homelink.ru>
	<20040725215917.GA7279@hydra.mshome.net>
	<20040728221141.158d8f14.zap@homelink.ru>
	<20040729232547.GA4565@hydra.mshome.net>
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

On Thu, 29 Jul 2004 18:25:47 -0500
John Lenz <jelenz@students.wisc.edu> wrote:

> Actually, now that I think about it a bit more, I think the  
> lcd_properties->match function should take a device * as a paramater  
> instead of a fb_info *.  Insead of passing the fb_info pointer to the  
> match function, we really should be passing the actual device  
> structure.  For example, in the pxafb driver, it would register the  
> platform_device that it creates with either the class code (if  
> class_match is used) or with the lcdbase code.  This way the lcd driver  
> could examine the device * and look at for example which resources it  
> used, which memory region it was using, etc. and make its decision.
If you look here: http://lkml.org/lkml/2004/6/26/84 you can see that this is
exactly what I was proposing minus your proposal for a more generic
class device match function. I was imagining that it would happen this way:
the framebuffer device during initialization calls lcd_find_device() and
passes his own 'struct device' to it; then lcd_find_device calls the match
function of every previously registered LCD device with this parameter. The
first one that says 'match' is returned. Same about backlight.

I don't see many reasons for a generic class match function. Last but not
least the lcd_find_device() function is very small, so it will be a negligible
gain but a lot of hassle (as you said, framebuffer drivers will have to be
rewritten to not use the simple_class device class).

--
Greetings,
   Andrew
