Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753057AbWKGUC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbWKGUC5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbWKGUC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:02:57 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:22740 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1753036AbWKGUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:02:56 -0500
From: Wolfgang =?iso-8859-2?q?M=FCes?= <wolfgang@iksw-muees.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: [PATCH 2.6.19-rc4] usb auerswald possible memleak fix
Date: Tue, 7 Nov 2006 21:02:46 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
References: <200611061903.09320.m.kozlowski@tuxland.pl> <200611070031.52051.m.kozlowski@tuxland.pl>
In-Reply-To: <200611070031.52051.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611072102.46447.wolfgang@iksw-muees.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:1c3f630c649b643c232b32cec9bf2e10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz,

On Tuesday 07 November 2006 00:31, Mariusz Kozlowski wrote:
> > 	There is possible memleak in auerbuf_setup(). Fix is to replace
> > kfree() with auerbuf_free(). An argument to usb_free_urb() does not
> > need a check as usb_free_urb() already does that. Not sure if I
> > should send this in two separate patches. The patch is against
> > 2.6.19-rc4 (not -mm).
>
> As I posted the bigger usb_free_urb() patch in another mail this one
> should do only one thing which is to fix possible memory leak in
> auerbuf_setup().
>
> Regards,
>
> 	Mariusz Kozlowski
>
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Signed-off-by: Wolfgang Muees <wolfgang@iksw-muees.de>

> diff -up linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c
> linux-2.6.19-rc4/drivers/usb/misc/auerswald.c ---
> linux-2.6.19-rc4-orig/drivers/usb/misc/auerswald.c  2006-11-06
> 17:08:20.000000000 +0100 +++
> linux-2.6.19-rc4/drivers/usb/misc/auerswald.c     2006-11-07
> 00:26:25.000000000 +0100 @@ -780,7 +780,7 @@ static int auerbuf_setup
> (pauerbufctl_t
>
>  bl_fail:/* not enough memory. Free allocated elements */
>          dbg ("auerbuf_setup: no more memory");
> -       kfree(bep);
> +        auerbuf_free (bep);
>          auerbuf_free_buffers (bcp);
>          return -ENOMEM;
>  }

Many thanks for pointing this out.

regards
Wolfgang
