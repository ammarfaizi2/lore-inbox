Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUE0Pt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUE0Pt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUE0Pt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:49:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4341 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264822AbUE0Pty
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:49:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Zhu, Yi" <yi.zhu@intel.com>, "Auzanneau Gregory" <mls@reolight.net>
Subject: Re: idebus setup problem (2.6.7-rc1)
Date: Thu, 27 May 2004 17:51:04 +0200
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
References: <3ACA40606221794F80A5670F0AF15F842DB1E0@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F842DB1E0@PDSMSX403.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271751.04788.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 of May 2004 17:21, Zhu, Yi wrote:
> Bartlomiej Zolnierkiewicz [B.Zolnierkiewicz@elka.pw.edu.pl] wrote:
> > I remember seeing patch related to handling '=' in kernel
> > params, maybe it's related (or maybe not).
>
> Yes, this is caused by my kernel-parameter-parsing-fix.patch.
>
> But I think below code in ide.c is a hack.
> __setup("", ide_setup);

It is a really bad hack but unfortunately it is not easy to fix.
We can only do it by introducing new kernel parameters and obsoleting
current braindamage (+ halting boot if obsolete parameter is detected).

Please note that in (very) rare corner cases current breakage can cause
data corruption.

> How about below change?

It breaks all "idex=" and "hdx=" options.
Please take a look at how ide_setup().

> --- linux-2.6.7-rc1-mm1.orig/drivers/ide/ide.c      2004-05-27
> 23:07:59.405138992 +0800
> +++ linux-2.6.7-rc1-mm1/drivers/ide/ide.c   2004-05-27
> 23:09:47.529701560 +0800
> @@ -2459,7 +2459,8 @@ void cleanup_module (void)
>
>  #else /* !MODULE */
>
> -__setup("", ide_setup);
> +__setup("hd", ide_setup);
> +__setup("ide", ide_setup);
>
>  module_init(ide_init);
>
>
> -yi

