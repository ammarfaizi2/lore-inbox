Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUBPX0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266076AbUBPX0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:26:18 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:14694 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266034AbUBPX0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:26:12 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.3-rc3 serial console woes 
In-reply-to: Your message of "Tue, 17 Feb 2004 08:05:54 +1100."
             <8778.1076965554@ocs3.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Feb 2004 10:25:10 +1100
Message-ID: <2719.1076973910@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004 08:05:54 +1100, 
Keith Owens <kaos@sgi.com> wrote:
>On Mon, 16 Feb 2004 12:07:56 -0700, 
>Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>>Hmm....  I suspect the problem is that serial8250_isa_init_ports()
>>doesn't initialize port->type for the ports in SERIAL_PORT_DFNS,
>>so we fail the console setup.
>>===== drivers/serial/8250.c 1.44 vs edited =====
>>--- 1.44/drivers/serial/8250.c	Fri Feb 13 08:19:33 2004
>>+++ edited/drivers/serial/8250.c	Mon Feb 16 12:03:06 2004
>>@@ -1976,7 +1976,7 @@
>> 	if (co->index >= UART_NR)
>> 		co->index = 0;
>> 	port = &serial8250_ports[co->index].port;
>>-	if (port->type == PORT_UNKNOWN)
>>+	if (!port->ops)
>> 		return -ENODEV;
>> 
>> 	/*
>
>Works for me on i386.

Spoke too soon.  That one line patch makes the serial console available
early in boot.  But as soon as /sbin/init runs, the console is
gibberish due to a speed mismatch.  Completely reverting

  http://linux.bkbits.net:8080/linux-2.5/cset@1.1653?nav=index.html|ChangeSet@-7d

works fine.  Since this is a -rc kernel, can we revert the cset until
it is fixed?

