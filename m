Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbSKQJbB>; Sun, 17 Nov 2002 04:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbSKQJbA>; Sun, 17 Nov 2002 04:31:00 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9916 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267468AbSKQJbA>;
	Sun, 17 Nov 2002 04:31:00 -0500
Message-ID: <3DD76371.4060009@colorfullife.com>
Date: Sun, 17 Nov 2002 10:37:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ksardem@linux01.gwdg.de
CC: linux-kernel@vger.kernel.org, urban@teststation.com
Subject: Re: bug in via-rhine network-driver (transmit timed out)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>When I do a 'dmesg' I get these error-messages:
>
>NETDEV WATCHDOG: eth0: transmit timed out
>eth0: Transmit timed out, status 0000, PHY status 782d, resetting...
>eth0: reset did not complete in 10 ms.
>NETDEV WATCHDOG: eth0: transmit timed out
>
The tx_timeout code performs a full hardware reset to recover from 
hangs, but it seems that the nic hangs during the hardware reset :-(

The hang could be caused by incomplete tx underrun handling, the 
linuxfet driver resets several registers after a tx underrun.
Could you load the driver with debug=3? For example by adding 'options 
via-rhine debug=3' into your /etc/modules.conf?

If it hangs again, then send the dmesg messages to the mailing list - 
especially the last few lines before the first transmit timeout will help.

--
    Manfred

