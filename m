Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbULQXgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbULQXgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 18:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbULQXgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 18:36:14 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:27036 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262228AbULQXgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 18:36:11 -0500
Date: Sat, 18 Dec 2004 00:35:24 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Mark Broadbent <markb@wetlettuce.com>, linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.6.9-ac15 related to netconsole
Message-ID: <20041217233524.GA11202@electric-eye.fr.zoreil.com>
References: <59719.192.102.214.6.1103214002.squirrel@webmail.wetlettuce.com> <20041216211024.GK2767@waste.org> <34721.192.102.214.6.1103274614.squirrel@webmail.wetlettuce.com> <20041217215752.GP2767@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217215752.GP2767@waste.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> :
[...]
> Please try the attached untested, uncompiled patch to add polling to
> r8169:
[...]
> @@ -1839,6 +1842,15 @@
>  }
>  #endif
>  
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +static void rtl8169_netpoll(struct net_device *dev)
> +{
> +	disable_irq(dev->irq);
> +	rtl8169_interrupt(dev->irq, netdev, NULL);
                                    ^^^^^^ -> should be "dev"

The r8169 driver in -mm offers netpoll. A patch which syncs the r8169
driver from 2.6.10-rc3 with current -mm is available at:
http://www.fr.zoreil.com/people/francois/misc/20041218-2.6.10-rc3-r8169.c-test.patch

Please report success/failure. Cc: netdev@oss.sgi.com is welcome.

--
Ueimor
