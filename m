Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUIBMUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUIBMUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUIBMUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:20:00 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:54495 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268269AbUIBMT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:19:57 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Paolo Ornati <ornati@fastwebnet.it>
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Thu, 2 Sep 2004 20:20:18 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409020410.22617.adaplas@hotpop.com> <200409021123.26299.ornati@fastwebnet.it>
In-Reply-To: <200409021123.26299.ornati@fastwebnet.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409022020.19062.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 17:23, Paolo Ornati wrote:
> > Try doing an fbset -vyres 800, then keep doubling the number until
> > you get the artifacts.  If possible, do it for other bpp.
>
> Doing some tests I've discovered that BPP doesn't influence this behavior
> (kernel 2.6.9-rc1 + your patch, CONFIG_FB_3DFX_ACCEL=y):
>
> BPP   800    1600    3200    6400	<-- VYRES
> 8         OK       OK       OK       X
> 16       OK       OK       OK       X
> 24       OK       OK       OK       X
> 32       OK       OK       OK       X
>
> The upper limit for VYRES (after a lot of tests) seems to be around
> 4100/4200 (with 4100 all seems OK while with 4200 there are some
> corruptions). This is the same for all BPP.

Ok, on driver load, we'll just set vyres to 4096 if accel is enabled, and
maximum if accel is disabled, until someone with more intimate knowledge of
the hardware provides a definitive fix. Still, if the user so chooses, fbset
can still be used to adjust vyres to any value. 

Just to finalize everything, 2 more things:

1. Does changing the resolution affect the vyres upper limit?

2. What happens if you comment out banshee_wait_idle in tdfxfb_fillrect,
tdfxfb_copyarea and tdfxfb_imageblit?  Scrolling should go faster but will
removing it cause additional screen corruption?

>
> I don't understand why I have this problem only with
> CONFIG_FB_3DFX_ACCEL=y...

No idea.  But I've seen this particular problem with several cards when 2D
acceleration is enabled, so it's not unique to tdfxfb. In one case, this
was caused by an upper limit to the clipping rectangle, and in another, was
due to the rendering and display pipeline being shared.

Tony


