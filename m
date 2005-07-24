Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVGXXCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVGXXCS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 19:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVGXXCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 19:02:17 -0400
Received: from tim.rpsys.net ([194.106.48.114]:11960 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261488AbVGXXCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 19:02:16 -0400
Subject: Re: [patch] fix compilation in collie.c
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050724233503.C20019@flint.arm.linux.org.uk>
References: <20050721052527.GC7849@elf.ucw.cz>
	 <20050724233503.C20019@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 00:02:04 +0100
Message-Id: <1122246124.7585.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-24 at 23:35 +0100, Russell King wrote:
> I'd like John (or someone) to look at this.  I'm particularly worred
> about:
> 
> 1. passing NULL into (read|write)_scoop_reg() - which use dev_get_drvdata()
>    on this.  Given the choice between creating code which will definitely
>    oops but not error or warn vs not compiling, I'll take not compiling
>    any day.

They should read write_scoop_reg(&colliescoop_device.dev, ...); in this
case. 

There is a similar problem with drivers/input/keyboard/corgikbd.c for
which the patch has been in the input maintainer's queue for months :-(.

> 2. whether this is supposed to be using the sharp chip driver rather
>    than the cfi stuff.

I think the aim was to use the cfi code but there were problems with it
not working so the sharp chip driver was being used in the meantime.
John will hopefully be able to comment more about this.

Richard

