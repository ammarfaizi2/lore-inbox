Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUIOJ7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUIOJ7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIOJ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:59:23 -0400
Received: from barclay.balt.net ([195.14.162.78]:44496 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S264213AbUIOJ6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:58:53 -0400
Date: Wed, 15 Sep 2004 12:58:22 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Erik Tews <erik@debian.franken.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
Message-ID: <20040915095822.GA29719@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <20040913165551.GA24135@gemtek.lt> <4145D4ED.6070403@pobox.com> <20040913171649.GA24807@gemtek.lt> <1095236750.3960.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095236750.3960.23.camel@localhost.localdomain>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:25:50AM +0200, Erik Tews wrote:
> Am Mo, den 13.09.2004 schrieb Zilvinas Valinskas um 19:16:
> > On Mon, Sep 13, 2004 at 01:12:13PM -0400, Jeff Garzik wrote:
> > > I'm totally blind, because I don't see your network driver in that big 
> > > list of modules.
> > > 
> > > Your network driver should probably be doing dev_kfree_skb_any() 
> > > somewhere, but isn't.
> > > 
> > > 	Jeff
> > > 
> > It is compiled in, see :
> > 
> > CONFIG_E100=y
> > CONFIG_E100_NAPI=y
> > 
> > Can it be IPsec related ?
> 
> I got a similar problem here, I am running 2.6.9-rc2 with acpi patch. I
> got an e1000, ipsec is compiled in, modules loaded, racoon started but
> no tunnels configured.
> 
> The system freezes when I type apt-get update, in the moment apt-get
> tries to connect all the mirrors or resolves them.
That is the first impression I've got. When I rebooted back to 2.6.9-rc1 
I went through /var/log/kern.log and found messages I sent earlier. 

> 
> I did not see any messages, sysrq was not compiled in, so I cannot check
> if it still works.

In my cases, I've got a DHCP enabled, racoon running. If I set up policies 
via script :

#!/usr/sbin/setkey -f
flush;
spdflush;

spdadd 0.0.0.0 0.0.0.0[500] udp -P out none;
spdadd 0.0.0.0[500] 0.0.0.0 udp -P in none;

spdadd 192.168.3.3 192.168.3.2 any -P out ipsec
        esp/transport//require;

spdadd 192.168.3.2 192.168.3.3 any -P in ipsec
        esp/transport//require;

Mine laptop ip address is 192.168.3.3, and if I have 192.168.3.2 
connecting my laptop freezes ... Last linux kernel I used was 2.6.9-rc1-bk16 
and it was ok. 2.6.9-rc2 freezes laptop ...

Perhaps that is mixture of PREEMPT=y and ipsec ? dunno ...

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
