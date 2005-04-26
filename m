Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVDZW6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVDZW6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVDZW6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:58:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:63382 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261832AbVDZW6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:58:14 -0400
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, pfg@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc4 fix for sn_serial.c
References: <200503141132.39284.jbarnes@engr.sgi.com>
	<20050315010358.GF3207@stusta.de>
	<200503150948.03100.jbarnes@engr.sgi.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: This ASIAGO-N-DRIED TOMATO combo would taste a lot better between two
 plastic SIPPER LIDS!
Date: Wed, 27 Apr 2005 00:58:12 +0200
In-Reply-To: <200503150948.03100.jbarnes@engr.sgi.com> (Jesse Barnes's
 message of "Tue, 15 Mar 2005 09:48:02 -0800")
Message-ID: <jesm1dgn7f.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> writes:

> On Monday, March 14, 2005 5:03 pm, Adrian Bunk wrote:
>> > -static struct uart_driver sal_console_uart = {
>> > +struct uart_driver sal_console_uart = {
>> >   .owner = THIS_MODULE,
>> >   .driver_name = "sn_console",
>> >   .dev_name = DEVICE_NAME,
>>
>> Why can't you solve this without making sal_console_uart global?
>
> I think that would mean moving some of the structure initializaiton into an 
> init function somewhere.

Just make the tentative definition static.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6/drivers/serial/sn_console.c.~1~	2005-04-26 14:42:39.994841943 +0200
+++ linux-2.6/drivers/serial/sn_console.c	2005-04-27 00:50:40.301718840 +0200
@@ -821,7 +821,7 @@ static void __init sn_sal_switch_to_inte
 
 static void sn_sal_console_write(struct console *, const char *, unsigned);
 static int __init sn_sal_console_setup(struct console *, char *);
-extern struct uart_driver sal_console_uart;
+static struct uart_driver sal_console_uart;
 extern struct tty_driver *uart_console_device(struct console *, int *);
 
 static struct console sal_console = {

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
