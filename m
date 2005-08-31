Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVHaTAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVHaTAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVHaTAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:00:34 -0400
Received: from asia.telenet-ops.be ([195.130.132.59]:19688 "EHLO
	asia.telenet-ops.be") by vger.kernel.org with ESMTP id S932518AbVHaTAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:00:33 -0400
Date: Wed, 31 Aug 2005 21:00:23 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Fw: suspicious behaviour in pcwd driver.
Message-ID: <20050831190023.GM19487@infomag.infomag.iguana.be>
References: <20050822143228.7bc145f0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050822143228.7bc145f0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> drivers/char/watchdog/pcwd.c does this if it detects
> a temperature out of range..
> 
>             if (temp_panic) {
>                 printk (KERN_INFO PFX "Temperature overheat trip!\n");
>                 machine_power_off();
>             }
> 
> Two problems here are..
> 
> 1. machine_power_off() isn't exported on ppc64. (patch below)
> 2. that printk will never hit the logs, so the admin will just find
> a powered off box with no idea what happened.
> Should we at least sync block devices before doing the power off ?

First you need to enable the "temp_panic" by setting the WDIOS_TEMPPANIC 
option flag. (I'm curious who actually uses this and when they use this, but 
that is something totally different). And then you need to read the card's
status before this piece of code will be triggered.
So in my opinion this isn't used a lott and is simply an option to protect 
your hardware. But your comment is valid: chances that the warning is written 
to the log files is very small.
So I think that it might indeed be better to sync most devices if that can be 
done in a few seconds...

Greetings,
Wim.

