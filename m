Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUBPXrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBPXrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:47:03 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:54739 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S265998AbUBPXpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:45:24 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.6.3-rc3 serial console woes
Date: Mon, 16 Feb 2004 16:45:14 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
References: <2719.1076973910@kao2.melbourne.sgi.com>
In-Reply-To: <2719.1076973910@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402161645.14151.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 February 2004 4:25 pm, Keith Owens wrote:
> Spoke too soon.  That one line patch makes the serial console available
> early in boot.  But as soon as /sbin/init runs, the console is
> gibberish due to a speed mismatch.  Completely reverting
> 
>   http://linux.bkbits.net:8080/linux-2.5/cset@1.1653?nav=index.html|ChangeSet@-7d
> 
> works fine.  Since this is a -rc kernel, can we revert the cset until
> it is fixed?

Reverting for now sounds like the right thing to me.  I would like to
understand what's going on, though.

For the serial console to work early, serial8250_console_setup() must
be returning zero.  So we can't be taking this return:

	if (!port->ops)
		return -ENODEV;

and therefore, the hunk in serial_core.c shouldn't have any effect either.
So is it merely the fact that we call serial8250_late_console_init()?

I wouldn't expect that to make any difference, because the setup()
call from serial8250_console_init() should have succeeded, so
CON_ENABLED should have been set, and we don't do anything in
that case.

Keith, can you tell me how to reproduce this?

Bjorn

