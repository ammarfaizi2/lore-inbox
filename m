Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUIAKUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUIAKUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUIAKUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:20:49 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:25535 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S265977AbUIAKUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:20:46 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>, adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Wed, 1 Sep 2004 18:21:06 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
References: <200408312133.40039.ornati@fastwebnet.it> <200409010729.07156.adaplas@hotpop.com> <200409010920.13307.ornati@fastwebnet.it>
In-Reply-To: <200409010920.13307.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409011821.06520.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 15:20, Paolo Ornati wrote:

> Ok, with this patch and CONFIG_FB_3DFX_ACCEL=y the scrolling speed comes
> back (only a bit slower than with 2.6.8.1 without CONFIG_FB_3DFX_ACCEL):
>
> $ time cat MAINTAINERS: ~2.67s

Ok.  However, I'm still wondering at the scrolling speed, it's a bit slower
than what I would expect (I get < 1 second with vesafb which is completely
unaccelerated).  

Did you set info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN?
Do you use the 'nopan' boot option?   

Because if you answer yes to the first question and no to the second, that
means that tdfxfb_pan_display() is probably broken.

BTW, what does fbset -i say, and what's your hardware setup?

>
> Another interesting thing is that if I enable CONFIG_FB_3DFX_ACCEL without
> your patch the screen becomes black and the kernel stop working at boot
> time (when the mode switch happens).

tdfxfb_cursor() is broken, so I disabled that.  It's the reason your machine
hangs at boot time if CONFIG_FB_3DFX_ACCEL is set to y.

Tony



