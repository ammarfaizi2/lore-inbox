Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUKSVn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUKSVn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbUKSVnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:43:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:3214 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261594AbUKSVmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:42:18 -0500
Date: Fri, 19 Nov 2004 13:32:32 -0800
From: Greg KH <greg@kroah.com>
To: brking@us.ibm.com
Cc: paulus@samba.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
Message-ID: <20041119213232.GB13259@kroah.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 02:23:22PM -0600, brking@us.ibm.com wrote:
> -static inline int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)
> -{
> -	return pci_bus_read_config_byte (dev->bus, dev->devfn, where, val);
> -}

Well, as much as I despise this patch, you should at least get it
correct :)

You need to block the pci_bus_* functions too, otherwise the parts of
the kernel that use them will stomp all over your device, right?

thanks,

greg k-h
