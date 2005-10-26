Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbVJZU64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVJZU64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVJZU64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:58:56 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:24461 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964822AbVJZU6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:58:55 -0400
Message-ID: <435FEF26.4050902@t-online.de>
Date: Wed, 26 Oct 2005 23:03:34 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: alessandro.suardi@gmail.com
CC: airlied@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: X unkillable in R state sometimes on startx , /proc/sysrq-trigger
 T output attached
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: EABtbyZHre48BqyN1rMcXWm8C8VmOF0V2shOF5XVFJXkLkIlYH21EZ@t-dialin.net
X-TOI-MSGID: 803776e2-0a2e-4bfe-9c13-e923dacd7d15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two months ago I started a thread

    BUG: fb_imageblit called before fb_check_var and fb_set_par function

in the Linux-fbdev-devel mailing list. I found that the accelerated 
imageblit
function of a framebuffer driver might be called before the graphics 
engine is
initialized ... normally that happens in the fb_set_par function. For 
cyblafb
I solved the problem by extending the fb_sync function to include a call 
to the
graphics engine init function after a short timeout, but the problem is 
still
present in all recent kernels. It might be argued that this is not a 
kernel bug
but a problem of  X - have a look at the Linux-fbdevel thread.

Does X start reliably without a linux framebuffer driver?
Does X start reliably with vesafb?

If the answer is "yes", then have a look at the radeonfb sync function.
After a short timeout, assume that an erroneous X driver disabled mmio,
so (re)enable mmio  and (re)init the graphics engine.

cu,
 knut

