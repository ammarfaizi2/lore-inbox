Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKLLs6>; Sun, 12 Nov 2000 06:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129239AbQKLLsr>; Sun, 12 Nov 2000 06:48:47 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:26897 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129055AbQKLLsc>; Sun, 12 Nov 2000 06:48:32 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2708E@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'LNML'" <linux-net@vger.kernel.org>,
        "'LKML'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: RE: catch 22 - porting net driver from 2.2 to 2.4
Date: Sun, 12 Nov 2000 03:48:22 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So how come I get the "RTNL: assertion failed at
devinet.c(775):inetdev_event" when I call register_netdevice without
rtnl_lock/unlock ?
could it be a 2.4.0-test9 thing ? (haven't used test10 or 11 yet).

and what about rmmod causing the panic when I use unregister_netdev or never
completing the operation when I use unregister_netdevice ?
does module_exit run inside rtnl_lock too ?


	Shmulik.

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
Sent: Thursday, November 09, 2000 7:37 PM
To: Hen, Shmulik
Cc: 'LNML'; 'LKML'; netdev@oss.sgi.com
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4


do_ioctl is inside rtnl_lock...

Remember if you need to alter the rules, you can always queue work in
the current context, and have a kernel thread handle the work.  The nice
thing about a kernel thread is that you start with a [almost] clean
state, when it comes to locks.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
