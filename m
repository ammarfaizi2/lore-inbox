Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVGOXrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVGOXrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 19:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVGOXrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 19:47:52 -0400
Received: from [81.2.110.250] ([81.2.110.250]:50916 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262081AbVGOXrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 19:47:51 -0400
Subject: RE: 2.6.9 chrdev_open: serial_core: uart_open
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: karl malbrain <karl@petzent.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <NDBBKFNEMLJBNHKPPFILIEALCEAA.karl@petzent.com>
References: <NDBBKFNEMLJBNHKPPFILIEALCEAA.karl@petzent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Jul 2005 01:12:48 +0100
Message-Id: <1121472769.23918.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-07-15 at 13:11 -0700, karl malbrain wrote:
> N.b. I don't pretend to understand how uart_change_pm, uart_startup, and
> uart_block_til_ready could ALL be on the call stack.  Uart_open calls them
> sequentially.  Perhaps you might explain how this works?  Thanks, karl m

gcc does smart things including deferring stack cleanup so that it can
turn

	push, push, call, adjust stack, push, push call .. etc

into a sequence with less stack pointer adjustment for performance
reasons. That sometimes fools the traceback code. A good rule of thumb
is to trace the sequence of calls and assume that the last sane sequence
is the one that occurred before the failure.

Alan

