Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUBQK1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 05:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUBQK1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 05:27:37 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:36107 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264542AbUBQK1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 05:27:36 -0500
Date: Tue, 17 Feb 2004 21:27:32 +1100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gibbs@scsiguy.com
Subject: [BUG] AIC7*** SMP deadlock in ahc_linux_free_device
Message-ID: <20040217102732.GA21221@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

This bug was discovered by Alex Samad.

The del_timer_sync call in ahc_linux_free_device added in 2.5.67
leads to an SMP deadlock when the function is called from the timer
itself in ahc_linux_dev_timed_unfreeze.

I haven't dug too deeply but it seems that there are also possible
races where ahc_linux_free_device can be called twice on the same
dev.  Once from the timer and then again from a non-timer location.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
