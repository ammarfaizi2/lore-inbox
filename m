Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUJFInQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUJFInQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUJFInQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:43:16 -0400
Received: from colino.net ([213.41.131.56]:55288 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S269093AbUJFInO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:43:14 -0400
Date: Wed, 6 Oct 2004 10:42:51 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S.Miller" <davem@davemloft.net>
Subject: Re: Netconsole & sungem: hang when link down
Message-ID: <20041006104251.29dcd38c@pirandello>
In-Reply-To: <1097050605.21132.17.camel@gaston>
References: <20041006083954.0abefe57@pirandello>
	<1097050605.21132.17.camel@gaston>
X-Mailer: Sylpheed-Claws 0.9.12cvs122.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Oct 2004 at 18h10, Benjamin Herrenschmidt wrote:

Hi, 

> On Wed, 2004-10-06 at 16:39, Colin Leroy wrote:
> > Hi,
> > 
> > I noticed that, if you have netconsole set up and using a sungem
> > card, and if the network cable is not plugged in, that the whole
> > kernel hangs shortly after the "device not up yet, forcing it"
> > netconsole message. I suspect this is due to the autoneg in sungem,
> > but didn't have time to look further. 
> > 
> > Would you have any hints on the cause of this problem?
> 
> Not sure, I suppose the driver is doing printk's with spinlocks held
> from the autoneg stuff and there is a spinlock deadlock happening ...

Thanks. I'll look into this. If I'm not mistaken, I've got no way of
catching it easily, do I ? CONFIG_DEBUG_SPINLOCK's help seems to say
that I need NMI watchdog in order to catch deadlocks, which is only
available on x86(_64).

-- 
Colin
