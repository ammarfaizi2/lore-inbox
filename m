Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTKBThx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 14:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTKBThx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 14:37:53 -0500
Received: from adsl-ull-75-87.42-151.net24.it ([151.42.87.75]:49924 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261786AbTKBThw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 14:37:52 -0500
Date: Sun, 2 Nov 2003 20:16:08 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sorceforge.net
Subject: Re: [PATCH] Add PM support to sis900 network driver
Message-ID: <20031102191608.GF18017@picchio.gall.it>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, mochel@osdl.org,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sorceforge.net
References: <20031102182852.GC18017@picchio.gall.it> <20031102111254.481bcbfd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102111254.481bcbfd.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 11:12:54AM -0800, Andrew Morton wrote:
> >  +	spin_lock_irqsave(&sis_priv->lock, flags);
> >  +
> >  +	/* Stop the chip's Tx and Rx Status Machine */
> >  +	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
> >  +	
> >  +	pci_set_power_state(pci_dev, 3);
> 
> pci_set_power_state() can sleep, so we shouldn't be calling it
> under spin_lock_irqsave().  Is it necessary to hold the lock
> here?

I don't know enough of the driver to express an opinion, but probably
the lock is needed only for the outl call,  if needed at all. If nothing
new comes out, tomorrow I'll rediff and send a new patch.

-- 
------------------------------
Daniele Venzano
Web: http://teg.homeunix.org
