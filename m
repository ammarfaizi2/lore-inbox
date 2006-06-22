Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751861AbWFVRgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbWFVRgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWFVRgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:36:16 -0400
Received: from [212.76.84.205] ([212.76.84.205]:53513 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751856AbWFVRgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:36:10 -0400
From: Al Boldi <a1426z@gawab.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
Date: Thu, 22 Jun 2006 20:36:45 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200606211715.58773.a1426z@gawab.com> <200606220005.32446.a1426z@gawab.com> <4499E89F.6030509@gmail.com>
In-Reply-To: <4499E89F.6030509@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200606222036.45081.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Al Boldi wrote:
> > Antonino A. Daplas wrote:
> >> Al Boldi wrote:
> >>> Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system
> >>> freezes.
> >>>
> >>> Especially, ping 10.1 -A easily causes a complete system hang during
> >>> scroll.
> >>>
> >>> Is there an easy way to fix this, other than disabling the option?
> >>
> >> I can't duplicate your problem. Did it ever work before?
> >
> > This option did not exist before 2.6.17.
>
> I meant if you tried any of the -rc kernels.

If -rc's were additive, I would probably use them.  But they are not :(

> Anyway, can you try the patch below.  It's a debugging patch and
> it will slow down the console.

Yes, that did the trick, although it screws-up concurrent console access.

What is surprising though, is that SOFT_SCROLLBACK is supposed to slow the 
console down.  It actually looks that it speeds things up, albeit at higher 
CPU cost, by buffering screen updates.

This maybe hardware related.  This machine has an onboard VIA/S3 UniChrome 
chip, so I am thinking the CPU is dumping too fast for the chip to sync.

> If the system hang disappears, remove the line
>
>     while (i--);

Hangs again.

> > BTW, is there any chance to patch your savagefb to support VIA/S3
> > UniChrome?
>
> If someone posts a patch to lkml or fbdev-devel, why not?  But a separate
> driver is probably better as the 2 are very different.

VIA has a separate driver, couldn't this be merged with mainline?

Thanks!

--
Al

