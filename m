Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWJLSZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWJLSZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWJLSZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:25:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbWJLSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:25:19 -0400
Date: Thu, 12 Oct 2006 11:24:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Jeff Garzik <jeff@garzik.org>, dbrownell@users.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SPI: improve sysfs compiler complaint handling
Message-Id: <20061012112449.e9bb7e12.akpm@osdl.org>
In-Reply-To: <200610121108.59727.david-b@pacbell.net>
References: <20061012014920.GA13000@havoc.gtf.org>
	<200610121108.59727.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 11:08:59 -0700
David Brownell <david-b@pacbell.net> wrote:

> On Wednesday 11 October 2006 6:49 pm, Jeff Garzik wrote:
> 
> > The compiler complains, even with the "(void)".
> 
> > -	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);
> 
> Sure seems like a compiler bug to me.

Seems like a kernel bug to me.  Look at device_del() and weep.  It calls
eighty eight things which can fail, some of which randomly return void but
shouldn't, then drops the overall result on the floor.

So if something failed and you come up and reinsert the device or driver
two days later the kernel collapses in a heap and you don't have a clue
why.

You're just a victim of all this.

Who wrote all this stuff, and what were they thinking?
