Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266251AbUAGRJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUAGRJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:09:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266248AbUAGRJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:09:50 -0500
Date: Wed, 7 Jan 2004 17:09:44 +0000
From: Matthew Wilcox <willy@debian.org>
To: Eric Moore <emoore@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com
Subject: Re: [PATCH] 2.6.1-rc2 - MPT Fusion driver 3.00.00 update
Message-ID: <20040107170944.GI17182@parcelfarce.linux.theplanet.co.uk>
References: <3FFB4E0F.704@lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFB4E0F.704@lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 05:08:47PM -0700, Eric Moore wrote:
> +static struct pci_device_id mptbase_pci_table[] = {
> +    {
> +        .vendor        = PCI_VENDOR_ID_LSI_LOGIC,
> +        .device        = PCI_DEVICE_ID_LSI_FC909,
> +        .subvendor    = PCI_ANY_ID,
> +        .subdevice    = PCI_ANY_ID,
> +        .class        = PCI_CLASS_SERIAL_FIBER << 8,
> +        .class_mask    = 0xFFFF00,
> +        .driver_data    = DEVT_INDEX_MPT
> +    },

This is all pretty verbose.  The normal style for device drivers is:

static struct pci_device_id mptbase_pci_table[] = {
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC909,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC929,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC919,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC929X,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_FC919X,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_53C1030,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_53C1035,
		PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVT_INDEX_MPT },
	{ }
}

Although since you don't make any use of DEVT_INDEX_MPT, you can drop the last
three entries and simply write:

	{ PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_LSI_53C1035,
		PCI_ANY_ID, PCI_ANY_ID },

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
