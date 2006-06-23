Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWFWOEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWFWOEg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWFWOEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:04:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750713AbWFWOEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:04:34 -0400
Subject: Re: [PATCH v3 1/7] AMSO1100 Low Level Driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, mshefty@ichips.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1151071005.7808.39.camel@stevo-desktop>
References: <20060620203050.31536.5341.stgit@stevo-desktop>
	 <20060620203055.31536.15131.stgit@stevo-desktop>
	 <1150836226.2891.231.camel@laptopd505.fenrus.org>
	 <1151070290.7808.33.camel@stevo-desktop>
	 <1151070532.3204.10.camel@laptopd505.fenrus.org>
	 <1151071005.7808.39.camel@stevo-desktop>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:04:31 +0200
Message-Id: <1151071471.3204.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 08:56 -0500, Steve Wise wrote:
> On Fri, 2006-06-23 at 15:48 +0200, Arjan van de Ven wrote:
> > > > > +	/* Tell HW to xmit */
> > > > > +	__raw_writeq(cpu_to_be64(mapaddr), elem->hw_desc + C2_TXP_ADDR);
> > > > > +	__raw_writew(cpu_to_be16(maplen), elem->hw_desc + C2_TXP_LEN);
> > > > > +	__raw_writew(cpu_to_be16(TXP_HTXD_READY), elem->hw_desc + C2_TXP_FLAGS);
> > > > 
> > > > or here
> > > > 
> > > 
> > > No need here.  This logic submits the packet for transmission.  We don't
> > > assume it is transmitted until we (after a completion interrupt usually)
> > > read back the HTXD entry and see the TXP_HTXD_DONE bit set (see
> > > c2_tx_interrupt()). 
> > 
> > ... but will that interrupt happen at all if these 3 writes never hit
> > the hardware?
> > 
> 
> I thought the posted write WILL eventually get to adapter memory.  Not
> stall forever cached in a bridge.  I'm wrong?

I'm not sure there is a theoretical upper bound.... 

(and if it's several msec per bridge, then you have a lot of latency
anyway)

