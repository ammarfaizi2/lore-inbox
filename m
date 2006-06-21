Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWFUSrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWFUSrs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWFUSrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:47:47 -0400
Received: from es335.com ([67.65.19.105]:10088 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S932316AbWFUSrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:47:46 -0400
Subject: Re: [PATCH v3 1/7] AMSO1100 Low Level Driver.
From: Steve Wise <swise@opengridcomputing.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1150910013.3057.59.camel@laptopd505.fenrus.org>
References: <20060620203050.31536.5341.stgit@stevo-desktop>
	 <20060620203055.31536.15131.stgit@stevo-desktop>
	 <1150836226.2891.231.camel@laptopd505.fenrus.org>
	 <1150907571.31600.31.camel@stevo-desktop>
	 <1150910013.3057.59.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 13:47:45 -0500
Message-Id: <1150915665.20327.0.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ok pci posting...
> 
> basically, if you use writel() and co, the PCI bridges in the middle are
> allowed (and the more fancy ones do) cache the write, to see if more
> writes follow, so that the bridge can do the writes as a single burst to
> the device, rather than as individual writes. This is of course great...
> ... except when you really want the write to hit the device before the
> driver continues with other actions. 
> 
> Now the PCI spec is set up such that any traffic in the other direction
> (basically readl() and co) will first flush the write through the system
> before the read is actually sent to the device, so doing a dummy readl()
> is a good way to flush any pending posted writes.
> 
> Where does this matter? 
> it matters most at places such as irq enabling/disabling, IO submission
> and possibly IRQ acking, but also often in eeprom-like read/write logic
> (where you do manual clocking and need to do delays between the
> write()'s). But in general... any place where you do writel() without
> doing any readl() before doing nothing to the card for a long time, or
> where you are waiting for the card to do something (or want it done NOW,
> such as IRQ disabling) you need to issue a (dummy) readl() to flush
> pending writes out to the hardware.
> 
> 
> does this explanation make any sense? if not please feel free to ask any
> questions, I know I'm not always very good at explaining things.

Yep.  I get it.  I believe we're ok in this respect, but I'll review the
code again with an eye for this issue...

Steve.



