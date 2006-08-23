Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWHWQ4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWHWQ4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWHWQ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:56:19 -0400
Received: from mga07.intel.com ([143.182.124.22]:57879 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S965052AbWHWQ4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:56:18 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,161,1154934000"; 
   d="scan'208"; a="106607517:sNHT17306695"
Date: Wed, 23 Aug 2006 09:56:14 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Jeff Garzik <jgarzik@pobox.com>, Prakash Punnoor <prakash@punnoor.de>,
       Jiri Benc <jbenc@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
Message-ID: <20060823165614.GF10658@goober>
References: <20060816191139.5d13fda8@griffin.suse.cz> <20060816174329.GC17650@ojjektum.uhulinux.hu> <200608162002.06793.prakash@punnoor.de> <20060816195345.GA12868@ojjektum.uhulinux.hu> <20060819001640.GE20111@goober> <20060819061507.GB8571@ojjektum.uhulinux.hu> <44E721E1.2030203@pobox.com> <20060821090351.GB19425@ojjektum.uhulinux.hu> <20060823062821.GD10658@goober> <20060823091919.GA5806@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823091919.GA5806@ojjektum.uhulinux.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 11:19:19AM +0200, Pozsar Balazs wrote:
> 
> The funny thing is that it seems the _first_ phy_read call always 
> returns only when the 0x8000 bit is gone (I got this while loop from the 
> xircom_tulip driver).

That's pretty much the answer I was suspecting.  Sounds like the read
is doing some sort of flush.  Unfortunately I can't find any docs, so
I'd rather keep things as close to the old code as possible to avoid
breaking other cards.  Does something like this also work?

	udelay(500); /* Paranoia - phy_read() may be sufficient */
	if (phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000)
		printk("some useful error message");

-VAL
