Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUBJTvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUBJTvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:51:10 -0500
Received: from proxy.quengel.org ([213.146.113.159]:44928 "EHLO
	gerlin1.hsp-law.de") by vger.kernel.org with ESMTP id S266206AbUBJTui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:50:38 -0500
To: Takashi Iwai <tiwai@suse.de>
Cc: Lenar =?iso-8859-1?q?L=F5hmus?= <lenar@vision.ee>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: irq 7: nobody cared! (intel8x0 sound / 2.6.2-rc3-mm1)
References: <4023BEA8.5060306@vision.ee> <s5hd68o2ia7.wl@alsa2.suse.de>
	<4029143B.30408@vision.ee> <s5hvfmebvr4.wl@alsa2.suse.de>
From: Ralf Gerbig <rge-news@quengel.org>
Date: 10 Feb 2004 20:50:35 +0100
In-Reply-To: <s5hvfmebvr4.wl@alsa2.suse.de>
Message-ID: <m3hdxyyar8.fsf-news@hsp-law.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moins,

* On Tue, 10 Feb 2004 20:05:35 +0100, Takashi Iwai <tiwai@suse.de> said:

> ok then really some unknown status bits are set.
> the attached patch should fix this problem anyway.

> --- linux/sound/pci/intel8x0.c	6 Feb 2004 17:47:49 -0000	1.115
> +++ linux/sound/pci/intel8x0.c	10 Feb 2004 19:03:43 -0000
> @@ -807,7 +807,7 @@
>  		if (status)
>  			iputdword(chip, chip->int_sta_reg, status);
>  		spin_unlock(&chip->reg_lock);
> -		return IRQ_NONE;
> +		return IRQ_HANDLED(status);

did not compile, tried 

                return IRQ_RETVAL(status);

instead. Works, but I get 150,000 interrupts/s even without playing any
sound.

thanks,

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
