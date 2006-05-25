Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbWEYR0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWEYR0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWEYR0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:26:52 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:41477 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1030225AbWEYR0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:26:52 -0400
Date: Thu, 25 May 2006 19:26:57 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>
Cc: Ismail Donme <izsmail@pardus.org.tr>, LKML <linux-kernel@vger.kernel.org>,
       lm-sensors@lm-sensors.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] scx200_acb: fix section mismatch warning
Message-Id: <20060525192657.081c8c11.khali@linux-fr.org>
In-Reply-To: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
References: <20060525100138.cb9e53c5.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy, all,

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix section mismatch warning reported by İsmail Dönmez:
> WARNING: drivers/i2c/busses/scx200_acb.o - Section mismatch: reference
> to .init.text: from .text after 'scx200_add_cs553x' (at offset 0x528)
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> ---
>  drivers/i2c/busses/scx200_acb.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2617-rc5.orig/drivers/i2c/busses/scx200_acb.c
> +++ linux-2617-rc5/drivers/i2c/busses/scx200_acb.c
> @@ -491,7 +491,7 @@ static struct pci_device_id divil_pci[] 
>  
>  #define MSR_LBAR_SMB		0x5140000B
>  
> -static int scx200_add_cs553x(void)
> +static __init int scx200_add_cs553x(void)
>  {
>  	u32	low, hi;
>  	u32	smb_base;
> 

Correct, I sent exactly the same patch to the the lm-sensors list and
Greg KH yesterday:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-May/016213.html

So this one is
Signed-off-by: Jean Delvare <khali@linux-fr.org>

Note that the section mismatch is harmless here (we have a non-__init
function sandwiched between two __init functions) but nevertheless this
kind of warning is never welcome in a final kernel release so let's get
the fix merged now.

Andrew, can you please push this to Linus?

Thanks,
-- 
Jean Delvare
