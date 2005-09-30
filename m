Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVI3HkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVI3HkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVI3HkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:40:13 -0400
Received: from zaphod.dth.net ([85.159.112.10]:4825 "EHLO zaphod.dth.net")
	by vger.kernel.org with ESMTP id S1751098AbVI3HkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:40:11 -0400
Date: Fri, 30 Sep 2005 09:39:58 +0200
From: Danny ter Haar <dth@cistron.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Danny ter Haar <dth@cistron.nl>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-rc2-git7 crashed on amd64 (usenet gateway) after 18 hours
Message-ID: <20050930073958.GA24985@dth.net>
References: <dhinf5$skf$1@news.cistron.nl> <20050930001301.08eeab9d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930001301.08eeab9d.akpm@osdl.org>
x-Message-Flag: Thank you for installing BonziBuddy! Hang on: Processing your temporary internetfiles!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> So we've probably lost the info which will tell us how the problems
> started.  A serial console would be nice.


This is from serial console.
Unfortunatly it's a portmaster2 which has no buffer.
What i do is start a screen, do a telnet to the portmaster
and attach the serial console. I can't go back anyfurther
than this since the output of the new kernel booting replaced it.
Mayby i can tell screen to have more lines of history ?! 

> Are all the failures due to the aic79xx driver failing in this manner?  If
> not then please report the different failures separately, thanks.

So far, all new kernels indeed barfed with scsi errors.
It somehow seems to miss a scsi event and a chain of events occur
which also sometimes lead to shutdown ethernet interfaces.

This is the difference in IRQ settings i talked about earlier:

Linux 2.6.14-rc2-git7 (root@newsgate) (gcc 4.0.2 ) #1 1CPU
irq  0:   3736032 timer                 irq 12:         3
irq  1:         8 i8042                 irq 16:   4519576 aic79xx
irq  4:       449 serial                irq 17:  34901765 aic79xx, eth3
irq  9:         0 acpi                  irq 18:  89100231 acenic

vs

Linux 2.6.12-mm1 (root@newsgate) (gcc 3.3.6 ) #1 Mon Jun 20 11:13:18 CEST 2005 1CPU [newsgate.(none)]
irq  0:   3822422 timer                 irq 12:         3
irq  1:         8 i8042                 irq 16:  82787217 acenic
irq  4:       353 serial                irq 17:   4194166 aic79xx
irq  9:         0 acpi                  irq 18:  28628408 aic79xx, eth3





-- 
Police aren't effective because of their uniforms, badges, guns, or
nightsticks, they're effective because of their radios [seen on /.]
