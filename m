Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbULTJmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbULTJmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbULTJmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:42:45 -0500
Received: from piglet.wetlettuce.com ([82.68.149.69]:23936 "EHLO
	piglet.wetlettuce.com") by vger.kernel.org with ESMTP
	id S261336AbULTJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:42:43 -0500
Message-ID: <36901.192.102.214.6.1103535728.squirrel@webmail.wetlettuce.com>
Date: Mon, 20 Dec 2004 09:42:08 -0000 (GMT)
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
From: "Mark Broadbent" <markb@wetlettuce.com>
To: <romieu@fr.zoreil.com>
In-Reply-To: <20041217233524.GA11202@electric-eye.fr.zoreil.com>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com>
        <20041216211024.GK2767@waste.org>
        <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com>
        <20041217215752.GP2767@waste.org>
        <20041217233524.GA11202@electric-eye.fr.zoreil.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <mpm@selenic.com>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Reply-To: markb@wetlettuce.com
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Mail is clear of Viree
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Francois Romieu said:
> Matt Mackall <mpm@selenic.com> :
> [...]
>> Please try the attached untested, uncompiled patch to add polling to
>> r8169:
> [...]
>> @@ -1839,6 +1842,15 @@
>>  }
>>  #endif
>>
>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>> +static void rtl8169_netpoll(struct net_device *dev)
>> +{
>> +	disable_irq(dev->irq);
>> +	rtl8169_interrupt(dev->irq, netdev, NULL);
>                                    ^^^^^^ -> should be "dev"
>
> The r8169 driver in -mm offers netpoll. A patch which syncs the r8169
> driver from 2.6.10-rc3 with current -mm is available at:
> http://www.fr.zoreil.com/people/francois/misc/20041218-2.6.10-rc3-r8169.c-test.patch>
> Please report success/failure. Cc: netdev@oss.sgi.com is welcome.

Exactly the same happens, I still get a 'NMI Watchdog detected LOCKUP'
with the r8169 device using the above patch on top of 2.6.10-rc3-bk10.
Thanks
Mark

-- 
Mark Broadbent <markb@wetlettuce.com>
Web: http://www.wetlettuce.com



