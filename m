Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUJIV61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUJIV61 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUJIV61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:58:27 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:3787 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S267452AbUJIV6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:58:25 -0400
Message-ID: <41685E04.3070103@keyaccess.nl>
Date: Sat, 09 Oct 2004 23:54:12 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Zaitsev <zzz@anda.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] Something wrong with ISAPnP and serial driver
References: <20041010015206.A30047@natasha.ward.six> <4168479C.5080306@keyaccess.nl> <20041010033820.B30047@natasha.ward.six>
In-Reply-To: <20041010033820.B30047@natasha.ward.six>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Zaitsev wrote:

> Ok, it isn't listed (USR0009).  I'll send a patch.  BTW, there is some
> other ID - /sys/devices/pnp1/01:01/card_id - and it contains USR0101.
> What's this?

The PnP card ID, with the USR0009 the PnP device ID; PnP cards can (and 
often do) have more than one device. For me, they are both the same:

$ cat /sys/devices/pnp1/01\:02/{card_,01\:02.00/}id
ETT0002
ETT0002

I do believe you need the device ID in 8250_pnp, but try the card ID 
when it doesn't work, I guess.

>>8250 itself finding it was no doubt due to you enabling the port 
>>yourself so that from its standpoint, it was just another serial port 
>>already present.
> 
> But why doesn't it find the two standard mb-embedded ports?  And why
> they are found by 8250_pnp?  Is it a normal behaviour?

That they are found by 8250_pnp seems okay; onboard ports are normally 
PnP BIOS devices -- the devices in /sys/devices/pnp0. However, normally 
the BIOS will have enabled those ports itself meaning 8250 would pick 
them up already, so no, that's not standard.

> Thanks.  But what about the incorrect info in /proc/tty/driver/serial?

Skipping that one. Maybe that will fix itself once you have the PnP ID 
listed.

Rene.

PS: CCing you, but gw.anda.ru seems to have decided I'm a spammer.
