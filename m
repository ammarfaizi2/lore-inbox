Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWE2JyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWE2JyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 05:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWE2JyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 05:54:08 -0400
Received: from gw.openss7.com ([142.179.199.224]:37830 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750787AbWE2JyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 05:54:07 -0400
Date: Mon, 29 May 2006 03:53:44 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Chava Leviatan <chavale@actcom.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet driver module compilation  (8139too)
Message-ID: <20060529035344.A25913@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Chava Leviatan <chavale@actcom.net.il>,
	linux-kernel@vger.kernel.org
References: <003101c682ff$1b7c7350$c400a8c0@Chavalaptop> <20060529021315.B23539@openss7.org> <023201c6830a$827539b0$c400a8c0@Chavalaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <023201c6830a$827539b0$c400a8c0@Chavalaptop>; from chavale@actcom.net.il on Mon, May 29, 2006 at 12:27:34PM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chava,

On Mon, 29 May 2006, Chava Leviatan wrote:

> Hi Brian,
> 
> I did reboot the machine, and saw that during boot time there is a call to 
> depmod.
> I did depmod -ae as you've requested, and here are the results:
>   [root@NettGain root]# depmod -ae >chav.dat
> depmod: /lib/modules/2.4.18-3/kernel/drivers/net/makefile.8139 is not an ELF 
> file
> depmod: /lib/modules/2.4.18-3/kernel/drivers/net/makefile.eepro is not an 
> ELF file
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18-3/kernel/drivers/net/8139too.o
> depmod:         __netdev_watchdog_up
> depmod:         flush_signals
...
...
> depmod:         mii_ethtool_gset
...
...
> 
> Please note that if I manually insmod mii , then the insmod 8139too passes 
> w/o problems .
> 

I don't see how it could with all those depmod errors.  Try doing
this:

 grep uregister_netdev /proc/ksyms

If you get something like this:

  c0194ef0 unregister_netdev_Rc45f34ea
  c01d5270 unregister_netdevice_notifier_Rfe769456
  c01d6ca0 unregister_netdevice_R52c1d940

then your kernel has versioned symbols.

In which case, you are probably missing

 -DMODVERSIONS -include linux/modversions.h

from your compile statement.

Hope that helps.

--brian
