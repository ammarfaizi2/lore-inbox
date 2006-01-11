Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWAKT35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWAKT35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAKT35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:29:57 -0500
Received: from mail.dvmed.net ([216.237.124.58]:52437 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932438AbWAKT34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:29:56 -0500
Message-ID: <43C55CAD.90609@pobox.com>
Date: Wed, 11 Jan 2006 14:29:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Sbitnev <nwshuras@dezcom.mephi.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: SX8 stability issue
References: <204883.20060111160652@dezcom.mephi.ru>
In-Reply-To: <204883.20060111160652@dezcom.mephi.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alexander Sbitnev wrote: > Working with Promise SX8
	card for a while we still can't get NCQ > working stable for both
	original promise and vanilla kernel drivers. > We using latest firmware
	1.00.0.37 and kernels from 2.6.8 up to 2.6.15. > Problems occured at
	least on two different hardware platforms. > We don't played with
	max_queue option (or it's header file analog value) yet, > keeping it
	on default value. > Controller work almost stable while NCQ option
	disabled in BIOS. > Once feature enabled in BIOS the system become
	hanging on IO with next > error messages appearing in the kernel log: >
	> syslog.0:Jan 10 23:30:57 cell kernel: sx8(0000:01:06.0): unhandled
	event type 16 > syslog.0:Jan 10 23:31:18 cell kernel:
	sx8(0000:01:06.0): unhandled event type 16 > syslog.0:Jan 10 23:31:40
	cell kernel: sx8(0000:01:06.0): unhandled event type 16 > syslog.0:Jan
	10 23:32:01 cell kernel: sx8(0000:01:06.0): unhandled event type 16 >
	syslog.0:Jan 10 23:32:18 cell kernel: end_request: I/O error, dev
	sx8/0, sector 220064 > syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O
	error on device sx8/0, logical block 27508 > syslog.0:Jan 10 23:32:18
	cell kernel: lost page write due to I/O error on sx8/0 > syslog.0:Jan
	10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical
	block 27509 > syslog.0:Jan 10 23:32:18 cell kernel: lost page write due
	to I/O error on sx8/0 > syslog.0:Jan 10 23:32:18 cell kernel: Buffer
	I/O error on device sx8/0, logical block 27510 > > We don't really sure
	this problem is a 100% linux related, but it is > still persist after
	big hardware upgrade (From dual Pentium III to > Dual Opteron based
	system recomended for this controller). [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Sbitnev wrote:
>   Working with Promise SX8 card for a while we still can't get NCQ
> working stable for both original promise and vanilla kernel drivers.
> We using latest firmware 1.00.0.37 and kernels from 2.6.8 up to 2.6.15.
> Problems occured at least on two different hardware platforms.
> We don't played with max_queue option (or it's header file analog value) yet,
> keeping it on default value.
> Controller work almost stable while NCQ option disabled in BIOS.
> Once feature enabled in BIOS the system become hanging on IO with next
> error messages appearing in the kernel log:
> 
> syslog.0:Jan 10 23:30:57 cell kernel: sx8(0000:01:06.0): unhandled event type 16
> syslog.0:Jan 10 23:31:18 cell kernel: sx8(0000:01:06.0): unhandled event type 16
> syslog.0:Jan 10 23:31:40 cell kernel: sx8(0000:01:06.0): unhandled event type 16
> syslog.0:Jan 10 23:32:01 cell kernel: sx8(0000:01:06.0): unhandled event type 16
> syslog.0:Jan 10 23:32:18 cell kernel: end_request: I/O error, dev sx8/0, sector 220064
> syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical block 27508
> syslog.0:Jan 10 23:32:18 cell kernel: lost page write due to I/O error on sx8/0
> syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical block 27509
> syslog.0:Jan 10 23:32:18 cell kernel: lost page write due to I/O error on sx8/0
> syslog.0:Jan 10 23:32:18 cell kernel: Buffer I/O error on device sx8/0, logical block 27510
> 
>   We don't really sure this problem is a 100% linux related, but it is
> still persist after big hardware upgrade (From dual Pentium III to
> Dual Opteron based system recomended for this controller).

Well, the in-kernel sx8 driver does not use NCQ at all, so you would 
have to have modified the driver to turn it on.  Presumably this means 
there is a bug in your modifications?


>   Maybe it is not right way at all to turn NCQ in BIOS? Мауве we must
> just increase max_queue parameter while keeping NCQ in BIOS disabled?

This is the best first step...

	Jeff


