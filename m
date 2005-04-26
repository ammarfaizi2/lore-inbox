Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbVDZXJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbVDZXJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 19:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVDZXJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 19:09:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261840AbVDZXJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 19:09:13 -0400
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, pfg@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc4 fix for sn_serial.c
References: <200503141132.39284.jbarnes@engr.sgi.com>
	<20050315010358.GF3207@stusta.de>
	<200503150948.03100.jbarnes@engr.sgi.com>
	<jesm1dgn7f.fsf@sykes.suse.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: QUIET!!  I'm being CREATIVE!!  Is it GREAT yet?  It's s'posed to
 SMOKEY THE BEAR...
Date: Wed, 27 Apr 2005 01:09:11 +0200
In-Reply-To: <jesm1dgn7f.fsf@sykes.suse.de> (Andreas Schwab's message of
 "Wed, 27 Apr 2005 00:58:12 +0200")
Message-ID: <jeoec1gmp4.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> Jesse Barnes <jbarnes@engr.sgi.com> writes:
>
>> On Monday, March 14, 2005 5:03 pm, Adrian Bunk wrote:
>>> > -static struct uart_driver sal_console_uart = {
>>> > +struct uart_driver sal_console_uart = {
>>> >   .owner = THIS_MODULE,
>>> >   .driver_name = "sn_console",
>>> >   .dev_name = DEVICE_NAME,
>>>
>>> Why can't you solve this without making sal_console_uart global?
>>
>> I think that would mean moving some of the structure initializaiton into an 
>> init function somewhere.
>
> Just make the tentative definition static.

And this is the complete patch:

Make sal_console_uart static again.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6/drivers/serial/sn_console.c.~1~	2005-04-25 00:33:34.000000000 +0200
+++ linux-2.6/drivers/serial/sn_console.c	2005-04-27 01:05:29.000000000 +0200
@@ -787,7 +787,7 @@ static void __init sn_sal_switch_to_inte
 
 static void sn_sal_console_write(struct console *, const char *, unsigned);
 static int __init sn_sal_console_setup(struct console *, char *);
-extern struct uart_driver sal_console_uart;
+static struct uart_driver sal_console_uart;
 extern struct tty_driver *uart_console_device(struct console *, int *);
 
 static struct console sal_console = {
@@ -801,7 +801,7 @@ static struct console sal_console = {
 
 #define SAL_CONSOLE	&sal_console
 
-struct uart_driver sal_console_uart = {
+static struct uart_driver sal_console_uart = {
 	.owner = THIS_MODULE,
 	.driver_name = "sn_console",
 	.dev_name = DEVICE_NAME,

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
