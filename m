Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbQKLMSS>; Sun, 12 Nov 2000 07:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129947AbQKLMSI>; Sun, 12 Nov 2000 07:18:08 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29199 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129723AbQKLMSB>;
	Sun, 12 Nov 2000 07:18:01 -0500
Message-ID: <3A0E8A75.A1C24416@mandrakesoft.com>
Date: Sun, 12 Nov 2000 07:17:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
CC: "'LNML'" <linux-net@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2708E@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> So how come I get the "RTNL: assertion failed at
> devinet.c(775):inetdev_event" when I call register_netdevice without
> rtnl_lock/unlock ?

Uh.  Don't do that.  You MUST call register_netdevice with rtnl_lock
held.


> and what about rmmod causing the panic when I use unregister_netdev or never
> completing the operation when I use unregister_netdevice ?
> does module_exit run inside rtnl_lock too ?

module_exit does not run inside rtnl_lock.

Theoretically, if you call unregister_netdev from rmmon, it should grab
rtnl_lock and then complete the operation for you.  If that doesn't work
for you, it sounds like you are not setting up, or cleaning up,
something correctly.

Basically... it sounds like there are still bugs in your driver that
need working out :)

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
