Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVFKK6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVFKK6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 06:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVFKK6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 06:58:32 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:5523 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261681AbVFKK6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 06:58:25 -0400
Date: Sat, 11 Jun 2005 12:56:57 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Cc: Andrew Hutchings <info@a-wing.co.uk>, linux-kernel@vger.kernel.org,
       vinay kumar <b4uvin@yahoo.co.in>, jgarzik@pobox.com
Subject: Re: sis190
Message-ID: <20050611105657.GA16351@electric-eye.fr.zoreil.com>
References: <33440948.1118482760126.JavaMail.www@wwinf0903>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33440948.1118482760126.JavaMail.www@wwinf0903>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal CHAPPERON <pascal.chapperon@wanadoo.fr> :
[...]
> Sorry, but it does not compile correctly if you define CONFIG_SIS190_NO_DELAY.

The safe choice is to not define it. I did not make it clear enough.

[...]
> I compared sis190_rx_interrupt() in old and new driver, and i tried :
>  diff -puN /usr/src/linux/drivers/net/sis190.c sis190.c
> --- /usr/src/linux/drivers/net/sis190.c 2005-06-11 09:16:41.000000000 +0200
> +++ sis190.c    2005-06-11 10:20:01.000000000 +0200
> @@ -478,7 +478,7 @@ static int sis190_rx_interrupt(struct ne
>                 rmb();
>                 status = le32_to_cpu(desc->PSize);
> 
> -               if (status & OWNbit)
> +               if (desc->status & OWNbit)
>                         break;
> 
>                 if (status & RxCRC) {

Good catch.

[...]
> I also tried without dhcp :
> # ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
>           inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
>           inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:59 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:43 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:4148 (4.0 KiB)  TX bytes:1806 (1.7 KiB)
>           Interrupt:10 Base address:0xbeef
> 
> ping failed both sides, though RX and TX counters were incremented.

Can you reproduce the tests (dhcp/no dhcp) with the patch linked below and
add a tcpdump -x output taken at the server as an addition to the usual
information ?

http://www.fr.zoreil.com/people/francois/misc/20050611a-2.6.12-rc-sis190-test.patch

If you are in a hurry and have any output, I'll look at it today (~18h).

Thanks.

--
Ueimor
