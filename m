Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272288AbTHMMEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272011AbTHMMEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:04:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:49335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271904AbTHMMEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:04:20 -0400
Date: Wed, 13 Aug 2003 05:04:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, zwane@commfireservices.com,
       linux-sound@vger.kernel.org
Subject: Re: OPL3SA2: spin_is_locked on uninitialized spinlock
Message-Id: <20030813050448.221aaa49.akpm@osdl.org>
In-Reply-To: <1060774796.3518.4.camel@teapot.felipe-alfaro.com>
References: <1060774796.3518.4.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> I've found a lot of errors like this when loading the OPL3SA2 sound
>  driver on my old Intel AL440LX computer, running 2.6.0-test3-mm1:
> 
>  sound/isa/opl3sa2.c:204: spin_is_locked on uninitialized spinlock
>  d6200034.

Does this help?

diff -puN sound/isa/opl3sa2.c~opl3sa2-lock-init-fix sound/isa/opl3sa2.c
--- 25/sound/isa/opl3sa2.c~opl3sa2-lock-init-fix	2003-08-13 05:03:32.000000000 -0700
+++ 25-akpm/sound/isa/opl3sa2.c	2003-08-13 05:04:06.000000000 -0700
@@ -752,6 +752,7 @@ static int __devinit snd_opl3sa2_probe(i
 		err = -ENOMEM;
 		goto __error;
 	}
+	spin_lock_init(&chip->reg_lock);
 	chip->irq = -1;
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
 		goto __error;

_

