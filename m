Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbULJVuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbULJVuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbULJVuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:50:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:4570 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261830AbULJVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:49:59 -0500
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kylene Hall <kjhall@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com, sailer@watson.ibm.com, leendert@watson.ibm.com,
       emilyr@us.ibm.com, toml@us.ibm.com, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102607309.2784.40.camel@laptop.fenrus.org>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102607309.2784.40.camel@laptop.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102711541.3264.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Dec 2004 20:45:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-09 at 15:48, Arjan van de Ven wrote:
> > +	/* wait for status */
> > +	add_timer(&status_timer);
> > +	do {
> > +		schedule();
> > +		status = inb(chip->base + NSC_STATUS);
> > +		if (status & NSC_STATUS_OBF)
> > +			status = inb(chip->base + NSC_DATA);
> > +		if (status & NSC_STATUS_RDY) {
> > +			del_singleshot_timer_sync(&status_timer);
> > +			return 0;
> > +		}
> > +	} while (!expired);
> 
> same comment. Also the timer handling looks suspect... can you guarantee
> 100% sure that the timer is gone when the while falls through ?

Yes but you can't be sure it ever will - needs an "rmb()" barrier so
that the compiler doesn't sneak off and optimise expired


