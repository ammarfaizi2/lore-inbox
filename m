Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUJIU0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUJIU0l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUJIUYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:24:04 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:36803 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S267410AbUJIUWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:22:53 -0400
Message-ID: <4168479C.5080306@keyaccess.nl>
Date: Sat, 09 Oct 2004 22:18:36 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Zaitsev <zzz@anda.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] Something wrong with ISAPnP and serial driver
References: <20041010015206.A30047@natasha.ward.six>
In-Reply-To: <20041010015206.A30047@natasha.ward.six>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Zaitsev wrote:

> 1) The 2.6 kernel doesn't activate the ISA PnP modem at the boot,
>    while the 2.4 one always does.

2.4 used to scan the ISA PnP device ID string for some common substrings 
indicating a modem given a completely unknown ISA PnP device (the code 
is still present -- see drivers/serial/8250_pnp.c:check_name()) while 
2.6 really needs your modem's PnP ID to be listed.

> 2) The 8250 driver finds the PnP card's port, while the 8250_pnp finds
>    the non-PnP ports.

8250_pnp not finding it is therefore very likely a simple matter of it 
not knowing that it should be driving it. Try seeing if your modem's PnP 
ID (/sys/bus/pnp/devices/?/id) is listed in drivers/serial/8250_pnp.c 
and if not add it (and send as a patch to Russel King).

8250 itself finding it was no doubt due to you enabling the port 
yourself so that from its standpoint, it was just another serial port 
already present. With your modem's ID added, 8250_pnp should find and 
activate the mdem itself without you needing to do anything other than 
"modprobe 8250_pnp"

Hope that helps.

Rene.
