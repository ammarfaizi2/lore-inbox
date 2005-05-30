Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVE3IQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVE3IQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVE3IQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:16:07 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:26244 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261555AbVE3IQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:16:03 -0400
Subject: Re: 2.6.12-rc5-mm1: drivers/usb/atm/speedtch.c: gcc 2.95 compile
	error
From: Duncan Sands <baldrick@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, gregkh@suse.de
In-Reply-To: <20050530010456.242b810e.akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
	 <20050529151231.GE10441@stusta.de>
	 <1117439106.9515.31.camel@localhost.localdomain>
	 <20050530010456.242b810e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 30 May 2005 10:16:01 +0200
Message-Id: <1117440961.9515.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Adrian, it looks like gcc 2.95 doesn't like this kind of macro
> > 
> >  #define atm_info(instance, format, arg...)	\
> >  	atm_printk(KERN_INFO, instance , format , ## arg)
> > 
> >  being called with only two arguments.  I don't know what
> >  the best fix is, but this does the trick:
> 
> Nope.  There's a bug in gcc-2.95.x macro expansion, and here it bites us in
> atm_printk():
> 
> printk(level "ATM dev %d: " format , (instance)->atm_dev->number, ## arg)
> 
> the workaround is to add a space before that final comma:

Yes, this fixes the problem.

Thanks a lot!

Duncan.

