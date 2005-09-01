Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVIAXBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVIAXBt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 19:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbVIAXBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 19:01:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55201 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030508AbVIAXBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 19:01:48 -0400
Date: Thu, 1 Sep 2005 16:03:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: brking@us.ibm.com
Cc: greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       paulus@samba.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-Id: <20050901160356.2a584975.akpm@osdl.org>
In-Reply-To: <430B3CB4.1050105@us.ibm.com>
References: <41F7C6A1.9070102@us.ibm.com>
	<1106777405.5235.78.camel@gaston>
	<1106841228.14787.23.camel@localhost.localdomain>
	<41FA4DC2.4010305@us.ibm.com>
	<20050201072746.GA21236@kroah.com>
	<41FF9C78.2040100@us.ibm.com>
	<20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
	<41FFBDC9.2010206@us.ibm.com>
	<20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>
	<4200F2B2.3080306@us.ibm.com>
	<20050208200816.GA25292@kroah.com>
	<42B83B8D.9030901@us.ibm.com>
	<430B3CB4.1050105@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian King <brking@us.ibm.com> wrote:
>
> +void pci_block_user_cfg_access(struct pci_dev *dev)
> +{
> +	unsigned long flags;
> +
> +	pci_save_state(dev);
> +	spin_lock_irqsave(&pci_lock, flags);
> +	dev->block_ucfg_access = 1;
> +	spin_unlock_irqrestore(&pci_lock, flags);

Are you sure the locking in here is meaningful?  All it will really do is
give you a couple of barriers.

