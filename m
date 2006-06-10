Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWFJLN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWFJLN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 07:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWFJLN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 07:13:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:7565 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751485AbWFJLN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 07:13:57 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 3/5] VT binding: Update fbcon to support binding
Date: Sat, 10 Jun 2006 13:10:02 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <448933EB.3070003@gmail.com>
In-Reply-To: <448933EB.3070003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606101310.04174.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antonio,

On Friday, 9. June 2006 10:40, Antonino A. Daplas wrote:
>     5. When fbcon is completely unbound from the console layer, fbcon will
>        also release (iow, decrement module reference counts to zero) all fbdev
>        drivers. In other words, a bind or unbind request from the console layer
>        will propagate down to the framebuffer drivers.
> 
>     6. If fbcon is not bound to the console, it will ignore all notifier
>        events (except driver registration and unregistration) and all sysfs
>        requests.

Wow! 

Now one can:

	- implement different framebuffer drivers for a chip. 
	- try a stable and development version without rebooting,
	- have probing with user interaction ("if you see me please 
	  press enter else I will try the previous driver in 15 seconds.") 
	  instead of deciding on "failsafe" (vga/vesa) and "fast" 
	  (special driver) at boot.

I love it!

Just the take_over_console() as alternative API looks strange. 

It's ok as an intermeditate step (likely, if I remember the discussions
correctly). If it should stay, it should require the console to 
be registered first. 

Can be changed later, once as you make progress and don't reach a release
kernel. This is NO show stopper for me.

Progress is the most important thing for development in this areas 
until it reaches a release kernel.


Regards

Ingo Oeser
