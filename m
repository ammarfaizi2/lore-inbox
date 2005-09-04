Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVIDXnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVIDXnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVIDXmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:42:10 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:26611 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932139AbVIDXl4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:41:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WecPXO9ZKhsZa7Yr/qY5IOc1qNOKHiwuiYPOFxBdlhZnWnjRQzc95xAAwjthFGnBCfVkn1C8M1zrAXhxZ8ElaHT6UIhYtLp0nSMqBRKVaGl5/bV7yyOl/XXydu7ar986MaO7QEiLli1PfgVc9nWkrCVQSIZrw9vlUt5wLUKopfU=
Message-ID: <29495f1d05090416413caf9043@mail.gmail.com>
Date: Sun, 4 Sep 2005 16:41:50 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [DVB patch 51/54] ttpci: av7110: RC5+ remote control support
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Oliver Endriss <o.endriss@gmx.de>
In-Reply-To: <20050904232336.080662000@abc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232336.080662000@abc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> From: Oliver Endriss <o.endriss@gmx.de>
> 
> Improved remote control support for av7110-based cards:
> o extended rc5 protocol, firmware >= 0x2620 required
> o key-up timer slightly adjusted
> o completely moved remote control code to av7110_ir.c
> o support for multiple ir receivers
> o for now, all av7110 cards share the same ir configuration and event device

<snip>

> --- linux-2.6.13-git4.orig/drivers/media/dvb/ttpci/av7110_ir.c  2005-09-04 22:03:40.000000000 +0200
> +++ linux-2.6.13-git4/drivers/media/dvb/ttpci/av7110_ir.c       2005-09-04 22:31:00.000000000 +0200
> @@ -7,16 +7,16 @@
>  #include <asm/bitops.h>
> 
>  #include "av7110.h"
> +#include "av7110_hw.h"
> 
> -#define UP_TIMEOUT (HZ/4)
> +#define UP_TIMEOUT (HZ*7/25)

<snip>

Should this be

#define UP_TIMEOUT msecs_to_jiffies(280)

or

#define UP_TIMEOUT (7*msecs_to_jiffies(40)

?

Thanks,
Nish
