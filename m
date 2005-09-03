Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbVICJAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbVICJAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 05:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVICJAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 05:00:23 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48146 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751206AbVICJAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 05:00:22 -0400
Date: Sat, 3 Sep 2005 10:00:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVAL] Runtime linkage fix for serial_cs
Message-ID: <20050903100010.A29708@flint.arm.linux.org.uk>
Mail-Followup-To: Takeharu KATO <takeharu1219@ybb.ne.jp>,
	trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
References: <43196393.2040801@ybb.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43196393.2040801@ybb.ne.jp>; from takeharu1219@ybb.ne.jp on Sat, Sep 03, 2005 at 05:49:23PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 05:49:23PM +0900, Takeharu KATO wrote:
> I found current serial_cs driver can not be loaded into the kernel.
> The reason of this issue is serial_cs driver uses serial8250_unregister_port
> function which is not exported for modules.

Your kernel sources are buggy.  This function is exported.

> I fixed the issue, please apply this patch.

This is not a fix - unregister_serial() must not be used with ports
registered with serial8250_register_port(), and in fact
unregister_serial() no longer exists.

You need to find out why your tree doesn't export
serial8250_unregister_port().  Mis-merged patch maybe?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
